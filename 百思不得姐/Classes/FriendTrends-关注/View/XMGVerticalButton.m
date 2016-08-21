//
//  XMGVerticalButton.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGVerticalButton.h"

@implementation XMGVerticalButton

- (void)setUp {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
