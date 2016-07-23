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

@end

@implementation XMGLoginRegisterViewController


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
