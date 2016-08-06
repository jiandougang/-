//
//  XMGTopicCell.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;
@interface XMGTopicCell : UITableViewCell
/**
 *  贴子数据
 */
@property (nonatomic, strong) XMGTopic *topic;
@end
