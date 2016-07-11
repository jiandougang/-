//
//  XMGRecommendUserCell.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGRecommendUserCell.h"
#import "XMGRecommentUser.h"
#import <UIImageView+WebCache.h>

@interface XMGRecommendUserCell()
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation XMGRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUser:(XMGRecommentUser *)user {
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
