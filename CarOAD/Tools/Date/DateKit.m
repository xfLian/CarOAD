//
//  DateKit.m
//  夏半微凉
//
//  Created by xf_Lian on 16/7/12.
//  Copyright © 2016年 xf_Lian. All rights reserved.
//

#import "DateKit.h"

@implementation DateKit

//  时间戳转换为时间
+ (NSString *) dateStamp:(NSString *)strTime {
    
    NSTimeInterval  time = [strTime doubleValue];
    NSDate         *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    
    //  实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    //  设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
    
}

//  时间戳转换为时间
+ (NSString *) timeStamp:(NSString *)strTime {
    
    NSTimeInterval   time = [strTime doubleValue];
    NSDate          *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    
    //  实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    //  设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
    
}


+ (NSDate *) stringToDateWithString:(NSString *)dateString {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    if ([dateString containsString:@" "]) {
        NSLog(@"str 包含 空格");
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    } else {
        NSLog(@"str 不存在 空格");
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate * date = [formatter dateFromString:dateString];
    return date;
}

+ (NSString *) dateToStringWithDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *dateString = [formatter stringFromDate:date];

    return dateString;
}

+ (NSString *) getYTDStringWithDate:(NSDate *)date; {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;

}

+ (NSString *) getHourStringWithDate:(NSDate *)date; {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;

}

// 日期和字符串之间的转换 获取时分
+ (NSString *) getMinuteStringWithDate:(NSDate *)date; {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;

}

+ (NSString *) getweekDayWithDate:(NSDate *)date {
    
    NSCalendar       *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps    = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSArray  *weekArr  = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *week     = weekArr[[comps weekday] - 1];
    
    return week;
    
}

- (BOOL) firstTime:(NSString *)firstTime isGreaterThanSecondTime:(NSString *)secondTime; {
    
    NSTimeInterval _fitstDate  = [self timeStringToTimeIntervalWithString:firstTime];
    NSTimeInterval _secondDate = [self timeStringToTimeIntervalWithString:secondTime];
    
    if (_fitstDate - _secondDate >= 0) {
        
        return YES;
    } else {
    
        return NO;
    }
}

- (NSInteger) getTimeCodeWithRiseTime:(NSString *)riseTime
                              setTime:(NSString *)setTime; {
    
    NSString *nowTime = [self getNowSystemTime];
    
    //  计算日出日落前后20分钟时间
    NSTimeInterval  beforeRiseTime  = [self timeStringToTimeIntervalWithString:riseTime] - 20*60;
    NSTimeInterval  lateRiseTime    = [self timeStringToTimeIntervalWithString:riseTime] + 20*60;
    NSTimeInterval  beforeSetTime   = [self timeStringToTimeIntervalWithString:setTime] - 20*60;
    NSTimeInterval  lateSetTime     = [self timeStringToTimeIntervalWithString:setTime] + 20*60;
    
    //  日出日落前后20分钟时间转字符串
    NSString  *beforeRiseTimeString = [self timeIntervalSinceToDateStringWithDateInt:beforeRiseTime];
    NSString  *lateRiseTimeString   = [self timeIntervalSinceToDateStringWithDateInt:lateRiseTime];
    NSString  *beforeSetTimeString  = [self timeIntervalSinceToDateStringWithDateInt:beforeSetTime];
    NSString  *lateSetTimeString    = [self timeIntervalSinceToDateStringWithDateInt:lateSetTime];

    //  夜晚到日出
    if ([self firstTime:nowTime isGreaterThanSecondTime:beforeRiseTimeString] &&[self firstTime:lateRiseTimeString isGreaterThanSecondTime:nowTime]) {
        return 1;
    }
    
    //  日出到6点
    if ([self firstTime:nowTime isGreaterThanSecondTime:lateRiseTimeString] && [self firstTime:@"06:00" isGreaterThanSecondTime:nowTime]) {
        return 2;
    }
    
    //  6点到7点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"06:00"] && [self firstTime:@"07:00" isGreaterThanSecondTime:nowTime]) {
        return 3;
    }
    
    //  7点到8点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"07:00"] && [self firstTime:@"08:00" isGreaterThanSecondTime:nowTime]) {
        return 4;
    }
    
    //  8点到9点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"08:00"] && [self firstTime:@"09:00" isGreaterThanSecondTime:nowTime]) {
        return 5;
    }
    
    //  9点到10点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"09:00"] && [self firstTime:@"10:00" isGreaterThanSecondTime:nowTime]) {
        return 6;
    }
    
    //  10点到11点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"10:00"] && [self firstTime:@"11:00" isGreaterThanSecondTime:nowTime]) {
        return 7;
    }
    
    //  11点到12点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"11:00"] && [self firstTime:@"12:00" isGreaterThanSecondTime:nowTime]) {
        return 8;
    }
    
    //  12点到13点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"12:00"] && [self firstTime:@"13:00" isGreaterThanSecondTime:nowTime]) {
        return 9;
    }
    
    //  13点到14点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"13:00"] && [self firstTime:@"14:00" isGreaterThanSecondTime:nowTime]) {
        return 10;
    }
    
    //  14点到15点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"14:00"] && [self firstTime:@"15:00" isGreaterThanSecondTime:nowTime]) {
        return 11;
    }
    
    //  15点到16点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"15:00"] && [self firstTime:@"16:00" isGreaterThanSecondTime:nowTime]) {
        return 12;
    }
    
    //  16点到17点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"16:00"] && [self firstTime:@"17:00" isGreaterThanSecondTime:nowTime]) {
        return 13;
    }
    
    //  17点到18点
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"17:00"] && [self firstTime:@"18:00" isGreaterThanSecondTime:nowTime]) {
        return 14;
    }
    
    //  18点到日落
    if ([self firstTime:nowTime isGreaterThanSecondTime:@"18:00"] && [self firstTime:setTime isGreaterThanSecondTime:nowTime]) {
        return 15;
    }

    //  日出到夜晚
    if ([self firstTime:nowTime isGreaterThanSecondTime:beforeSetTimeString] && [self firstTime:lateSetTimeString isGreaterThanSecondTime:nowTime]) {
        return 16;
    }
    
    return 0;
    
}

