//
//  ChangePasswordMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChangePasswordMainView.h"

@interface ChangePasswordMainView ()<UITextFieldDelegate>
{

    BOOL oldPasswordIsRight;
    BOOL newPasswordIsRight;
    BOOL confirmNewPasswordIsRight;
    BOOL isSameNewPasswordAndConfirmNewPassword;

}
@property (nonatomic, strong) UITextField *oldPasswordTextField;
@property (nonatomic, strong) UITextField *nowPasswordTextField;
@property (nonatomic, strong) UITextField *confirmNewPasswordTextField;
@property (nonatomic, strong) UIButton    *publiahButton;

@end

@implementation ChangePasswordMainView

- (void)buildSubview {

    oldPasswordIsRight = NO;
    newPasswordIsRight = NO;
    confirmNewPasswordIsRight = NO;
    isSameNewPasswordAndConfirmNewPassword = NO;
    self.backgroundColor = [UIColor whiteColor];

    UIView *textBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 15 *Scale_Height, Screen_Width - 30 *Scale_Width, 135 *Scale_Height)];
    textBackView.layer.masksToBounds = YES;
    textBackView.layer.cornerRadius  = 5 *Scale_Height;
    textBackView.layer.borderWidth   = 0.5 *Scale_Width;
    textBackView.layer.borderColor   = LineColor.CGColor;
    textBackView.backgroundColor     = [UIColor whiteColor];
    [self addSubview:textBackView];

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 0, textBackView.width - 55 *Scale_Width, 45 *Scale_Height)
                                                         textFieldType:k_textField_password
                                                        delegateObject:self
                                                             leftImage:nil
                                                       placeholderText:@"请输入旧密码"
                                                                   tag:100];
        [textBackView addSubview:textField];
        self.oldPasswordTextField = textField;

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(textField.x + textField.width + 10 *Scale_Width, textField.y, textField.height, textField.height)
                                                buttonType:kButtonSel
                                                     title:nil
                                                     image:[UIImage imageNamed:@"close_eyes_blue"]
                                                  higImage:[UIImage imageNamed:@"open_eyes_blue"]
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [textBackView addSubview:button];

    }

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 45 *Scale_Height, textBackView.width - 55 *Scale_Width, 45 *Scale_Height)
                                                         textFieldType:k_textField_password
                                                        delegateObject:self
                                                             leftImage:nil
                                                       placeholderText:@"请设置新密码"
                                                                   tag:101];
        [textBackView addSubview:textField];
        self.nowPasswordTextField = textField;

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(textField.x + textField.width + 10 *Scale_Width, textField.y, textField.height, textField.height)
                                                buttonType:kButtonSel
                                                     title:nil
                                                     image:[UIImage imageNamed:@"close_eyes_blue"]
                                                  higImage:[UIImage imageNamed:@"open_eyes_blue"]
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [textBackView addSubview:button];

    }

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 90 *Scale_Height, textBackView.width, 45 *Scale_Height)
                                                         textFieldType:k_textField_password
                                                        delegateObject:self
                                                             leftImage:nil
                                                       placeholderText:@"请确认新密码"
                                                                   tag:102];
        [textBackView addSubview:textField];
        self.confirmNewPasswordTextField = textField;

    }

    {
        for (int i = 0; i < 2; i++) {

            UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, textBackView.height / 3 * (i + 1) - 0.5 *Scale_Height, textBackView.width, 0.5 *Scale_Height)];
            lineView.backgroundColor = LineColor;
            [textBackView addSubview:lineView];

        }

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, textBackView.y + textBackView.height + 20 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"确认"
                                           backgroundImage:nil
                                                       tag:1002
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = CarOadColor(129, 196, 255);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_17;
        [button setTitleColor:CarOadColor(215, 233, 248) forState:UIControlStateNormal];
        [self addSubview:button];
        self.publiahButton = button;

    }

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        if (sender.selected == YES) {

            sender.selected = NO;
            self.oldPasswordTextField.secureTextEntry = YES;

        } else {

            sender.selected = YES;
            self.oldPasswordTextField.secureTextEntry = NO;

        }

    } else if (sender.tag == 1001) {

        if (sender.selected == YES) {

            sender.selected = NO;
            self.nowPasswordTextField.secureTextEntry = YES;
            self.confirmNewPasswordTextField.secureTextEntry = YES;

        } else {

            sender.selected = YES;
            self.nowPasswordTextField.secureTextEntry = NO;
            self.confirmNewPasswordTextField.secureTextEntry = NO;

        }

    } else if (sender.tag == 1002) {

        [_delegate changePasswordWithOldPassword:self.oldPasswordTextField.text
                                     newPassword:self.nowPasswordTextField.text
                              confirmNewPassword:self.confirmNewPasswordTextField.text];

    }

}

#pragma mark - Notification Method
-(void)oldPasswordTextFieldDidChange:(UITextField *)textField
{

    oldPasswordIsRight = NO;

    if (textField.text.length >= 6) {

        oldPasswordIsRight = YES;

    }

    [self publishButtonIsCanClick];

}

