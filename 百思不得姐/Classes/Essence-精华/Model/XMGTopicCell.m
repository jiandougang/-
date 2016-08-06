//
//  XMGTopicCell.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>

@interface XMGTopicCell()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/**
 *  顶
 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/**
 *  踩
 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

/**
 *  分享
 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *commonButton;

@end

@implementation XMGTopicCell

- (void)setTopic:(XMGTopic *)topic {
    
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commonButton count:topic.comment placeholder:@"评论"];

}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count> 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    }else if(count > 0){
        placeholder = [NSString stringWithFormat:@"%zd", count] ;
    }
    [button setTitle:placeholder forState:UIControlStateNormal];

}


- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setFrame:(CGRect)frame {
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}

@end
