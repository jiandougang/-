//
//  XMGRecommendViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface XMGRecommendViewController ()

@end

@implementation XMGRecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"推荐关注";

    //设置背景色
    self.view.backgroundColor = XMGGlobalBg;
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    //发送请求
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
        XMGLog(@"%@", responseObject);
        
        //隐藏指示器
        [SVProgressHUD dismiss];
    }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error){

            //显示失败信息
            [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
        }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