- (void)newPasswordTextFieldDidChange:(UITextField *)textField {

    newPasswordIsRight = NO;
    [self publishButtonIsCanClick];

    if (textField.text.length > 0) {

        if (self.oldPasswordTextField.text.length < 6) {

            self.nowPasswordTextField.text = @"";
            [self.nowPasswordTextField resignFirstResponder];

            [MBProgressHUD showMessageTitle:@"请先输入旧密码" toView:self afterDelay:1.5f];
            int64_t delayInSeconds = 1.6f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something

                [self.oldPasswordTextField becomeFirstResponder];

            });

        } else {

            if (textField.text.length >= 6) {

                newPasswordIsRight = YES;

                if ([textField.text isEqualToString:self.confirmNewPasswordTextField.text]) {

                    isSameNewPasswordAndConfirmNewPassword = YES;
                }

                [self publishButtonIsCanClick];

            }

        }

    }

}

- (void)confirmNewPasswordTextFieldDidChange:(UITextField *)textField
{

    confirmNewPasswordIsRight = NO;
    [self publishButtonIsCanClick];

    if (textField.text.length > 0) {

        if (self.nowPasswordTextField.text.length < 6) {

            self.confirmNewPasswordTextField.text = @"";
            [self.confirmNewPasswordTextField resignFirstResponder];

            [MBProgressHUD showMessageTitle:@"请先设置新密码" toView:self afterDelay:1.5f];
            int64_t delayInSeconds = 1.6f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something

                [self.nowPasswordTextField becomeFirstResponder];

            });

        } else {

            if (textField.text.length >= 6) {

                confirmNewPasswordIsRight = YES;

                if ([textField.text isEqualToString:self.nowPasswordTextField.text]) {

                    isSameNewPasswordAndConfirmNewPassword = YES;
                }

                [self publishButtonIsCanClick];

            }

        }

    }

}

- (void) addTextFieldNotification {

    [self.oldPasswordTextField addTarget:self
                            action:@selector(oldPasswordTextFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];

    [self.nowPasswordTextField addTarget:self
                           action:@selector(newPasswordTextFieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];

    [self.confirmNewPasswordTextField addTarget:self
                               action:@selector(confirmNewPasswordTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

}

- (void) removeTextFieldNotification {

    [self.oldPasswordTextField removeTarget:self
                               action:@selector(oldPasswordTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

    [self.nowPasswordTextField removeTarget:self
                              action:@selector(newPasswordTextFieldDidChange:)
                    forControlEvents:UIControlEventEditingChanged];

    [self.confirmNewPasswordTextField removeTarget:self
                               action:@selector(confirmNewPasswordTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

}

- (void) clearTextFieldData; {

    self.oldPasswordTextField.text = @"";
    self.nowPasswordTextField.text = @"";
    self.confirmNewPasswordTextField.text = @"";

    oldPasswordIsRight = NO;
    newPasswordIsRight = NO;
    confirmNewPasswordIsRight = NO;
    isSameNewPasswordAndConfirmNewPassword = NO;
    
    [self publishButtonIsCanClick];

}

- (void) removeFirstResponder; {

    [self.oldPasswordTextField    resignFirstResponder];
    [self.nowPasswordTextField resignFirstResponder];
    [self.confirmNewPasswordTextField    resignFirstResponder];

}

#pragma mark - textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    return YES;

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    return YES;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {


}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (textField.tag == 100) {

        if (textField.text.length < 6 && textField.text.length > 0) {

            [MBProgressHUD showMessageTitle:@"请输入至少6位密码" toView:self afterDelay:1.8f];
            int64_t delayInSeconds  = 1.9f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something
                [self.oldPasswordTextField becomeFirstResponder];
            });

        }

    } else if (textField.tag == 101) {

        if (textField.text.length < 6 && textField.text.length > 0) {

            [MBProgressHUD showMessageTitle:@"请输入至少6位密码" toView:self afterDelay:1.8f];
            int64_t delayInSeconds  = 1.9f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something
                [self.nowPasswordTextField becomeFirstResponder];
            });

        }

    } else if (textField.tag == 102) {

        if (textField.text.length < 6 && textField.text.length > 0) {

            [MBProgressHUD showMessageTitle:@"请输入至少6位密码" toView:self afterDelay:1.8f];
            int64_t delayInSeconds  = 1.9f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something
                [self.confirmNewPasswordTextField becomeFirstResponder];
            });

        }

    }

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    //  限制输入字数
    if ([string rangeOfString:@"\n"].location != NSNotFound) {

        [textField resignFirstResponder];

        return NO;

    }

    return YES;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];

    return YES;

}

- (void) publishButtonIsCanClick {

    if (oldPasswordIsRight == YES && newPasswordIsRight == YES && confirmNewPasswordIsRight == YES && isSameNewPasswordAndConfirmNewPassword == YES) {

        self.publiahButton.enabled = YES;
        [self.publiahButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.publiahButton.backgroundColor = MainColor;

    } else {

        self.publiahButton.enabled = NO;
        [self.publiahButton setTitleColor:CarOadColor(215, 233, 248) forState:UIControlStateNormal];
        self.publiahButton.backgroundColor = CarOadColor(129, 196, 255);

    }

}

@end
