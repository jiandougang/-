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
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:nil action:nil];
};

- (void)tagClick {
    XMGLog(@"%s",__func__);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = XMGRGBCorlor(200, 100, 50);
    [self.navigationController pushViewController:vc animated:YES];
}
@end
