//
//  CMWebViewController.m
//  CMKanKan
//
//  Created by 夏和奇 on 2017/3/7.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import "CMWebViewController.h"
#import "MBProgressHUD+KK.h"

@interface CMWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, weak) MBProgressHUD *hud;

@end

@implementation CMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hud = [MBProgressHUD animationWithMessage:@"" toView:self.webView];
    
    [self loadRequest];
}

- (UIWebView *)webView
{
    _webView = [[UIWebView alloc] init];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    self.hidesBottomBarWhenPushed = YES;
    _webView.mediaPlaybackRequiresUserAction = NO; // 允许自动播放
    [self.view addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.right.and.bottom.equalTo(self.view);
    }];
    
    return _webView;
}


- (void)loadRequest
{
    if (!self.urlStr) return;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
}

#pragma mark - 退出
- (void)navigationViewDidSelectedBack:(CMNavigationView *)navigationView
{
    if ([self.webView canGoBack]) {
        
        [self.webView goBack];
    }
    else {
        
        [self stopWebView];
        
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        if (self.backBlock) {
            self.backBlock();
        }
    }
}
- (BOOL)gestureRecognizerShouldBegin
{
    [self stopWebView];
    
    if (self.backBlock) {
        self.backBlock();
    }
    
    return YES;
}

- (void)stopWebView
{
    [self.webView loadHTMLString:@"" baseURL:nil];
    self.webView.delegate = nil;
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    self.webView = nil ;
}

- (void)dealloc
{
    if (self.webView) {
        [self stopWebView];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hideAnimated:YES];
    self.hud = nil;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.hud hideAnimated:YES];
    self.hud = nil;
}

@end
