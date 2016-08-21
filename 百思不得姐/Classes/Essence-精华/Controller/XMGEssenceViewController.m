//
//  XMGEssenceViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGRecommendTagsViewController.h"
#import "XMGTopicViewController.h"

@interface XMGEssenceViewController ()<UIScrollViewDelegate>

/**
 *  标签栏底部的红色指示器
 */
@property (nonatomic, weak)UIView *indicatorView;
/**
 *  当前选中的按钮
 */
@property (nonatomic, weak)UIButton *selectedButton;
/**
 *  底部的所有标签
 */
@property (nonatomic, weak) UIView *titlesView;
/**
 *  底部的所有内容
 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置顶部的标签栏
    [self setupTitlesView];
    
    //底部的scrollView
    [self setupContentView];

    
};

/**
 *  初始化子控制器
 */
- (void)setupChildVces {
    
    XMGTopicViewController *word = [[XMGTopicViewController alloc] init];
    word.title = @"段子";
    word.type = XMGTopicTypeWord;
    [self addChildViewController:word];
    
    XMGTopicViewController * all = [[XMGTopicViewController alloc] init];
    [self addChildViewController:all];
    all.title = @"全部";
    all.type = XMGTopicTypeAll;

    XMGTopicViewController *video = [[XMGTopicViewController alloc] init];
    [self addChildViewController:video];
    video.title = @"视频";
    video.type = XMGTopicTypeVideo;

    XMGTopicViewController *voice = [[XMGTopicViewController alloc] init];
    [self addChildViewController:voice];
    voice.title = @"声音";
    voice.type = XMGTopicTypeVoice;

    XMGTopicViewController *picture = [[XMGTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = XMGTopicTypePicture;

    [self addChildViewController:picture];
    

    
    
}

- (void)setupContentView {
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;

    [self scrollViewDidEndScrollingAnimation:contentView];
  
}

/**
 *  设置顶部的标签栏
 */
- (void)setupTitlesView {
   
    
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    titlesView.width = self.view.width;
    titlesView.height = XMGTitlesViewH;
    titlesView.y = XMGTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    //内部的子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i =0; i< self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            //让按钮内部的label根据文字内容计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
           
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];


}

- (void)titleClick:(UIButton *)button{
    
    //修改铵钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //让标签执行动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = self.selectedButton.titleLabel.width;
        self.indicatorView.centerX = self.selectedButton.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];

}

- (void)setupNav {
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick-click" target:self action:@selector(tagClick)];
    
    //设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

- (void)tagClick {
    
    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    //添加子控制器的view
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控件制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器view的Y值为20
    //设置控制器view的height值为整个屏幕的高度（默认是屏幕高度少个20）
    vc.view.height =scrollView.height;
    
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}
@end
