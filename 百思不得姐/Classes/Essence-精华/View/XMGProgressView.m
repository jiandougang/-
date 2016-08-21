//
//  XMGProgressView.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGProgressView.h"

@implementation XMGProgressView

- (void)awakeFromNib {
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress
           animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    text  = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    self.progressLabel.text = text;

}

@end
