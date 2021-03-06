//
//  XMGTabBar.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGTabBar.h"
#import "XMGPublishView.h"

@interface XMGTabBar()

/** 发布按钮*/
@property (nonatomic, weak ) UIButton *publishButton;

@end

@implementation XMGTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        //设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //添加发布按钮
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick{
    XMGPublishView *publish = [XMGPublishView publishView];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    publish.frame = window.bounds;
    [window addSubview:publish];
}

 - (void)layoutSubviews {
    [super layoutSubviews];
     
     //标记按钮是否已经添加过监听器
     static BOOL added = NO;
     
     CGFloat width = self.width;
     CGFloat height = self.height;

    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
     //设置其他UITabBarButton的frame
     CGFloat buttonY = 0;
     CGFloat buttonW = self.width / 5;
     CGFloat buttonH = self.height;
     NSInteger index = 0;
     for (UIControl *button in self.subviews) {
         if (![button isKindOfClass:[UIControl class]] ||
             button == self.publishButton
             )  {
             continue;
         }
         //计算按钮的x值
         CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
         button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
         //增加索引
         index++;
         
         //监听按钮点击
         if (added == NO) {
                 [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
         }
     
    }
     
     added = YES;
}

- (void)buttonClick {
    //发出一个通知
    [XMGNoteCenter postNotificationName:XMGTabBarDidSelectNotification object:nil userInfo:nil];
}

@end
