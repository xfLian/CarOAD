//
//  RegisterMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "RegisterMainView.h"

@interface RegisterMainView ()<UITextFieldDelegate>
{

    BOOL phoneIsRight;
    BOOL codeIsRight;
    BOOL passwordIsRight;
    BOOL isFinishCountdown;

}
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *inviteCodeTextField;
@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UIButton    *publiahButton;
@property (nonatomic, strong) UIButton    *chooseButton;

@end

@implementation RegisterMainView

- (void)buildSubview {

    phoneIsRight = NO;
    codeIsRight = NO;
    passwordIsRight = NO;
    isFinishCountdown = YES;
    self.backgroundColor = [UIColor whiteColor];

    UIView *navigationBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    navigationBackView.backgroundColor = MainColor;
    [self addSubview:navigationBackView];
    
    {

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@"注册"
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
                                                     image:[UIImage imageNamed:@"arrow_backnav"]
                                                  higImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [navigationBackView addSubview:button];

    }

    UIView *textBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 15 *Scale_Height + 64, Screen_Width - 30 *Scale_Width, 180 *Scale_Height)];
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
                                                       placeholderText:@"请输入手机号码"
                                                                   tag:100];
        [textBackView addSubview:textField];
        self.phoneTextField = textField;

    }

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 45 *Scale_Height, textBackView.width - 130 *Scale_Width, 45 *Scale_Height)
                                                         textFieldType:k_textField_verification_code
                                                        delegateObject:self
                                                             leftImage:@"verificationI_blue"
                                                       placeholderText:@"请输入短信验证码"
                                                                   tag:101];
        [textBackView addSubview:textField];
        self.codeTextField = textField;

        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(textField.x + textField.width + 10 *Scale_Width, 58 *Scale_Height, 1.5 *Scale_Width, 19 *Scale_Height)];
        lineView.backgroundColor = LineColor;
        [textBackView addSubview:lineView];

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(textField.x + textField.width + 20 *Scale_Width, 50 *Scale_Height, 100 *Scale_Width, 35 *Scale_Height)
                                                     title:@"获取验证码"
                                           backgroundImage:nil
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = BackGrayColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_14;
        button.enabled             = NO;
        [button setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [textBackView addSubview:button];
        self.button = button;

    }

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 90 *Scale_Height, textBackView.width - 55 *Scale_Width, 45 *Scale_Height)
                                                         textFieldType:k_textField_password
                                                        delegateObject:self
                                                             leftImage:@"password_blue"
                                                       placeholderText:@"请输入密码"
                                                                   tag:102];
        [textBackView addSubview:textField];
        self.passwordTextField = textField;

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(textField.x + textField.width + 10 *Scale_Width, textField.y, textField.height, textField.height)
                                                buttonType:kButtonSel
                                                     title:nil
                                                     image:[UIImage imageNamed:@"close_eyes_blue"]
                                                  higImage:[UIImage imageNamed:@"open_eyes_blue"]
                                                       tag:1002
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [textBackView addSubview:button];

    }

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 135 *Scale_Height, textBackView.width, 45 *Scale_Height)
                                                         textFieldType:k_textField_invite_code
                                                        delegateObject:self
                                                             leftImage:@"confirm_password_blue"
                                                       placeholderText:@"请输入邀请码（选填）"
                                                                   tag:103];
        [textBackView addSubview:textField];
        self.inviteCodeTextField = textField;

    }

    {
        for (int i = 0; i < 3; i++) {

            UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, textBackView.height / 4 * (i + 1) - 0.5 *Scale_Height, textBackView.width, 0.5 *Scale_Height)];
            lineView.backgroundColor = LineColor;
            [textBackView addSubview:lineView];

        }

    }

    UIView *agreementBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, textBackView.y + textBackView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 30 *Scale_Height)];
    agreementBackView.backgroundColor = [UIColor clearColor];
    [self addSubview:agreementBackView];

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 0, agreementBackView.height, agreementBackView.height)
                                                buttonType:kButtonSel
                                                     title:nil
                                                     image:[UIImage imageNamed:@"selected_null_gray"]
                                                  higImage:[UIImage imageNamed:@"selected_full_gray"]
                                                       tag:1003
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [agreementBackView addSubview:button];
        self.chooseButton = button;

    }

    {

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@"阅读并同意"
                                                       font:UIFont_15
                                                  textColor:TextGrayColor
                                              textAlignment:NSTextAlignmentLeft
                                                        tag:501];
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(agreementBackView.height, 0, titleLabel.width, agreementBackView.height);
        [agreementBackView addSubview:titleLabel];

        {

            UIButton *button = [UIButton createButtonWithFrame:CGRectMake(titleLabel.x + titleLabel.width, 0, 155 *Scale_Width, agreementBackView.height)
                                                         title:@"《凯路登技师版协议》"
                                               backgroundImage:nil
                                                           tag:1004
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            button.titleLabel.font = UIFont_15;
            [button setTitleColor:MainColor forState:UIControlStateNormal];
            [agreementBackView addSubview:button];

        }

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, agreementBackView.y + agreementBackView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"注册"
                                           backgroundImage:nil
                                                       tag:1005
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

        [_delegate returnLogInView];

    } else if (sender.tag == 1001) {

        CarOadLog(@"获取验证码");
        [_delegate getVerificationCodeWithPhone:self.phoneTextField.text];
        [self openCountdown];

    } else if (sender.tag == 1002) {

        if (sender.selected == YES) {

            sender.selected = NO;
            self.passwordTextField.secureTextEntry = YES;

        } else {

            sender.selected = YES;
            self.passwordTextField.secureTextEntry = NO;

        }

    } else if (sender.tag == 1003) {

        if (sender.selected == YES) {

            sender.selected = NO;

        } else {

            sender.selected = YES;

        }

        [self publishButtonIsCanClick];

    } else if (sender.tag == 1004) {

        [_delegate chankAgreement];

    } else if (sender.tag == 1005) {

        [_delegate userRegisterWithPhone:self.phoneTextField.text
                        verificationCode:self.codeTextField.text
                                password:self.passwordTextField.text
                              inviteCode:self.inviteCodeTextField.text];

    }

}

