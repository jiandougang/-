//
//  XMGTopicPictureView.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;

@interface XMGTopicPictureView : UIView
+ (instancetype)pictureView;
/**
 *  贴子数据
 */
@property (nonatomic, strong) XMGTopic *topic;
@end
