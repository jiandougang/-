//
//  XMGTopicVoiceView.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//  声音帖子中间的内容 
//

#import <UIKit/UIKit.h>
@class XMGTopic;

@interface XMGTopicVoiceView : UIView
/**
 *  贴子数据
 */
@property (nonatomic, strong) XMGTopic *topic;
+ (instancetype)voiceView;
@end
