//
//  AMapSearchView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AMapSearchView.h"

@interface AMapSearchView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation AMapSearchView

- (void)buildSubview {
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UITextField *textField    = [[UITextField alloc] initWithFrame:CGRectMake(15 *Scale_Width, 8 *Scale_Height, Screen_Width - 75 *Scale_Width, 32 *Scale_Height)];
    textField.font            = UIFont_14;
    textField.textColor       = TextBlackColor;
    textField.textAlignment   = NSTextAlignmentLeft;
    textField.delegate        = self;
    textField.tag             = 100;
    textField.backgroundColor = BackGrayColor;
    textField.placeholder     = @"请输入您要查找的位置";
    textField.returnKeyType   = UIReturnKeySearch;
    textField.keyboardType    = UIKeyboardTypeDefault;
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius  = textField.height / 2;
    
    UIView *leftView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.height / 4 *5, textField.height)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    leftImageView.contentMode  = UIViewContentModeScaleAspectFit;
    leftImageView.frame        = CGRectMake(0, 0, textField.height / 5 *3, textField.height / 5 *3);
    leftImageView.image        = [UIImage imageNamed:@"Search_white"];
    leftImageView.center       = CGPointMake(leftView.width / 2, leftView.height / 2);
    [leftView addSubview:leftImageView];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView     = leftView;
    [backView addSubview:textField];
    self.textField = textField;
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(textField.x + textField.width + 5 *Scale_Width, 0, self.height, self.height)
                                                 title:@"搜索"
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [backView addSubview:button];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (self.textField.text.length > 0) {
        
        [_delegate startPoiSearchWithText:self.textField.text];
        
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
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //  限制输入字数
    if ([string rangeOfString:@"\n"].location != NSNotFound) {

        return NO;
        
    }
    
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (self.textField.text.length > 0) {
        
        [textField resignFirstResponder];
        [_delegate startPoiSearchWithText:self.textField.text];
        
    }
    
    return YES;
    
}


@end
