//
//  XMGRecommendTag.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendTag : NSObject
/**
 *  图片
 */
@property (nonatomic, copy) NSString *image_list;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *theme_name;
/**
 *  订阅数
 */
@property (nonatomic, assign) NSInteger sub_number;
@end