/**
 *  字符串转换成秒（带日期）
 */
- (NSTimeInterval) timeStringToTimeIntervalWithString:(NSString *)string {
    
    NSString        *tmpTime   = [NSString stringWithFormat:@"%@:00",string];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate          *date      = [formatter dateFromString:tmpTime];
    NSTimeInterval  _date      = [date timeIntervalSince1970]*1;
    
    return _date;
}

/**
 *  字符串转换成秒（不带日期不带秒数）
 */
- (NSTimeInterval) timeStringToTimeIntervalSinceWithDateString:(NSString *)string; {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate          *date      = [formatter dateFromString:string];
    NSTimeInterval  _date      = [date timeIntervalSince1970];
    
    return _date;

}

/**
 *  秒转换成字符串（不带日期不带秒数）
 */
- (NSString *) timeIntervalSinceToDateStringWithDateInt:(NSInteger)dateInt; {
    
    long long int    dateLLInt   = (long long int)dateInt;
    NSDate          *date        = [NSDate dateWithTimeIntervalSince1970:dateLLInt];
    NSDateFormatter *formatter   = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss"];
    NSString        *dateString = [formatter stringFromDate:date];
    return dateString;
    
}

/**
 *  获取当前系统时间
 */
- (NSString *) getNowSystemTime {
    
    //获取当前系统时间
    NSCalendar       *calendar   = \
    [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate           *now        = [NSDate date];
    NSDateComponents *comps      = [[NSDateComponents alloc] init];
    NSInteger         unitFlags  = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour | NSCalendarUnitMinute;
    comps                        = [calendar components:unitFlags fromDate:now];
    NSInteger         year       = [comps year];
    NSInteger         month      = [comps month];
    NSInteger         day        = [comps day];
    NSInteger         hour       = [comps hour];
    NSInteger         min        = [comps minute];
    NSString         *hourString = nil;
    NSString         *minString  = nil;
    NSString         *monthString = nil;
    NSString         *dayString  = nil;
    
    if (month < 10) {
        
        monthString = [NSString stringWithFormat:@"0%ld",(long)month];
        
    } else {
        
        monthString = [NSString stringWithFormat:@"%ld",(long)month];
        
    }
    
    if (day < 10) {
        
        dayString = [NSString stringWithFormat:@"0%ld",(long)day];
    } else {
        
        dayString = [NSString stringWithFormat:@"%ld",(long)day];
    }
    
    if (hour < 10) {
        
        hourString = [NSString stringWithFormat:@"0%ld",(long)hour];
    } else {
        
        hourString = [NSString stringWithFormat:@"%ld",(long)hour];
    }
    
    if (min < 10) {
        
        minString = [NSString stringWithFormat:@"0%ld",(long)min];
    } else {
        
        minString = [NSString stringWithFormat:@"%ld",(long)min];
    }
    
    //  当前系统时间
    NSString *nowTime = [NSString stringWithFormat:@"%ld-%@-%@ %@:%@",year,monthString,dayString,hourString,minString];
    
    return nowTime;
    
}

@end
