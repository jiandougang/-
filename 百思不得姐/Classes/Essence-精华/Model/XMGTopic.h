//
//  XMGTopic.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGTopic : NSObject
/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *profile_image;
/**
 *  发贴时间
 */
@property (nonatomic, copy) NSString *create_time;
/**
 *  文字内幕
 */
@property (nonatomic, copy) NSString *text;
/**
 *  顶的数量
 */
@property (nonatomic, copy) NSString *ding;
/**
 *  踩的数量
 */
@property (nonatomic, copy) NSString *cai;
/**
 *  评论的数量
 */
@property (nonatomic, assign) NSInteger comment;
@end
