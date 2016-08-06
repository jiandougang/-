//
//  XMGWordViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGWordViewController.h"
#import "AFNetworking.h"
#import "XMGTopic.h"
#import "XMGTopicCell.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface XMGWordViewController ()
/**
 *  贴子数据
 */
@property (nonatomic, strong) NSMutableArray *topics;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger page;
/**
 *  当加载下一页数据时需要这个参数
 */
@property (nonatomic ,copy) NSString *maxtime;

@property (nonatomic, strong) NSDictionary *params;
@end

@implementation XMGWordViewController

- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
   
}

static NSString * const XMGTopicCellId = @"topic";
- (void) setupTableView {
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = XMGTitlesViewY + XMGTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellId];
}

/**
 *  添加刷新控件
 */
#pragma clang diagnostic ignored "-Wdeprecated"
- (void)setupRefresh {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:
                             @selector(loadMoreTopics)];
}

#pragma mark -数据处理
/**
 *  加载新的贴子数据
 */
- (void)loadNewTopic {
    //结束上拉
    [self.tableView.footer endRefreshing];
 
    //参数
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"list";
    parms[@"c"] = @"data";
    parms[@"type"] = @"29";
    self.params = parms;

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parms success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != _params) {
            return ;
        }
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典 ->模型
        self.topics = [XMGTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.header endRefreshing];
        
        //页码
        self.page = 0;
        XMGLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != _params) {
            return ;
        }
        //结束刷新
        [self.tableView.header endRefreshing];

        
    }];
}

/**
 *  加载更多的帖子数据
 */
- (void)loadMoreTopics {
    
    //结束下拉
    [self.tableView.header endRefreshing];
    
    //参数
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"list";
    parms[@"c"] = @"data";
    parms[@"type"] = @"29";
    NSInteger page = self.page + 1;
    parms[@"page"] = @(page);
    parms[@"maxtime"] = self.maxtime;
    self.params = parms;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parms success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != _params) {
            return ;
        }
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];

        //字典 ->模型
        NSArray *newTopics = [XMGTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.footer endRefreshing];
        XMGLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != _params) {
            return ;
        }
        
        //结束刷新
        [self.tableView.footer endRefreshing];
        
        //恢复页码
        self.page--;
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.tableView.footer.hidden = self.topics.count == 0;
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId];
    
    XMGTopic *topic = self.topics[indexPath.row];
    [cell setTopic:topic];
//    cell.textLabel.text = topic.name;
//    cell.detailTextLabel.text = topic.text;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200; 
}

//13825563483
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
