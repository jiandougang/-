//
//  XMGTopicViewController.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XMGTopicViewController : UITableViewController
/**
 *  贴子类型(交给子类去实现)
 */
@property (nonatomic, assign) XMGTopicType type;
@end
