//
//  XMGRecommendCategory.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGRecommendCategory.h"
#import <MJExtension.h>

@implementation XMGRecommendCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users {
    if(!_users) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end
