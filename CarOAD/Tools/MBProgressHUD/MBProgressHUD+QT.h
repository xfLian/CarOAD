//
//  MBProgressHUD+MJ.h
//
//  Created by ycj on 15-12-3.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (QT)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+(void)showMessageTitle:(NSString *)message;
+(void)showMessageTitle:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
