//
//  XMGTopicVideoView.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/2.
//  Copyright © 2016年 apple. All rights reserved.
//  视频贴子中间的内容
//

#import <UIKit/UIKit.h>
@class XMGTopic;

@interface XMGTopicVideoView : UIView
+ (instancetype)videoView;
/**
 *  贴子数据
 */
@property (nonatomic, strong) XMGTopic * topic;
@end
