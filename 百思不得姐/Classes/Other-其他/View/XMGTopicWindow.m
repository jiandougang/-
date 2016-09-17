//
//  XMGTopicWindow.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGTopicWindow.h"


@implementation XMGTopicWindow

static UIWindow *window_;

+ (void)initialize {
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, XMGScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show {

    window_.hidden = NO;
}

+ (void)hide {
    window_.hidden = YES;
}

/**
 *监听窗口点击
 */
+ (void)windowClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superView {
    for (UIScrollView *subview in superView.subviews) {
        
        //如果是scrollview,滚动最顶部
        if ([superView isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = -subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        //继续查找控件
        [self searchScrollViewInView:superView];
    }
}
@end
