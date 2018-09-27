//
//  UILabel+inits.m
//  MKMCCustomer
//
//  Created by Sunny on 2017/6/7.
//  Copyright © 2017年 Sunny. All rights reserved.
//

#import "UILabel+inits.h"

@implementation UILabel (inits)

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                         labelType:(ELabelType)type
                              text:(NSString *)text
                              font:(UIFont *)font
                         textColor:(UIColor *)textColor
                     textAlignment:(NSTextAlignment)textAlignment
                               tag:(NSInteger)tag;
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    if (type == kLabelNormal) {
        
        label.tag           = tag;
        label.font          = font;
        label.text          = text;
        label.textColor     = textColor;
        label.textAlignment = textAlignment;
        
    }
    
    return label;
    
}

@end
