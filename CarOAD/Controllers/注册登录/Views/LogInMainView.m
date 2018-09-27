//
//  LogInMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "LogInMainView.h"

@interface LogInMainView ()<UITextFieldDelegate>
{

    BOOL phoneIsRight;
    BOOL passwordIsRight;

}
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton    *publiahButton;

@end

@implementation LogInMainView

- (void)buildSubview {

    phoneIsRight = NO;
    passwordIsRight = NO;

    self.backgroundColor = [UIColor whiteColor];

    UIView *navigationBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    navigationBackView.backgroundColor = MainColor;
    [self addSubview:navigationBackView];

    {

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@"用户登录"
                                                       font:UIFont_M_17
                                                  textColor:[UIColor whiteColor]
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:500];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(navigationBackView.width / 2, navigationBackView.height / 2 + 10);
        [navigationBackView addSubview:titleLabel];

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(5, 20, 44, 44)
                                                buttonType:kButtonNormal
                                                     title:nil
                                                     image:[UIImage imageNamed:@"button_close_lxf"]
                                                  higImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [navigationBackView addSubview:button];

    }

    UIView *textBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 15 *Scale_Height + 64, Screen_Width - 30 *Scale_Width, 90 *Scale_Height)];
    textBackView.layer.masksToBounds = YES;
    textBackView.layer.cornerRadius  = 5 *Scale_Height;
    textBackView.layer.borderWidth   = 0.5 *Scale_Width;
    textBackView.layer.borderColor   = LineColor.CGColor;
    textBackView.backgroundColor     = [UIColor whiteColor];
    [self addSubview:textBackView];

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 0, textBackView.width, 45 *Scale_Height)
                                                         textFieldType:k_textField_phone
                                                        delegateObject:self
                                                             leftImage:@"phone_blue"
                                                       placeholderText:@"请输入登录手机号码"
                                                                   tag:100];
        [textBackView addSubview:textField];
        self.phoneTextField = textField;

    }

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 45 *Scale_Height, textBackView.width - 55 *Scale_Width, 45 *Scale_Height)
                                                         textFieldType:k_textField_password
                                                        delegateObject:self
                                                             leftImage:@"password_blue"
                                                       placeholderText:@"请输入登录密码"
                                                                   tag:101];
        [textBackView addSubview:textField];
        self.passwordTextField = textField;

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

        UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, textBackView.height / 2 - 0.5 *Scale_Height, textBackView.width, 0.5 *Scale_Height)];
        lineView.backgroundColor = LineColor;
        [textBackView addSubview:lineView];

    }

    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, textBackView.y + textBackView.height + 20 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"登录"
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
        self.publiahButton.enabled = NO;

    }

    //  注册按钮
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, self.publiahButton.y + self.publiahButton.height + 5 *Scale_Height, 60 *Scale_Width, 30 *Scale_Height)
                                                     title:@"立即注册"
                                           backgroundImage:nil
                                                       tag:1003
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = UIFont_13;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        [self addSubview:button];

    }

    //  找回密码按钮
    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(self.width - 85 *Scale_Width, self.publiahButton.y + self.publiahButton.height + 5 *Scale_Height, 70 *Scale_Width, 30 *Scale_Height)
                                                     title:@"忘记密码？"
                                           backgroundImage:nil
                                                       tag:1004
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = UIFont_13;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        //button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        [self addSubview:button];

    }

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        [_delegate closeLogInView];

    } else if (sender.tag == 1001) {

        if (sender.selected == YES) {

            sender.selected = NO;
            self.passwordTextField.secureTextEntry = YES;

        } else {

            sender.selected = YES;
            self.passwordTextField.secureTextEntry = NO;

        }

    } else if (sender.tag == 1002) {

        [_delegate userLogInWithPhone:self.phoneTextField.text password:self.passwordTextField.text];

    } else if (sender.tag == 1003) {

        [_delegate gotoUserRegisterVC];

    } else if (sender.tag == 1004) {

        [_delegate gotoFindPasswordVC];

    }

}

#pragma mark - Notification Method
-(void)phoneTextFieldDidChange:(UITextField *)textField
{

    NSString *toBeString = textField.text;
    if (toBeString.length > 11)
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:11];
        if (rangeIndex.length == 1)
        {
            textField.text = [toBeString substringToIndex:11];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 11)];
            textField.text = [toBeString substringWithRange:rangeRange];

        }

        [self.phoneTextField resignFirstResponder];

    } else if (toBeString.length == 11) {

        [self.phoneTextField resignFirstResponder];

    }

    BOOL isMobilePhone = [IDCardNumberconfirmationInquiryTool isMobilePhone:textField.text];

    if (isMobilePhone == YES) {

        phoneIsRight = YES;

    } else {

        phoneIsRight = NO;

    }

    [self publishButtonIsCanClick];

}

- (void)passwordTextFieldDidChange:(UITextField *)textField
{

    passwordIsRight = NO;
    [self publishButtonIsCanClick];

    if (textField.text.length > 0) {

        if (self.phoneTextField.text.length <= 0) {

            self.passwordTextField.text = @"";
            [self.passwordTextField resignFirstResponder];

            [MBProgressHUD showMessageTitle:@"请先输入您的登录手机号码" toView:self afterDelay:1.5f];
            int64_t delayInSeconds = 1.6f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something

                [self.phoneTextField becomeFirstResponder];

            });

        } else {

            BOOL isMobilePhone = [IDCardNumberconfirmationInquiryTool isMobilePhone:self.phoneTextField.text];
            if (isMobilePhone == YES) {

                if (textField.text.length >= 6) {

                    passwordIsRight = YES;
                    [self publishButtonIsCanClick];
                    
                }

            } else {

                self.passwordTextField.text = @"";

            }

        }

    }

}

- (void) addTextFieldNotification {

    [self.phoneTextField addTarget:self
                  action:@selector(phoneTextFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];

    [self.passwordTextField addTarget:self
                  action:@selector(passwordTextFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];

}

- (void) removeTextFieldNotification {

    [self.phoneTextField removeTarget:self
                               action:@selector(phoneTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

    [self.passwordTextField removeTarget:self
                                  action:@selector(passwordTextFieldDidChange:)
                        forControlEvents:UIControlEventEditingChanged];

}

- (void) removeFirstResponder; {

    [self.phoneTextField    resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
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

        BOOL isMobilePhone = [IDCardNumberconfirmationInquiryTool isMobilePhone:textField.text];

        if (isMobilePhone == YES) {

            [self.phoneTextField resignFirstResponder];
            [self.passwordTextField becomeFirstResponder];

        } else {

            if (textField.text.length > 0) {

                [MBProgressHUD showMessageTitle:@"您输入的手机号格式不正确，请重新输入" toView:self afterDelay:1.8f];

                int64_t delayInSeconds = 1.9f;      // 延迟的时间
                /*
                 *@parameter 1,时间参照，从此刻开始计时
                 *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
                 */
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                    // do something
                    [self.phoneTextField becomeFirstResponder];

                });

            }

        }

    } else {

        if (textField.text.length < 6 && textField.text.length > 0) {

            [MBProgressHUD showMessageTitle:@"请输入至少6位密码" toView:self afterDelay:1.8f];
            int64_t delayInSeconds  = 1.9f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something
                [self.passwordTextField becomeFirstResponder];
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

    if (phoneIsRight == YES && passwordIsRight == YES) {

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
