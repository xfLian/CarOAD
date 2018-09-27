//
//  OADChangePhoneCodeViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADChangePhoneCodeViewController.h"
#import "ChangePhoneCodeViewModel.h"

@interface OADChangePhoneCodeViewController ()<UITextFieldDelegate>
{

    BOOL phoneIsRight;
    BOOL codeIsRight;
    BOOL isFinishCountdown;

}
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UIButton    *publishButton;
@property (nonatomic, strong) NSString    *codeData;

@end

@implementation OADChangePhoneCodeViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self.phoneTextField addTarget:self
                            action:@selector(phoneTextFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];

    [self.codeTextField addTarget:self
                               action:@selector(codeTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];

    [self.phoneTextField removeTarget:self
                               action:@selector(phoneTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

    [self.codeTextField removeTarget:self
                                  action:@selector(codeTextFieldDidChange:)
                        forControlEvents:UIControlEventEditingChanged];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    phoneIsRight = NO;
    codeIsRight = NO;
    isFinishCountdown = YES;

}

- (void)setNavigationController {

    self.navTitle     = @"验证手机号码";
    self.leftItemText = @"返回";

    [super setNavigationController];

}

- (void)buildSubView {

    [super buildSubView];

    UIView *textBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 15 *Scale_Height, Screen_Width - 30 *Scale_Width, 90 *Scale_Height)];
    textBackView.layer.masksToBounds = YES;
    textBackView.layer.cornerRadius  = 5 *Scale_Height;
    textBackView.layer.borderWidth   = 0.5 *Scale_Width;
    textBackView.layer.borderColor   = LineColor.CGColor;
    textBackView.backgroundColor     = [UIColor whiteColor];
    [self.contentView addSubview:textBackView];

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 0, textBackView.width, 45 *Scale_Height)
                                                         textFieldType:k_textField_phone
                                                        delegateObject:self
                                                             leftImage:nil
                                                       placeholderText:@"请输入手机号码"
                                                                   tag:100];
        [textBackView addSubview:textField];
        self.phoneTextField = textField;

    }

    {

        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(0, 45 *Scale_Height, textBackView.width - 130 *Scale_Width, 45 *Scale_Height)
                                                         textFieldType:k_textField_verification_code
                                                        delegateObject:self
                                                             leftImage:nil
                                                       placeholderText:@"请输入短信验证码"
                                                                   tag:101];
        [textBackView addSubview:textField];
        self.codeTextField = textField;

        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(textField.x + textField.width + 10 *Scale_Width, 58 *Scale_Height, 1.5 *Scale_Width, 19 *Scale_Height)];
        lineView.backgroundColor = LineColor;
        [textBackView addSubview:lineView];

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(self.codeTextField.x + self.codeTextField.width + 20 *Scale_Width, 50 *Scale_Height, 100 *Scale_Width, 35 *Scale_Height)
                                                     title:@"获取验证码"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = BackGrayColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_14;
        [button setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [textBackView addSubview:button];
        self.button = button;
        self.button.enabled = NO;

    }

    {

        UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, textBackView.height / 2 - 0.5 *Scale_Height, textBackView.width, 0.5 *Scale_Height)];
        lineView.backgroundColor = LineColor;
        [textBackView addSubview:lineView];

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, textBackView.y + textBackView.height + 15 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"确定"
                                           backgroundImage:nil
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = CarOadColor(129, 196, 255);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_17;
        [button setTitleColor:CarOadColor(215, 233, 248) forState:UIControlStateNormal];
        button.enabled = NO;
        [self.contentView addSubview:button];
        self.publishButton = button;

    }

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        [self openCountdown];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

        if (self.phoneTextField.text.length == 11) {

            [params setObject:self.phoneTextField.text forKey:@"phone"];

        } else {

            [MBProgressHUD showMessageTitle:@"请输入正确的手机号码" toView:self.view afterDelay:1.5f];
            return;
        }
        
        [MBProgressHUD showMessage:nil toView:self.view];
        
        [ChangePhoneCodeViewModel requestPost_changePhoneNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

            NSString *code = info[@"code"];
            self.codeData  = code;
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        } error:^(NSString *errorMessage) {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];

        } failure:^(NSError *error) {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:@"获取验证码失败，请重新获取" toView:self.view afterDelay:1.f];

        }];

    } else {

        if (self.codeTextField.text.length == 4) {

            if ([self.codeData isEqualToString:self.codeTextField.text]) {

                [MBProgressHUD showMessageTitle:@"验证成功" toView:self.view afterDelay:1.f];

                int64_t delayInSeconds = 1.2f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                    self.changePhone(YES, self.phoneTextField.text);
                    [self.navigationController popViewControllerAnimated:YES];

                });

            } else {

                [MBProgressHUD showMessageTitle:@"您输入的验证码有误，请重新输入" toView:self.view afterDelay:1.5f];

            }

        } else {

            [MBProgressHUD showMessageTitle:@"验证码格式不正确，请重新输入" toView:self.view afterDelay:1.5f];
            return;

        }

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

        [textField resignFirstResponder];

    } else if (toBeString.length == 11) {

        [textField resignFirstResponder];

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

- (void) codeTextFieldDidChange:(UITextField *)textField {

    codeIsRight = NO;
    [self publishButtonIsCanClick];

    if (textField.text.length > 0) {

        if (self.phoneTextField.text.length <= 0) {

            self.codeTextField.text = @"";
            [self.codeTextField resignFirstResponder];

            [MBProgressHUD showMessageTitle:@"请先输入您的手机号码" toView:self.view afterDelay:1.2f];
            int64_t delayInSeconds = 1.3f;      // 延迟的时间
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

#pragma mark - textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    return YES;

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    return YES;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    CarOadLog(@"textField.tag --- %ld",textField.tag);


}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (textField == self.phoneTextField) {

        BOOL isMobilePhone = [IDCardNumberconfirmationInquiryTool isMobilePhone:textField.text];

        if (isMobilePhone == YES) {

            [self.phoneTextField resignFirstResponder];
            [self.codeTextField becomeFirstResponder];

        } else {

            if (textField.text.length > 0) {

                [MBProgressHUD showMessageTitle:@"手机号格式不正确，请重新输入" toView:self.view afterDelay:1.8f];

                int64_t delayInSeconds  = 1.9f;      // 延迟的时间
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                    // do something
                    [self.phoneTextField becomeFirstResponder];

                });

            }

        }

    } else {

        BOOL isNumber = [IDCardNumberconfirmationInquiryTool isNum:textField.text];
        if (isNumber != YES) {

            if (textField.text.length > 0) {

                [MBProgressHUD showMessageTitle:@"验证码格式不正确，请重新输入" toView:self.view afterDelay:1.5f];
                int64_t delayInSeconds  = 1.6f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // do something
                    [self.codeTextField becomeFirstResponder];

                });

            }

        } else {

            if (textField.text.length > 0 && textField.text.length < 4) {

                [MBProgressHUD showMessageTitle:@"请输入至少4位验证码" toView:self.view afterDelay:1.5f];
                int64_t delayInSeconds  = 1.6f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // do something
                    [self.codeTextField becomeFirstResponder];

                });

            }

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

    if (phoneIsRight == YES && codeIsRight == YES) {

        self.publishButton.enabled = YES;
        [self.publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.publishButton.backgroundColor = MainColor;

    } else {

        self.publishButton.enabled = NO;
        [self.publishButton setTitleColor:CarOadColor(215, 233, 248) forState:UIControlStateNormal];
        self.publishButton.backgroundColor = CarOadColor(129, 196, 255);

    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
