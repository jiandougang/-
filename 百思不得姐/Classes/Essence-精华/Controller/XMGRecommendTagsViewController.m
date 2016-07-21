//
//  XMGRecommendTagsViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGRecommendTagsViewController.h"
#import "XMGRecommendTag.h"
#import "XMGRecommentUser.h"
#import "XMGRecommendTagCell.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <AFNetworking.h>

@interface XMGRecommendTagsViewController ()

@property (nonatomic, strong) NSArray *tags;

@end

static NSString *const XMGTagsId = @"tag";

@implementation XMGRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
}

- (void)loadTags {
    //发送请求
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.tags = [XMGRecommendTag objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败！"];
    }];
}

- (void)setupTableView {
    self.title = @"推荐标签";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:XMGTagsId];
    
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = XMGGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTagsId];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end
