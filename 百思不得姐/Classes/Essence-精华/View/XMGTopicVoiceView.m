//
//  XMGTopicVoiceView.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGTopicVoiceView.h"
#import "XMGTopic.h"
#import "XMGShowPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface XMGTopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@end

@implementation XMGTopicVoiceView

+ (instancetype)voiceView {
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
    
    //时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%zd",minute,second];
}
@end
