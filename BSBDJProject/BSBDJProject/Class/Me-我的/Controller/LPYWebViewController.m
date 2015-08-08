//
//  LPYWebViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/7.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYWebViewController.h"
#import <NJKWebViewProgress.h>

@interface LPYWebViewController () <UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** progress */
@property (nonatomic,strong) NJKWebViewProgress *progressProxy;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation LPYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([self.activeModel.url hasPrefix:@"http"])
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.activeModel.url]]];
    }
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    
    
    __weak typeof(self) weakSelf = self;
    self.progressProxy.progressBlock = ^(float progress){
        weakSelf.progressView.progress = progress;
        LPYLog(@"------------%f",progress);
        weakSelf.progressView.hidden = (progress == 1.0);
    };
}

//- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
//{
//    self.progressView.progress = progress;
//    LPYLog(@"------------%f",progress);
//    self.progressView.hidden = (progress == 1.0);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    LPYLog(@"-------");
#warning 标签显示颜色有问题
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
    
    // 强制重新布局
    [self.toolBar layoutIfNeeded];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

@end
