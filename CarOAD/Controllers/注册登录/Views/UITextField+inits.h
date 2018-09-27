//
//  UITextField+inits.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {

    k_textField_phone,
    k_textField_verification_code,
    k_textField_password,
    k_textField_invite_code,
    k_textField_with_title,

} ETextFieldType;

@interface UITextField (inits)


/**
 快速创建textField

 @param frame frame
 @param type textField类型
 @param leftImage textField左视图
 @param delegateObject 代理对象
 @param placeholderText textField的默认值
 @param tag textField的tag值
 @return 创建好的textField
 */
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                            textFieldType:(ETextFieldType)type
                           delegateObject:(id)delegateObject
                                leftImage:(NSString *)leftImage
                          placeholderText:(NSString *)placeholderText
                                      tag:(NSInteger)tag;

@end
