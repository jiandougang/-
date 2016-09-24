//
//  UIImageView+XMGExtension.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImageView+XMGExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (XMGExtension)
- (void)setHeader:(NSString *)url {
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image? [image circleImage] : placeholder;
    }];
}
@end
