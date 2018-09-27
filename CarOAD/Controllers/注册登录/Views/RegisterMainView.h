//
//  RegisterMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol RegisterMainViewDelegate <NSObject>

//  返回登录页面
- (void) returnLogInView;
- (void) userRegisterWithPhone:(NSString *)phone
              verificationCode:(NSString *)verificationCode
                      password:(NSString *)password
                    inviteCode:(NSString *)inviteCode;
- (void) getVerificationCodeWithPhone:(NSString *)phone;
- (void) chankAgreement;

@end

@interface RegisterMainView : CustomView

@property (nonatomic, weak) id<RegisterMainViewDelegate> delegate;

- (void) addTextFieldNotification;
- (void) removeTextFieldNotification;
- (void) removeFirstResponder;
- (void) chooseButtonIsSelected:(BOOL)selected;

@end
