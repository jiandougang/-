//
//  XMGFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGFriendTrendsViewController.h"
#import "XMGRecommendViewController.h"
#import "XMGLoginRegisterViewController.h"

@interface XMGFriendTrendsViewController ()

@end

@implementation XMGFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];

    //设置背景色
    self.view.backgroundColor = XMGGlobalBg;
    
}

- (void)friendsClick {
    XMGRecommendViewController *vc = [[XMGRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegister {
    XMGLoginRegisterViewController *login = [[XMGLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}


@end
