//
//  XMGCommentHeaderView.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGCommentHeaderView : UITableViewHeaderFooterView
/**
 *  文字数据
 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
