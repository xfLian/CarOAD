//
//  RungsNumber.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "RungsNumber.h"
#import "NSString+RichText.h"

@implementation RungsNumber

- (void)startAnimation {

    // 初始化值
    CGFloat fromeValue = self.fromValue;
    CGFloat toValue    = self.toValue;
    CGFloat duration   = (self.duration <= 0 ? 1.f : self.duration);

    // 设定动画
    self.conutAnimation.fromValue      = @(fromeValue);
    self.conutAnimation.toValue        = @(toValue);
    self.conutAnimation.timingFunction = \
    [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    self.conutAnimation.duration       = duration;

    // 只有执行了代理才会执行计数引擎
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberCount:currentSting:)]) {

        /* 将计算出来的值通过writeBlock动态给控件设定 */
        self.conutAnimation.property = \
        [POPMutableAnimatableProperty propertyWithName:@"conutAnimation"
                                           initializer:^(POPMutableAnimatableProperty *prop) {
                                               prop.writeBlock      = ^(id obj, const CGFloat values[]) {
                                                   NSNumber *number = @(values[0]);

                                                   NSAttributedString *ats = [self accessNumber:number];
                                                   [self.delegate numberCount:self currentSting:ats];
                                               };
                                           }];

        // 添加动画
        [self pop_addAnimation:self.conutAnimation forKey:nil];
    }
}

// 处理富文本
- (NSAttributedString *)accessNumber:(NSNumber *)number {

    NSInteger count    = [number integerValue];

    NSString *countStr = [NSString stringWithFormat:@"%02ld", (long)count];
    NSString *totalStr = [NSString stringWithFormat:@"%@%%", countStr];

    UIFont *font1       = UIFont_15;
    UIFont *font2       = UIFont_15;

    NSRange totalRange   = [totalStr range];              // 全局的区域
    NSRange countRange   = [countStr rangeFrom:totalStr]; // %的区域

    return [totalStr createAttributedStringAndConfig:@[
                                                       // 全局设置
                                                       [ConfigAttributedString font:font2
                                                                              range:totalRange],
                                                       [ConfigAttributedString font:font1
                                                                              range:countRange],

                                                       // 局部设置
                                                       [ConfigAttributedString foregroundColor:TextGrayColor
                                                                                         range:totalRange],
                                                       [ConfigAttributedString foregroundColor:TextGrayColor
                                                                                         range:countRange],


                                                       ]];

}

@end
