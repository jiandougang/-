//
//  XMGCommentViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGCommentViewController.h"
#import "XMGTopic.h"
#import "XMGTopicCell.h"
#import "XMGComment.h"
#import "XMGCommentHeaderView.h"
#import "XMGCommentCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>

static NSString * const XMGCommentId = @"comment";

@interface XMGCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  保存帖子的top_cmt
 */
@property(nonatomic, strong) XMGComment *save_top_cmt;

/**
 *  最热评论
 */
@property (nonatomic, strong) NSArray *hotComments;
/**
 *  最新评论
 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/**
 *  保存当前的页码
 */
@property (nonatomic, assign) NSInteger page;
/**
 *  管理者
 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation XMGCommentViewController

- (AFHTTPSessionManager *)manager {
    if (_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
    
}

- (void)setupRefresh {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.footer.hidden = YES;
}

- (void)loadMoreComments {
    //结束之前所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //页码
    NSInteger page = self.page;
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    XMGComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
   
        
        //最新评论
        NSArray *newComments = [XMGComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        //页码
        self.page = page;
        
        //刷新数据
        [self.tableView reloadData];
        //结束刷新状态
        [self.tableView.header endRefreshing];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if(self.latestComments.count >= total){//全部加载完毕
            self.tableView.footer.hidden = YES;
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.header endRefreshing];
        
    }];
}

- (void)loadNewComments {
    //结束之前所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最热评论
        self.hotComments = [XMGComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.latestComments = [XMGComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //页码
        self.page = 1;
        
        //刷新数据
        [self.tableView reloadData];
       
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if(self.latestComments.count >= total){//全部加载完毕
            self.tableView.footer.hidden = YES;
        
        }else {
            //结束刷新
            [self.tableView.header endRefreshing];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.header endRefreshing];
        
    }];
}

- (void)setupHeader {

    //创建header
    UIView *header = [[UIView alloc] init];
    
    //清空top_cmt
    if (self.topic.top_cmt) {
        self.save_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
//        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
  
    
    //添加cell
    XMGTopicCell *cell = [XMGTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(XMGScreenW, XMGScreenH);
    [header addSubview:cell];
    
    //header 的高度
    header.height = self.topic.cellHeight + XMGTopicCellMargin;
    
    //设置header
    self.tableView.tableHeaderView = header;
    

    
}

- (void)setupBasic {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //背景色
    self.tableView.backgroundColor = XMGGlobalBg;
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentCell class]) bundle:nil] forCellReuseIdentifier:XMGCommentId];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, XMGTopicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    //键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomSpace.constant = XMGScreenH - frame.origin.y;
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //恢复帖子的top_cmt
    if (self.save_top_cmt) {
        self.topic.top_cmt = self.save_top_cmt;
//        [self.topic setValue:@0 forKey:@"cellHeght"];
    }
    
    [self.manager invalidateSessionCancelingTasks:YES];
}

/**
 *  返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    
    return self.latestComments;
}

- (XMGComment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) {
        return 2;//有“最热评论” + “最新评论” 2组
    }
    
    if (latestCount) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    //隐藏尾部控件
    tableView.footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    //非第0组
    return latestCount;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *ID = @"header";
    //先从缓存池中找header
    XMGCommentHeaderView *header = [XMGCommentHeaderView headerViewWithTableView:tableView];
    
    if (header == nil) {
        header = [[XMGCommentHeaderView alloc] initWithReuseIdentifier:ID];
        
    }
    
    //设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    }else {
        header.title  = @"最新评论";
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCommentId];
 
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

@end
