//
//  UserInfomationEdiNameCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UserInfomationEdiNameCell.h"

@interface UserInfomationEdiNameCell()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation UserInfomationEdiNameCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"真实姓名"
                                               font:UIFont_13
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentCenter
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.delegate      = self;
    textField.font          = UIFont_15;
    textField.textColor     = TextGrayColor;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.returnKeyType = UIReturnKeyDone;
    textField.placeholder   = @"请输入您的真实姓名";
    textField.backgroundColor = [UIColor clearColor];
    textField.keyboardType = UIKeyboardTypeDefault;
    [self.contentView addSubview:textField];
    self.textField = textField;

}

- (void)layoutSubviews {

    self.titleLabel.frame = CGRectMake(0, 5 *Scale_Height, Screen_Width, 20 *Scale_Height);
    self.textField.frame  = CGRectMake(0, self.titleLabel.height + 10 *Scale_Height, Screen_Width, 20 *Scale_Height);
}

- (void)loadContent {

    NSString *userName = self.data;

    if (userName.length > 0) {

        self.textField.text = userName;
        
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


}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    [self.delegate getUserNameString:textField.text];

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

@end
