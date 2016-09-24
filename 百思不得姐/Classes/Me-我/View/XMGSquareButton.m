//
//  XMGSquareButton.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGSquareButton.h"
#import "XMGSquare.h"
#import <UIButton+WebCache.h>

@implementation XMGSquareButton

- (void)setSquare:(XMGSquare *)square {
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    //利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
     [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (void)setUp {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
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
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxX(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}


@end
