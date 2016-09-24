//
//  XMGMeViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGMeFooterView.h"
#import "XMGMeCell.h"

@interface XMGMeViewController ()

@end

@implementation XMGMeViewController

static NSString *XMGMeId = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
    
}

- (void)setupTableView{
    //设置背景色
    self.tableView.backgroundColor = XMGGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.tableView registerClass:[XMGMeCell class] forCellReuseIdentifier:XMGMeId];
    
    //调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = XMGTopicCellMargin;
    
    //调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(XMGTopicCellMargin - 35, 0, 0, 0);
    
    //设置footerView
    self.tableView.tableFooterView = [[XMGMeFooterView alloc] init];
}

- (void)setupNav{
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏左边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(mooonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
}

- (void)settingClick {
    XMGLog(@"%s",__func__);
}

- (void)mooonClick {
    XMGLog(@"%s",__func__);
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me"];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
    }else if(indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
@end