- (void) chooseButtonIsSelected:(BOOL)selected; {

    if (selected == YES) {

        self.chooseButton.selected = YES;

    } else {

        self.chooseButton.selected = NO;

    }

    [self publishButtonIsCanClick];

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
    [self codeButtonIsCanClick];

}

- (void)codeTextFieldDidChange:(UITextField *)textField {

    codeIsRight = NO;
    [self publishButtonIsCanClick];

    if (textField.text.length > 0) {

        if (self.phoneTextField.text.length <= 0) {

            self.codeTextField.text = @"";
            [self.codeTextField resignFirstResponder];

            [MBProgressHUD showMessageTitle:@"请先输入您的手机号码" toView:self afterDelay:1.5f];
            int64_t delayInSeconds = 1.6f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something

                [self.phoneTextField becomeFirstResponder];

            });

        } else {

            BOOL isMobilePhone = [IDCardNumberconfirmationInquiryTool isMobilePhone:self.phoneTextField.text];
            if (isMobilePhone == YES) {

                if (textField.text.length >= 4) {

                    codeIsRight = YES;
                    [self publishButtonIsCanClick];

                }

            } else {

                self.codeTextField.text = @"";

            }

        }

    }

}

- (void)passwordTextFieldDidChange:(UITextField *)textField
{

    passwordIsRight = NO;
    [self publishButtonIsCanClick];

    if (textField.text.length > 0) {

        if (self.phoneTextField.text.length <= 0) {

            self.passwordTextField.text = @"";
            [self.passwordTextField resignFirstResponder];

            [MBProgressHUD showMessageTitle:@"请先输入您的手机号码" toView:self afterDelay:1.5f];
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

    [self.codeTextField addTarget:self
                               action:@selector(codeTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

    [self.passwordTextField addTarget:self
                               action:@selector(passwordTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

}

- (void) removeTextFieldNotification {

    [self.phoneTextField removeTarget:self
                               action:@selector(phoneTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

    [self.codeTextField removeTarget:self
                                  action:@selector(codeTextFieldDidChange:)
                        forControlEvents:UIControlEventEditingChanged];

    [self.phoneTextField removeTarget:self
                               action:@selector(phoneTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

}

- (void) removeFirstResponder; {

    [self.phoneTextField    resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    [self.passwordTextField    resignFirstResponder];

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
            [self.codeTextField becomeFirstResponder];

        } else {

            if (textField.text.length > 0) {

                [MBProgressHUD showMessageTitle:@"您输入的手机号格式不正确，请重新输入" toView:self afterDelay:1.5f];

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

    } else if (textField.tag == 101) {

        BOOL isNumber = [IDCardNumberconfirmationInquiryTool isNum:textField.text];
        if (isNumber != YES) {

            if (textField.text.length > 0) {

                [MBProgressHUD showMessageTitle:@"验证码格式不正确，请重新输入" toView:self afterDelay:1.5f];
                int64_t delayInSeconds  = 1.6f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // do something
                    [self.codeTextField becomeFirstResponder];

                });

            }

        } else {

            if (textField.text.length > 0 && textField.text.length < 4) {

                [MBProgressHUD showMessageTitle:@"请输入4位验证码" toView:self afterDelay:1.f];
                int64_t delayInSeconds  = 1.2f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // do something
                    [self.codeTextField becomeFirstResponder];

                });

            }

        }

    } else if (textField.tag == 102) {

        if (textField.text.length < 6 && textField.text.length > 0) {

            [MBProgressHUD showMessageTitle:@"请输入至少6位密码" toView:self afterDelay:1.5f];
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

// 开启倒计时效果
-(void)openCountdown{

    __block NSInteger time = 119; //倒计时时间

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(_timer, ^{

        if(time <= 0){ //倒计时结束，关闭

            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮的样式
                [self.button setTitle:@"重新发送" forState:UIControlStateNormal];
                isFinishCountdown = YES;
                [self codeButtonIsCanClick];

            });

        } else {

            int seconds = time % 120;
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮显示读秒效果
                [self.button setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                isFinishCountdown = NO;
                [self codeButtonIsCanClick];

            });
            time--;
        }
    });
    dispatch_resume(_timer);

}

- (void) codeButtonIsCanClick {

    if (phoneIsRight == YES && isFinishCountdown == YES) {

        self.button.enabled         = YES;
        self.button.backgroundColor = MainColor;
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    } else {

        self.button.enabled = NO;
        self.button.backgroundColor = BackGrayColor;
        [self.button setTitleColor:TextGrayColor forState:UIControlStateNormal];

    }

}

- (void) publishButtonIsCanClick {

    if (phoneIsRight == YES && codeIsRight == YES && passwordIsRight == YES && self.chooseButton.selected == YES) {

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
