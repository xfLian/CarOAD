//
//  UITextField+inits.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UITextField+inits.h"

@implementation UITextField (inits)

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                            textFieldType:(ETextFieldType)type
                           delegateObject:(id)delegateObject
                                leftImage:(NSString *)leftImage
                          placeholderText:(NSString *)placeholderText
                                      tag:(NSInteger)tag; {

    UITextField *textField    = [[UITextField alloc] initWithFrame:frame];
    textField.font            = UIFont_16;
    textField.textColor       = TextBlackColor;
    textField.textAlignment   = NSTextAlignmentLeft;
    textField.delegate        = delegateObject;
    textField.tag             = tag;
    textField.backgroundColor = [UIColor clearColor];
    textField.placeholder     = placeholderText;

    if (type == k_textField_phone) {

        textField.returnKeyType = UIReturnKeyNext;
        textField.keyboardType  = UIKeyboardTypeNumberPad;

    } else if (type == k_textField_verification_code) {

        textField.returnKeyType = UIReturnKeyDone;
        textField.keyboardType  = UIKeyboardTypeNumberPad;

    } else if (type == k_textField_password) {

        textField.returnKeyType = UIReturnKeyDone;
        textField.secureTextEntry = YES;
        textField.keyboardType  = UIKeyboardTypeNumbersAndPunctuation;

    } else if (type == k_textField_invite_code) {

        textField.returnKeyType = UIReturnKeyDone;
        textField.keyboardType  = UIKeyboardTypeNumbersAndPunctuation;

    } else if (type == k_textField_with_title) {

        textField.returnKeyType = UIReturnKeyDone;
        textField.keyboardType  = UIKeyboardTypeDefault;

    }

    if (leftImage.length > 0) {

        if (type == k_textField_with_title) {

            UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
            UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:leftImage
                                                           font:UIFont_15
                                                      textColor:TextBlackColor
                                                  textAlignment:NSTextAlignmentCenter
                                                            tag:100];
            [leftView addSubview:titleLabel];
            [titleLabel sizeToFit];
            leftView.frame   = CGRectMake(0, 0, titleLabel.width + 20 *Scale_Width, frame.size.height);
            titleLabel.frame = CGRectMake(10 *Scale_Width, 0, titleLabel.width, frame.size.height);
            textField.leftViewMode = UITextFieldViewModeAlways;
            textField.leftView     = leftView;
            textField.font         = UIFont_15;

        } else {

            UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            leftImageView.contentMode  = UIViewContentModeCenter;
            textField.leftViewMode     = UITextFieldViewModeAlways;
            leftImageView.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
            leftImageView.image = [UIImage imageNamed:leftImage];
            textField.leftView = leftImageView;

        }

    } else {

        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        leftImageView.contentMode  = UIViewContentModeCenter;
        textField.leftViewMode     = UITextFieldViewModeAlways;
        leftImageView.frame = CGRectMake(0, 0, 10 *Scale_Width, frame.size.height);
        textField.leftView = leftImageView;
        
    }

    return textField;

}

@end
