//
//  XMGTopic.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGTopic : NSObject
/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  头像URL
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
@property (nonatomic, assign) NSInteger  ding;
/**
 *  踩的数量
 */
@property (nonatomic, assign) NSInteger  cai;
/**
 *  转发的数量
 */
@property (nonatomic, assign) NSInteger repost;
/**
 *  评论的数量
 */
@property (nonatomic, assign) NSInteger comment;
/**
 *  是否为新浪加V用户
 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/**
 *  图片的宽度
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  图片的高度
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  图片的URL
 */
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *large_image;
@property (nonatomic, copy) NSString *middle_image;
@property (nonatomic, assign) XMGTopicType type;

/*****************额外的辅助属性************************/
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/**
 *  图片控件的frame
 */
@property (nonatomic, assign, readonly) CGRect pictureFrame;
/**
 *  图片是否太大
 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/**
 *  图片下载进度
 */
@property (nonatomic, assign) CGFloat pictureProgress;
@end
