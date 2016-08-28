//
//  XMGPublishView.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGPublishView.h"
#import "XMGVerticalButton.h"
#import "pop.h"

#define XMGRootView [UIApplication sharedApplication].keyWindow.rootViewController.view

static CGFloat const XMGAnimationDelay = 0.1;
static CGFloat const XMGSpringFactor = 10;
@interface XMGPublishView ()

@end

@implementation XMGPublishView

+ (instancetype)publishView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {

    //不能被点击
    XMGRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;

    //数据
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    //中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (XMGScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 25;
    CGFloat xMargin = (XMGScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i=0; i<images.count; i++) {
        XMGVerticalButton *button = [[XMGVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //计算XY
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - XMGScreenH;
        
        //按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = XMGSpringFactor;
        anim.springSpeed = XMGSpringFactor;
        anim.beginTime = CACurrentMediaTime() + XMGAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
    
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    
    //标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = XMGScreenW * 0.5;
    CGFloat centerEndY = XMGScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - XMGScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * XMGAnimationDelay;
    anim.springBounciness = XMGSpringFactor;
    anim.springSpeed = XMGSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
        //标语动画执行完毕，恢复点击事件
        XMGRootView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
   
}

- (void)buttonClick:(UIButton *)button {
    
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            XMGLog(@"发视频");
            
        }
    }];
    
   
}

/**
 *  先执行退出动画，动画完毕后执行completionBlock
 *
 *  @param completionBlock completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    
    //不能被点击
    XMGRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    
    for (int i = beginIndex; i < self.subviews.count; i++) {
        UIView *subview = self.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + XMGScreenH;
        //动画的执行节奏(一开始很慢，后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * XMGAnimationDelay;
        
        [subview pop_addAnimation:anim forKey:nil];
        
        //监听最后一个动画
        if(i == self.subviews.count - 1){
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                XMGRootView.userInteractionEnabled = YES;

                [self removeFromSuperview];
                !completionBlock? : completionBlock();
            }];
        }
    }
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self cancelWithCompletionBlock:nil];
}

@end
