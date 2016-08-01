//
//  XMGPushGuideView.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGPushGuideView.h"

@implementation XMGPushGuideView

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show {
    
    NSString *key = @"CFBundleShortVersionString";
    
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        XMGPushGuideView *guideView = [XMGPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (IBAction)close {
    [self removeFromSuperview];
}

@end
