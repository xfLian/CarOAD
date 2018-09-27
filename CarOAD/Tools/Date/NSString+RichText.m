//
//  NSString+RichText.m
//  夏半微凉
//
//  Created by xf_Lian on 16/7/10.
//  Copyright © 2016年 xf_Lian. All rights reserved.
//

#import "NSString+RichText.h"

@implementation NSString (RichText)

- (NSMutableAttributedString *)createAttributedStringAndConfig:(NSArray *)configs
{
    NSMutableAttributedString *attributedString = \
    [[NSMutableAttributedString alloc] initWithString:self];
    
    [configs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ConfigAttributedString *oneConfig = obj;
        [attributedString addAttribute:oneConfig.attribute
                                 value:oneConfig.value
                                 range:oneConfig.range];
    }];
    
    return attributedString;
}

- (NSRange)rangeFrom:(NSString *)string
{
    return [string rangeOfString:self];
}

- (NSRange)range
{
    return NSMakeRange(0, self.length);
}

@end
