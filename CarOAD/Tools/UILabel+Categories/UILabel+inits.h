//
//  UILabel+inits.h
//  MKMCCustomer
//
//  Created by Sunny on 2017/6/7.
//  Copyright © 2017年 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+RichText.h"

typedef enum : NSUInteger {
    
    kLabelNormal,
    kLabelGreen,
    kLabelBlack,
    
} ELabelType;

@interface UILabel (inits)

/**
 *  创建Label
 *
 *  @param frame     frame值
 *  @param type      类型
 *  @param text      内容
 *  @param tag       标签
 *  @param font           字体大小
 *  @param textAlignment  对齐方式
 *  @param textColor      字体颜色
 *
 *  @return 创建好的label
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                        labelType:(ELabelType)type
                             text:(NSString *)text
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor
                    textAlignment:(NSTextAlignment)textAlignment
                              tag:(NSInteger)tag;



@end
