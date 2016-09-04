//
//  XMGComment.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMGUser;
@interface XMGComment : NSObject

/**
 *  音频文件的时长
 */
@property (nonatomic, assign) NSInteger voicetime;
/**
 *  评论的文字内容
 */
@property (nonatomic, copy) NSString *content;
/**
 *  被点赞的数量
 */
@property (nonatomic, assign) NSInteger like_count;
/**
 *  用户
 */
@property (nonatomic, strong) XMGUser *user;
@end
