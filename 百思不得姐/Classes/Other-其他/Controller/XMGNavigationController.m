//
//  XMGNavigationController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGNavigationController.h"

@implementation XMGNavigationController

/**
 *  当第一次使用这个类的时候会调用一次
 */
+ (void)initialize {
    //当导航栏用在XMGNavigationController中，appearance设置才会生效
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
     UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage: [UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   
}

- (void)pushViewController:(UIViewController*)viewController
                  animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"]
                forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"]
                forState:UIControlStateHighlighted];
        button.size = CGSizeMake(100, 30);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        button.backgroundColor = [UIColor redColor];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem =
            [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //这句super的push要放在后面，让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:YES];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}
@end
