//
//  XMGRecommendViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGRecommendCategory.h"
#import "XMGRecommendCategoryCell.h"
#import "XMGRecommendUserCell.h"
#import "XMGRecommendViewController.h"
#import "XMGRecommentUser.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>

#define XMGSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface XMGRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/**
 *  右边的用户表格
 */
@property (weak, nonatomic) IBOutlet UITableView* userTableView;
/**
 *  左边的类别数据
 */
@property (nonatomic, strong) NSArray* categories;
/**
 *  左边的类别表格
 */
@property (weak, nonatomic) IBOutlet UITableView* categoryTableView;
/**
 *  请求参数
 */
@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation XMGRecommendViewController

static NSString* const XMGCategoryID = @"category";

static NSString* const XMGUserId = @"user";

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //控件的初始化
    [self setUpTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧的类别数据
    [self loadCategories];

   
}

/**
 * 加载左侧的类别数据
 */
- (void)loadCategories {
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        self.categories = [XMGRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
        
//        //隐藏指示器
//        [SVProgressHUD dismiss];
    }
              failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
                  
                  //显示失败信息
                  [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
              }];
}

/**
 *  添加新控件
 */
- (void)setupRefresh {
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.footer.hidden = YES;
}

#pragma mark - 加载用户数据
- (void)loadNewUsers {
    XMGRecommendCategory *rc = XMGSelectedCategory;
    
    //设置当前页码为1
    rc.currentPage = 1;
    
    //请求参数
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    //发送请求给服务器，加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
        
        //字典数组->模型数组
        NSArray* users = [XMGRecommentUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有旧数据
        [rc.users removeAllObjects];
        
        //添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if (self.params != params) {
            return ;
        }
        
        
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.header endRefreshing];
        
        //让底部控件结束刷新
        [self checkFooterState];
    }failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
        if (self.params != params) {
            return;
        }
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //结束刷新
        [self.userTableView.header endRefreshing];
    }];
}

- (void)loadMoreUsers {
    
    XMGRecommendCategory *category = XMGSelectedCategory;
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([category id]);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
        //字典数组->模型数组
        NSArray* users = [XMGRecommentUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        if (self.params != params) {
            return;
        }
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    }failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
        if (self.params != params) {
            return;
        }
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //让底部控件结束刷新
        [self.userTableView.footer endRefreshing];
    }];
}

/**
 *  控件的初始化
 */
- (void)setUpTableView
{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:XMGCategoryID];

    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XMGUserId];

    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    //设置标题
    self.title = @"推荐关注";

    //设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  时刻监测footer的状态
 */
- (void)checkFooterState {
    XMGRecommendCategory *rc = XMGSelectedCategory;
    
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.footer.hidden = (rc.users.count == 0);
   
    //让底部控件结束刷新
    if(rc.users.count == rc.total) {
        [self.userTableView.footer noticeNoMoreData];
    }else {
        [self.userTableView.footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {//左边的类别表格
        return self.categories.count;
    }
    //监测footer的状态
    [self checkFooterState];
    //右边的用户表格
    return [XMGSelectedCategory users].count;
    
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    if (tableView == self.categoryTableView) { //左边的类别表格
        XMGRecommendCategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryID];
        cell.category = self.categories[indexPath.row];

        return cell;
    }
    else { //右边的用户表格
        XMGRecommendUserCell* cell = [tableView dequeueReusableCellWithIdentifier:XMGUserId];
       
        cell.user = [XMGSelectedCategory users][indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    //结束刷新
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    
    XMGRecommendCategory* c = self.categories[indexPath.row];
    
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    }
    else {
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
    }
}

#pragma mark - 控件器的销毁
- (void)dealloc {
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}
@end
