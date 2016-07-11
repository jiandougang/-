//
//  XMGRecommendCategoryCell.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/7/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGRecommendCategory.h"
#import "XMGRecommendCategoryCell.h"

@interface XMGRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation XMGRecommendCategoryCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundColor = XMGRGBCorlor(244, 244, 244);
    self.selectedIndicator.backgroundColor = XMGRGBCorlor(219, 21, 26);
    
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bg;
}

- (void)setCategory:(XMGRecommendCategory*)category
{
    category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    if (selected) {
        self.textLabel.textColor = self.selectedIndicator.backgroundColor;

    }else{
         self.textLabel.textColor = XMGRGBCorlor(78, 78, 78);
    }
   
}
@end
