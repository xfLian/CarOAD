//
//  MBProgressHUD+QT.m
//
//  Created by ycj on 15-12-3.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MBProgressHUD+QT.h"

@interface MBProgressHUD()

@property (nonatomic, strong) MBProgressHUD *tmpHud;

@end

@implementation MBProgressHUD (QT)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.25f];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {

    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText                 = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground             = NO;
    hud.color                     = [UIColor blackColor];
    hud.opacity                   = 1.f;
    hud.mode                      = MBProgressHUDModeIndeterminate;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}
#pragma mark 只显示信息
+(void)showMessageTitle:(NSString *)message{
    
    [self show:message icon:nil view:nil];
    
}

+(void)showWaitingToView:(UIView *)view;{

    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    // Set the determinate mode to show task progress.
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = NSLocalizedString(@"正在上传...", @"HUD loading title");

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.

        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHUDForView:view];
        });
    });
}

+(void)showMessageTitle:(NSString *)message toView:(UIView *)view afterDelay:(CGFloat)delay;{

    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText      = message;
    // 再设置模式
    hud.mode           = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;

    [hud hide:YES afterDelay:delay];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
