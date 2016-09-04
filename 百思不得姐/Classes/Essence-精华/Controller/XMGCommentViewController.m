//
//  XMGCommentViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGCommentViewController.h"

@interface XMGCommentViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@end

@implementation XMGCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    //键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomSpace.constant = XMGScreenH - frame.origin.y;
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


@end
