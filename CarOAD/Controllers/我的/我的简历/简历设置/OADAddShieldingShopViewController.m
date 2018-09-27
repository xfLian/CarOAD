//
//  OADAddShieldingShopViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAddShieldingShopViewController.h"

#import "CVSettingViewModel.h"

@interface OADAddShieldingShopViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation OADAddShieldingShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"添加屏蔽店铺";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.backgroundColor = BackGrayColor;

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Height, Screen_Width, 50 *Scale_Height)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    
    UITextField *textField    = [[UITextField alloc] initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, backView.width - 30 *Scale_Width, 30 *Scale_Height)];
    textField.font            = UIFont_15;
    textField.textColor       = TextGrayColor;
    textField.textAlignment   = NSTextAlignmentLeft;
    textField.delegate        = self;
    textField.tag             = 100;
    textField.backgroundColor = [UIColor clearColor];
    textField.placeholder     = @"请输入你想屏蔽的店铺名称";
    textField.returnKeyType   = UIReturnKeyDone;
    textField.keyboardType    = UIKeyboardTypeDefault;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing; 
    [backView addSubview:textField];
    self.textField = textField;
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, backView.y + backView.height + 20 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                 title:@"保存"
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    button.backgroundColor     = MainColor;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius  = 3 *Scale_Height;
    button.titleLabel.font     = UIFont_M_16;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(button.x, button.y + button.height + 10 *Scale_Height, button.width, 20 *Scale_Height)
                                         labelType:kLabelNormal
                                              text:@"添加后，该店铺将看不到你的简历。"
                                              font:UIFont_15
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentCenter
                                               tag:100];
    [self.contentView addSubview:label];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    if (self.textField.text.length > 0) {
        
        [params setObject:self.textField.text forKey:@"shopName"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入你想屏蔽的店铺名称" toView:self.view afterDelay:1.f];
        return;
    }
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [CVSettingViewModel requestPost_addExceptShopNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"添加成功" toView:self.view afterDelay:1.f];
        
        int64_t delayInSeconds = 1.2f;      // 延迟的时间
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

            self.addSuccess(YES);
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
