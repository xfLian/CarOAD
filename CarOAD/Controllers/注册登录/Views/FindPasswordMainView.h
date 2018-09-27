//
//  FindPasswordMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol FindPasswordMainViewDelegate <NSObject>

//  返回登录页面
- (void) returnLogInView;
- (void) findPasswordWithPhone:(NSString *)phone
              verificationCode:(NSString *)verificationCode
                      password:(NSString *)password;
- (void) getVerificationCodeWithPhone:(NSString *)phone;

@end

@interface FindPasswordMainView : CustomView

@property (nonatomic, weak) id<FindPasswordMainViewDelegate> delegate;

- (void) addTextFieldNotification;
- (void) removeTextFieldNotification;
- (void) removeFirstResponder;

@end
