//
//  XMGRecommendViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGRecommendCategory.h"
#import "XMGRecommendCategoryCell.h"
#import "XMGRecommendViewController.h"
#import "XMGRecommendUserCell.h"
#import "XMGRecommentUser.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface XMGRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/**
 *  右边的用户表格
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**
 *  左边的类别数据
 */
@property (nonatomic, strong) NSArray* categories;
/**
 *  右边的用户数据
 */
@property (nonatomic, strong) NSArray* users;

/**
 *  左边的类别表格
 */
@property (weak, nonatomic) IBOutlet UITableView* categoryTableView;
@end

@implementation XMGRecommendViewController

static NSString * const XMGCategoryID = @"category";

static NSString * const XMGUserId = @"user";

- (void)viewDidLoad
{
    [super viewDidLoad];

    //控件的初始化
    [self setUpTableView];

    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    //发送请求
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {

        [SVProgressHUD dismiss];

        self.categories = [XMGRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];

        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

        //隐藏指示器
        [SVProgressHUD dismiss];
    }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {

            //显示失败信息
            [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
        }];
}

- (void)setUpTableView {
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

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView){
        return self.categories.count;
    }else{
        return self.users.count;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    if (tableView == self.categoryTableView) {//左边的类别表格
        XMGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryID];
        cell.category = self.categories[indexPath.row];

        return cell;

        
    }else {//右边的用户表格 
        XMGRecommendUserCell* cell = [tableView dequeueReusableCellWithIdentifier:XMGUserId];
        cell.user = self.users[indexPath.row];
        return cell;

    }



}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    XMGRecommendCategory* c = self.categories[indexPath.row];
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
        self.users = [XMGRecommentUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.userTableView reloadData];
    }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error){

        }];
}
@end
