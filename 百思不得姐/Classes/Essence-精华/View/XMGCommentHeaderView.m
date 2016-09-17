//
//  XMGCommentHeaderView.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGCommentHeaderView.h"

@interface XMGCommentHeaderView()

@property (nonatomic, weak) UILabel *label;

@end

@implementation XMGCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    XMGCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[XMGCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = XMGRGBCorlor(67, 67, 67);
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.label.text = title;
}
@end
