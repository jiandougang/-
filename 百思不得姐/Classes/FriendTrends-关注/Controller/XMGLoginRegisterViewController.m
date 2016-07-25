//
//  XMGLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"

@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation XMGLoginRegisterViewController

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];

//    //文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    
//    //NSAttrbutedString : 带有属性的文字（富文本技术）
//    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号123" attributes:attrs];
//    self.phoneField.attributedPlaceholder = placeholder;
}
- (IBAction)showLoginOrRegister:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {//显示注册界面
        self.loginViewLeftMargin.constant = -self.view.width;
        button.selected = YES;
//        [button setTitle:@"已有帐号" forState:UIControlStateNormal];
    }else {//显示登录界面
        self.loginViewLeftMargin.constant = 0;
//        [button setTitle:@"注册帐号" forState:UIControlStateNormal];
        button.selected = NO;

    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
