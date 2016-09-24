 //
//  XMGMeFooterView.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGMeFooterView.h"
#import "XMGSquare.h"
#import "XMGSquareButton.h"
#import "XMGWebViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>

@implementation XMGMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        

        //参数
        NSMutableDictionary *parms = [NSMutableDictionary dictionary];
        parms[@"a"] = @"square";
        parms[@"c"] = @"topic";
        
        //发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parms success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *sqaures = [XMGSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            //创建方块
            [self createSquares:sqaures];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
    
    return self;
}

/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)sqaures {
    //一行最多4列
    int maxCols = 4;
    
    //宽度和高度
    CGFloat buttonW = XMGScreenW / maxCols;
    CGFloat buttonH = buttonW ;
    
    for (int i = 0; i < sqaures.count; i++) {
        //创建按钮
        XMGSquareButton *button = [XMGSquareButton buttonWithType:UIButtonTypeCustom];
        //监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        //计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;

    }
    
    //总行数(公式)
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
   
    //计算footer的高度
    self.height = rows * buttonH;
    
    //重做
    [self setNeedsDisplay];
}

- (void)buttonClick:(XMGSquareButton *)button{
    
    XMGLog(@"%@",button.square.url);

    if (![button.square.url hasPrefix:@"http"]) {
        return;
    }

    
    XMGWebViewController *web = [[XMGWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    //取出当前的导航控件器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}

//设置背景图片
//- (void)drawRect:(CGRect)rect {
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}

@end
