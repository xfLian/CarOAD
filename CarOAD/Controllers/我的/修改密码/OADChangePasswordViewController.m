//
//  OADChangePasswordViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADChangePasswordViewController.h"

#import "ChangePasswordMainView.h"

@interface OADChangePasswordViewController ()<ChangePasswordMainViewDelegate>

@property (nonatomic, strong) ChangePasswordMainView *changePasswordView;

@end

@implementation OADChangePasswordViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

    [self.changePasswordView addTextFieldNotification];
    [self.changePasswordView clearTextFieldData];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccess)
                                                 name:@"LoginSuccess"
                                               object:nil];
    
}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [self.changePasswordView removeTextFieldNotification];
    [self.changePasswordView removeFirstResponder];

}

- (void) loginSuccess {

    int64_t delayInSeconds = 0.3f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"LoginSuccess"
                                                      object:nil];

        [self.navigationController popViewControllerAnimated:YES];

    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setNavigationController {

    self.navTitle     = @"修改密码";
    self.leftItemText = @"返回";

    [super setNavigationController];

}

- (void)buildSubView {

    [super buildSubView];

    ChangePasswordMainView *changePasswordView = [[ChangePasswordMainView alloc] initWithFrame:self.contentView.bounds];
    changePasswordView.delegate       = self;
    [self.contentView addSubview:changePasswordView];
    self.changePasswordView = changePasswordView;

}

#pragma mark - ChangePasswordMainViewDelegate
- (void) changePasswordWithOldPassword:(NSString *)oldPassword
                           newPassword:(NSString *)newPassword
                    confirmNewPassword:(NSString *)confirmNewPassword; {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];

    if (accountInfo.user_id) {

        [params setObject:accountInfo.user_id forKey:@"userId"];

    } else {

        [MBProgressHUD showMessageTitle:@"请先登录您的账号" toView:self.view afterDelay:1.5f];
        return;

    }

    if (oldPassword.length >= 6) {

        [params setObject:oldPassword forKey:@"oldPassword"];

    } else {

        [MBProgressHUD showMessageTitle:@"请先输入旧密码" toView:self.view afterDelay:1.5f];
        return;

    }

    if (newPassword.length >= 6 && confirmNewPassword.length >= 6 && [newPassword isEqualToString:confirmNewPassword]) {

        [params setObject:newPassword forKey:@"newPassword"];

    } else {
        
        [MBProgressHUD showMessageTitle:@"请确认新密码两次输入一致" toView:self.view afterDelay:1.5f];
        return;

    }

    [MBProgressHUD showMessage:nil toView:self.view];
    
    [OADLogInViewModel requestPost_changePwdNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"密码修改成功，请重新登录" toView:self.view afterDelay:1.5f];

        int64_t delayInSeconds = 1.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

            NSDictionary   *dict = @{};
            OADAccountInfo *accountInfo = [OADAccountInfo accountInfoWithDictionary:dict];
            [OADSaveAccountInfoTool saveAccountInfo:accountInfo];

            if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {

            }

        });

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"密码修改失败，请重新修改" toView:self.view afterDelay:1.5f];

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
