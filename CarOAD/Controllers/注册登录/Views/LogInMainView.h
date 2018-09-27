//
//  LogInMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol LogInMainViewDelegate <NSObject>

//  关闭登录页面
- (void) closeLogInView;

- (void) userLogInWithPhone:(NSString *)phone password:(NSString *)password;
- (void) gotoUserRegisterVC;
- (void) gotoFindPasswordVC;

@end

@interface LogInMainView : CustomView

@property (nonatomic, weak) id<LogInMainViewDelegate> delegate;

- (void) addTextFieldNotification;
- (void) removeTextFieldNotification;
- (void) removeFirstResponder;
- (void) publishButtonIsCanClick;

@end
