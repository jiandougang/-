//
//  XMGRecommentUser.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommentUser : NSObject
/**
 *  头像
 */
@property (nonatomic, copy) NSString *header;
/**
 * 粉丝数（有多少人关注这个用户）
 */
@property (nonatomic, assign) NSInteger fans_count;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *screen_name;
@end
