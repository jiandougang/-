//
//  XMGCommentCell.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGComment;

@interface XMGCommentCell : UITableViewCell
/**
 *  评论
 */
@property (nonatomic, strong) XMGComment *comment;

@end
