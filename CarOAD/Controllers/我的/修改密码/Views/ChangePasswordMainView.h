//
//  ChangePasswordMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ChangePasswordMainViewDelegate <NSObject>

//  返回登录页面
- (void) changePasswordWithOldPassword:(NSString *)oldPassword
                           newPassword:(NSString *)newPassword
                    confirmNewPassword:(NSString *)confirmNewPassword;

@end

@interface ChangePasswordMainView : CustomView

@property (nonatomic, weak) id<ChangePasswordMainViewDelegate> delegate;

- (void) clearTextFieldData;
- (void) addTextFieldNotification;
- (void) removeTextFieldNotification;
- (void) removeFirstResponder;

@end
