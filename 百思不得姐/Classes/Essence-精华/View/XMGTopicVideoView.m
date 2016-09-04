//
//  XMGTopicVideoView.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGTopicVideoView.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>

@interface XMGTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation XMGTopicVideoView

+ (instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(XMGTopic *)topic {
    _topic = topic;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd",topic.playcount];
    
    //播放时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
@end
