//
//  XMGEssenceViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGEssenceViewController.h"

@interface XMGEssenceViewController ()

@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick-click" target:self action:@selector(tagClick)];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"mainCellDing" highImage:@"mainCellDingClick" target:nil action:nil];
    
    //设置背景色
    self.view.backgroundColor = XMGGlobalBg;
};

- (void)tagClick {
    XMGLog(@"%s",__func__);
}

@end
