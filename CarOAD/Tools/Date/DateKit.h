//
//  DateKit.h
//  夏半微凉
//
//  Created by xf_Lian on 16/7/12.
//  Copyright © 2016年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateKit : NSObject

+ (NSString *) dateStamp:(NSString *)strTime;
+ (NSString *) timeStamp:(NSString *)strTime;

// 日期和字符串之间的转换
+ (NSDate *) stringToDateWithString:(NSString *)dateString;

// 日期和字符串之间的转换（带时间）
+ (NSString *) dateToStringWithDate:(NSDate *)date;

// 日期和字符串之间的转换 获取年月日
+ (NSString *) getYTDStringWithDate:(NSDate *)date;

// 日期和字符串之间的转换 获取时
+ (NSString *) getHourStringWithDate:(NSDate *)date;

// 日期和字符串之间的转换 获取分
+ (NSString *) getMinuteStringWithDate:(NSDate *)date;

/**
 *  计算星期几
 *
 *  @param date 时间总秒数
 *
 *  @return 星期几字符串
 */
+ (NSString *) getweekDayWithDate:(NSDate *)date;

/**
 *  时间对比
 *
 *  @param firstTime 第一时间
 *  @param secondTime 第二时间
 *
 *  @return 第一个时间大于第二个时间 返回yes
 */
- (BOOL) firstTime:(NSString *)firstTime isGreaterThanSecondTime:(NSString *)secondTime;

/**
 *  计算时间点所在区间
 *
 *  @param riseTime 日出时间
 *  @param setTime  日落时间
 *
 *  @return 0   夜晚
 *          1   夜晚到日出
 *          2   日出到6点
 *          3   6点到7点
 *          4   7点到8点
 *          5   8点到9点
 *          6   9点到10点
 *          7   10点到11点
 *          8   11点到12点
 *          9   12点到13点
 *          10  13点到14点
 *          11  14点到15点
 *          12  15点到16点
 *          13  16点到17点
 *          14  17点到18点
 *          15  18点到日落
 *          16  日落到夜晚
 *
 */
- (NSInteger) getTimeCodeWithRiseTime:(NSString *)riseTime
                              setTime:(NSString *)setTime;

/**
 *  字符串转换成秒（带日期）
 */
- (NSTimeInterval) timeStringToTimeIntervalWithString:(NSString *)string;

/**
 *  字符串转换成秒（不带日期不带秒数）
 */
- (NSTimeInterval) timeStringToTimeIntervalSinceWithDateString:(NSString *)string;

/**
 *  秒转换成字符串（不带日期不带秒数）
 */
- (NSString *) timeIntervalSinceToDateStringWithDateInt:(NSInteger)dateInt;

/**
 *  获取当前系统时间
 */
- (NSString *) getNowSystemTime;

@end
