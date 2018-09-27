//
//  OADLogInViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADLogInViewController.h"

#import "LogInMainView.h"

#import "OADRegisterViewController.h"
#import "OADFindPasswordViewController.h"

#import "JPUSHService.h"

@interface OADLogInViewController ()<LogInMainViewDelegate>

@property (nonatomic, strong) LogInMainView *logInView;

@end

@implementation OADLogInViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    //  删除推送标签
    OADAccountInfo *deleAccountInfo = [OADSaveAccountInfoTool accountInfo];
    
    if (deleAccountInfo.user_phone.length > 0) {
        
        NSSet *set = [[NSSet alloc] initWithArray:@[deleAccountInfo.user_phone]];
        
        [JPUSHService deleteTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            
        } seq:0];
        
    }

    //  清空用户数据
    NSDictionary   *dict = @{};
    OADAccountInfo *accountInfo = [OADAccountInfo accountInfoWithDictionary:dict];
    [OADSaveAccountInfoTool saveAccountInfo:accountInfo];

    [self.logInView addTextFieldNotification];
    
}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [self.logInView removeTextFieldNotification];
    [self.logInView removeFirstResponder];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


}

- (void)buildSubView {

    LogInMainView *logInView = [[LogInMainView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    logInView.delegate       = self;
    [self.view addSubview:logInView];
    self.logInView = logInView;

}

- (void) closeLogInView; {

    [self dismissViewControllerAnimated:YES completion:^{

    }];

}

- (void) userLogInWithPhone:(NSString *)phone password:(NSString *)password; {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    if (phone.length == 11) {

        [params setObject:phone forKey:@"phone"];

    } else {

        [MBProgressHUD showMessageTitle:@"请输入正确的手机号码" toView:self.view afterDelay:1.5f];
        return;
    }

    if (password.length >= 6) {
        
        [params setObject:password forKey:@"password"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"密码格式不正确，请重新输入" toView:self.view afterDelay:1.5f];
        return;
    }

    [MBProgressHUD showMessage:nil toView:self.view];

    [OADLogInViewModel requestPost_logInNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        NSDictionary *data = info[@"data"][0];
        
        //  保存用户信息
        OADAccountInfo *accountInfo = [OADAccountInfo accountInfoWithDictionary:data];
        [OADSaveAccountInfoTool saveAccountInfo:accountInfo];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"登录成功" toView:self.view afterDelay:1.f];
        int64_t delayInSeconds = 1.2f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            //设置推送标签推送
            NSSet *set = [[NSSet alloc] initWithArray:@[phone]];
            [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                
            } seq:0];
            
            NSNotification *notice = \
            [NSNotification notificationWithName:@"LoginSuccess"
                                          object:nil
                                        userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notice];
            [self closeLogInView];

        });

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"登录失败，请重新登录" toView:self.view afterDelay:1.5f];

    }];

}

- (void) gotoUserRegisterVC; {

    __weak OADLogInViewController *weakSelf = self;
    OADRegisterViewController *viewController = [[OADRegisterViewController alloc] init];
    viewController.loginBlock = ^(NSDictionary *loginData) {   // 1

        NSString *phone    = loginData[@"phone"];
        NSString *password = loginData[@"password"];

        [weakSelf userLogInWithPhone:phone password:password];
        
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

- (void) gotoFindPasswordVC; {
    
    OADFindPasswordViewController *viewController = [[OADFindPasswordViewController alloc] init];
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
