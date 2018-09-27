//
//  NSString+RichText.h
//  夏半微凉
//
//  Created by xf_Lian on 16/7/10.
//  Copyright © 2016年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigAttributedString.h"

@interface NSString (RichText)

// 创建富文本并配置富文本(NSArray中的数据必须是ConfigAttributedString对象合集)
- (NSMutableAttributedString *)createAttributedStringAndConfig:(NSArray *)configs;

// 用于搜寻一段字符串在另外一段字符串中的NSRange值
- (NSRange)rangeFrom:(NSString *)string;

// 本字符串的range
- (NSRange)range;

@end
