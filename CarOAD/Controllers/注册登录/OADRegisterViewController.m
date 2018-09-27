//
//  OADRegisterViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADRegisterViewController.h"
#import "RegisterMainView.h"
#import "OADAgreementViewController.h"

@interface OADRegisterViewController ()<RegisterMainViewDelegate>

@property (nonatomic, strong) RegisterMainView *registerView;

@end

@implementation OADRegisterViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self.registerView addTextFieldNotification];

}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [self.registerView removeTextFieldNotification];
    [self.registerView removeFirstResponder];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)buildSubView {

    self.view.backgroundColor = [UIColor whiteColor];
    RegisterMainView *registerView = [[RegisterMainView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    registerView.delegate          = self;
    [self.view addSubview:registerView];
    self.registerView = registerView;

}

- (void) returnLogInView; {

    //创建动画
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

- (void) userRegisterWithPhone:(NSString *)phone
              verificationCode:(NSString *)verificationCode
                      password:(NSString *)password
                    inviteCode:(NSString *)inviteCode; {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    if (phone.length == 11) {

        [params setObject:phone forKey:@"phone"];

    } else {

        [MBProgressHUD showMessageTitle:@"请输入正确的手机号码" toView:self.view afterDelay:1.f];
        return;
    }

    if (verificationCode.length == 4) {

        [params setObject:verificationCode forKey:@"authCode"];

    } else {

        [MBProgressHUD showMessageTitle:@"验证码不正确，请重新输入" toView:self.view afterDelay:1.f];
        return;
    }

    if (password.length >= 6) {

        [params setObject:password forKey:@"password"];

    } else {

        [MBProgressHUD showMessageTitle:@"密码格式不正确，请重新输入" toView:self.view afterDelay:1.f];
        return;
    }

    if (inviteCode.length > 0) {

        [params setObject:inviteCode forKey:@"inviteCode"];

    } else {

        [params setObject:@"" forKey:@"inviteCode"];

    }

    [MBProgressHUD showMessage:nil toView:self.view];

    [OADLogInViewModel requestPost_registerNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"注册成功，请登录" toView:self.view afterDelay:1.5f];

        int64_t delayInSeconds = 1.8f;      // 延迟的时间
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // do something
            NSDictionary *loginData = @{@"phone"    : phone,
                                        @"password" : password};
            self.loginBlock(loginData);
            [self returnLogInView];
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"注册失败，请重新注册" toView:self.view afterDelay:1.f];
        
    }];
    
}

- (void) getVerificationCodeWithPhone:(NSString *)phone; {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    if (phone.length == 11) {

        [params setObject:phone forKey:@"phone"];

    } else {

        [MBProgressHUD showMessageTitle:@"请先输入手机号码" toView:self.view afterDelay:1.5f];
        return;

    }

    [params setObject:@"1" forKey:@"type"];

    [MBProgressHUD showMessage:nil toView:self.view];

    [OADLogInViewModel requestPost_getVerificationCodeNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"获取验证码成功" toView:self.view afterDelay:1.5f];

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"获取验证码失败，请重新获取" toView:self.view afterDelay:1.5f];

    }];

}

- (void) chankAgreement; {

    __weak OADRegisterViewController *weakSelf = self;
    OADAgreementViewController *viewController = [[OADAgreementViewController alloc] init];
    viewController.agreeBlock = ^(BOOL isAgree) {

        if (isAgree== YES) {

            [weakSelf.registerView chooseButtonIsSelected:YES];
            
        }

    };
    //把当前控制器作为背景
    self.definesPresentationContext = YES;
    //设置模态视图弹出样式
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;

    CATransition * transition = [CATransition animation];
    transition.type           = kCATransitionMoveIn;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.subtype        = kCATransitionFromRight;
    transition.duration       = 0.35;
    [self.view.window.layer removeAllAnimations];
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:viewController animated:NO completion:^{


    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
