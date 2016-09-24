//
//  XMGWebViewController.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/9/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XMGWebViewController.h"
#import <NJKWebViewProgress.h>

@interface XMGWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
/**
 * 进度代理对象
 */
@property (nonatomic, strong) NJKWebViewProgress *progress;
@end

@implementation XMGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (IBAction)goForward:(id)sender {

}

- (IBAction)goBack:(id)sender {

}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    XMGLog(@"%@",@"有没有到这里来啊");
//    self.goBackItem.enabled = webView.canGoBack;
//    self.goForwardItem.enabled = webView.canGoForward;
}
@end
