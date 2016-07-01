//
//  XMGMeViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGMeViewController.h"

@interface XMGMeViewController ()

@end

@implementation XMGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏左边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(mooonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    //设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

- (void)settingClick {
    XMGLog(@"%s",__func__);
}

- (void)mooonClick {
    XMGLog(@"%s",__func__);
}

@end
