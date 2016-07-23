//
//  XMGTextField.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGTextField.h"

static NSString * const XMGPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation XMGTextField

- (void)awakeFromNib {
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder {
    //修改占位文字颜色
     [self setValue:self.textColor forKeyPath:XMGPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时就会调用
 *
 */
- (BOOL)resignFirstResponder {
    //修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:XMGPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}



@end
