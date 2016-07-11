//
//  XMGRecommendUserCell.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGRecommentUser;
@interface XMGRecommendUserCell : UITableViewCell
/**
 *  用户模型
 */
@property (nonatomic, strong) XMGRecommentUser *user;
@end
