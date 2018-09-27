//
//  OADAgreementViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAgreementViewController.h"

@interface OADAgreementViewController ()<UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIWebView    *webView;
@property (nonatomic, strong) UIScrollView *webScrollView;

@end

@implementation OADAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)buildSubView {

    self.backgroundColor = [UIColor whiteColor];

    UIView *navigationBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    navigationBackView.backgroundColor = MainColor;
    [self.view addSubview:navigationBackView];

    {

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@"用户协议"
                                                       font:UIFont_M_17
                                                  textColor:[UIColor whiteColor]
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:500];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(navigationBackView.width / 2, navigationBackView.height / 2 + 10);
        [navigationBackView addSubview:titleLabel];

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(5, 20, 44, 44)
                                                buttonType:kButtonNormal
                                                     title:nil
                                                     image:[UIImage imageNamed:@"arrow_backnav"]
                                                  higImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [navigationBackView addSubview:button];

    }

    UIScrollView *scrollView   = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navigationBackView.height, Screen_Width, Screen_Height - navigationBackView.height - 60 *Scale_Height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate        = self;
    scrollView.keyboardDismissMode = YES;
    [self.view addSubview:scrollView];
    self.webScrollView = scrollView;

    UIWebView *webView               = [[UIWebView alloc] init];
    webView.backgroundColor          = [UIColor whiteColor];
    webView.frame                    = CGRectMake(0, 0, Screen_Width, scrollView.height);
    webView.delegate                 = self;
    webView.scrollView.scrollEnabled = NO;//设置webview不可滚动，让tableview本身滚动即可
    webView.scrollView.bounces       = NO;
    webView.opaque                   = NO;
    [scrollView addSubview:webView];
    self.webView = webView;

    NSString     *urlString = MYPostClassUrl(CLASS_USER, LICSENCE_HTML);
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];

    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, scrollView.y + scrollView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                 title:@"同意"
                                       backgroundImage:nil
                                                   tag:2000
                                                target:self
                                                action:@selector(buttonEvent:)];
    button.backgroundColor     = MainColor;
    button.layer.cornerRadius  = 3.0 *Scale_Width;
    button.layer.masksToBounds = YES;
    button.titleLabel.font     = UIFont_M_17;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 2000) {

        self.agreeBlock(YES);

    } 

    CATransition *transition  = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type           = kCATransitionMoveIn;
    transition.subtype        = kCATransitionFromLeft;
    transition.duration       = 0.35;
    [self.view.window.layer removeAllAnimations];
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:NO completion:^{


    }];

}

#pragma mark - webview代理方法
- (void) webViewDidStartLoad:(UIWebView *)webView {



}

- (void) webViewDidFinishLoad:(UIWebView *)webView {

    //获取页面高度（像素）
    NSString *clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float     clientheight     = [clientheight_str floatValue];

    //设置到WebView上
    webView.frame                  = CGRectMake(0, 0, Screen_Width, clientheight);
    self.webScrollView.contentSize = CGSizeMake(Screen_Width, clientheight + 10);

    [MBProgressHUD hideHUD];

}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    [MBProgressHUD hideHUD];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
