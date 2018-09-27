//
//  OADBulletinInfoViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/12.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "OADBulletinInfoViewController.h"

@interface OADBulletinInfoViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView    *webView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation OADBulletinInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void)setNavigationController {
    
    self.leftItemText = @"返回";
    self.navTitle = @"快报详情";
    
    [super setNavigationController];
    
    
}

- (void) initialization {
    
    if (self.infoUrlString.length > 0) {
        
        NSURL        *url     = [NSURL URLWithString:self.infoUrlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
    }

}

- (void) buildSubView; {
    
    [super buildSubView];
    
    UIScrollView *scrollView   = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    
    UIWebView *webView               = [[UIWebView alloc] init];
    webView.backgroundColor          = [UIColor whiteColor];
    webView.frame                    = CGRectMake(0, 0, Screen_Width, self.view.height);
    webView.delegate                 = self;
    webView.scrollView.scrollEnabled = NO;//设置webview不可滚动，让tableview本身滚动即可
    webView.scrollView.bounces       = NO;
    webView.opaque                   = NO;
    
    self.webView = webView;
    
    //  加载HTML数据
    scrollView.contentSize = CGSizeMake(Screen_Width, self.view.height);
    [scrollView addSubview:webView];
    [self.contentView addSubview:scrollView];
    
    self.scrollView = scrollView;
    
}

#pragma mark - webview代理方法
- (void) webViewDidStartLoad:(UIWebView *)webView {
    
    
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    
    //获取页面高度（像素）
    NSString *clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float     clientheight     = [clientheight_str floatValue];
    
    //设置到WebView上
    webView.frame               = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
    self.scrollView.contentSize = CGSizeMake(Screen_Width, clientheight);
    
}

@end
