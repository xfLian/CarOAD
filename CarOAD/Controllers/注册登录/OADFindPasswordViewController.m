//
//  OADFindPasswordViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADFindPasswordViewController.h"

#import "FindPasswordMainView.h"

@interface OADFindPasswordViewController ()<FindPasswordMainViewDelegate>

@property (nonatomic, strong) FindPasswordMainView *findPasswordView;

@end

@implementation OADFindPasswordViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self.findPasswordView addTextFieldNotification];

}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [self.findPasswordView removeTextFieldNotification];
    [self.findPasswordView removeFirstResponder];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)buildSubView {

    self.view.backgroundColor = [UIColor whiteColor];
    FindPasswordMainView *findPasswordView = [[FindPasswordMainView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    findPasswordView.delegate          = self;
    [self.view addSubview:findPasswordView];
    self.findPasswordView = findPasswordView;

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
- (void) findPasswordWithPhone:(NSString *)phone
              verificationCode:(NSString *)verificationCode
                      password:(NSString *)password;{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    if (phone.length == 11) {

        [params setObject:phone forKey:@"phone"];

    } else {

        [MBProgressHUD showMessageTitle:@"请输入正确的手机号码" toView:self.view afterDelay:1.5f];
        return;
    }

    if (verificationCode.length == 4) {

        [params setObject:verificationCode forKey:@"authCode"];

    } else {

        [MBProgressHUD showMessageTitle:@"验证码不正确，请重新输入" toView:self.view afterDelay:1.5f];
        return;
    }

    if (password.length >= 6) {

        [params setObject:password forKey:@"newPassword"];

    } else {

        [MBProgressHUD showMessageTitle:@"密码格式不正确，请重新输入" toView:self.view afterDelay:1.5f];
        return;
    }

    [MBProgressHUD showMessage:nil toView:self.view];

    [OADLogInViewModel requestPost_findPasswordNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"密码修改成功，请重新登录" toView:self.view afterDelay:1.5f];
        int64_t delayInSeconds = 1.8f;      // 延迟的时间
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

            [self returnLogInView];
        });

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"修改密码失败，请重新发送" toView:self.view afterDelay:1.5f];

    }];

}

- (void) getVerificationCodeWithPhone:(NSString *)phone;{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    if (phone.length == 11) {

        [params setObject:phone forKey:@"phone"];

    } else {

        [MBProgressHUD showMessageTitle:@"请先输入手机号码" toView:self.view afterDelay:1.5f];
        return;

    }

    [params setObject:@"2" forKey:@"type"];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
