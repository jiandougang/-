//
//  XMGRecommendCategory.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendCategory : NSObject
/**
 *  id
 */
@property (nonatomic, assign) NSInteger id;
/**
 *  总数
 */
@property (nonatomic, assign) NSInteger count;
/**
 *  名字
 */
@property (nonatomic, copy) NSString* name;
/**
 *  这个类别对应的用户数据
 */
@property (nonatomic, strong) NSMutableArray *users;
/**
 *  总数
 */
@property (nonatomic, assign) NSInteger total;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;

@end
