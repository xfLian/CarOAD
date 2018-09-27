//
//  EdiUserAgeChooseView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "EdiUserAgeChooseView.h"

#import "NSDate+Extension.h"
#import "DateKit.h"

typedef void(^doneBlock)(NSDate *,NSDate *);

@interface EdiUserAgeChooseView()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    CGRect stareRect;
    CGRect endRect;
    
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSString       *_dateFormatter;
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;

    NSInteger preRow;
    NSInteger MINYEAR;

    NSDate *_startDate;
    NSDate *_endDate;

}

@property (nonatomic, strong) UIPickerView *pickView;

@property (nonatomic, strong) NSString *yearString;
@property (nonatomic, strong) NSString *monthString;
@property (nonatomic, strong) NSString *dayString;

@property (nonatomic, retain) NSDate    *scrollToDate;//滚到指定日期
@property (nonatomic, strong) doneBlock  doneBlock;

@end

@implementation EdiUserAgeChooseView

- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

- (void)buildsubview {

    UIPickerView *pickView           = [[UIPickerView alloc] initWithFrame:self.bounds];
    pickView.showsSelectionIndicator = YES;
    pickView.backgroundColor         = [UIColor whiteColor];
    pickView.alpha                   = 1.f;
    pickView.delegate                = self;
    pickView.dataSource              = self;
    [self addSubview:pickView];
    self.pickView = pickView;

    endRect = pickView.frame;

    CGRect frame   = pickView.frame;
    frame.origin.y = self.height;
    pickView.frame = frame;
    stareRect      = frame;

    [self defaultConfig];

}

- (void) showWithDuration:(CGFloat)duration animations:(BOOL)animations; {

    [UIView animateWithDuration:duration animations:^{

        self.pickView.frame = endRect;

    } completion:^(BOOL finished) {

    }];

}

- (void) hideWithDuration:(CGFloat)duration animations:(BOOL)animations; {

    [UIView animateWithDuration:duration animations:^{

        self.pickView.frame = stareRect;

    } completion:^(BOOL finished) {

    }];

}

-(void)defaultConfig {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *scrollToDateString = [formatter stringFromDate:self.currentDate];

    self.scrollToDate = [formatter dateFromString:scrollToDateString];

    _yearArray  = [self setArray:_yearArray];
    _monthArray = [self setArray:_monthArray];
    _dayArray   = [self setArray:_dayArray];

    {

        NSInteger maxYear = self.maxLimitDate.year + 1;
        NSInteger minYear = self.minLimitDate.year;

        for (NSInteger i = minYear; i < maxYear; i++) {
            NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
            [_yearArray addObject:num];
        }

        //循环滚动时需要用到
        preRow  = (self.scrollToDate.year - minYear) * 12 + self.scrollToDate.month - 1;
        MINYEAR = minYear;
        
    }
    
    [self getNowDate:self.scrollToDate animated:NO];
    [self.pickView reloadAllComponents];

    self.yearString  = [NSString stringWithFormat:@"%ld",self.scrollToDate.year];
    self.monthString = [NSString stringWithFormat:@"%ld",self.scrollToDate.month];
    self.dayString   = [NSString stringWithFormat:@"%ld",self.scrollToDate.day];
    
    if (self.monthString.length == 1) {
        
        self.monthString = [NSString stringWithFormat:@"0%@",self.monthString];
        
    }
    
    if (self.dayString.length == 1) {
        
        self.dayString = [NSString stringWithFormat:@"0%@",self.dayString];
        
    }
    
    [_delegate choosePickerDate:self
                       yearDate:self.yearString
                    monthString:self.monthString
                      dayString:self.dayString];
    
}

-(void)addLineViewWithCount:(NSInteger)count {
    for (id subView in self.pickView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i = 0; i<count; i++) {
        CGRect frame      = CGRectZero;
        frame.size.width  = 17;
        frame.size.height = 1.5f;

        frame.origin.x = (self.pickView.width / (count + 1) * (i + 1))  - frame.size.width / 2;
        frame.origin.y = self.pickView.height / 2 - 1.5f;
        UILabel *lineView = [[UILabel alloc] init];
        lineView.frame = frame;
        lineView.backgroundColor = [UIColor blackColor];

        [self.pickView addSubview:lineView];
    }
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    [self addLineViewWithCount:2];
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];

    return [numberArr[component] integerValue];
}

-(NSArray *)getNumberOfRowsInComponent {

    NSInteger yearNum   = _yearArray.count;
    NSInteger monthNum  = [self DaysOfMonthfromYear:[_yearArray[yearIndex] integerValue]];
    
    CarOadLog(@"_monthArray --- %ld",_monthArray.count);
    
    for (NSString *title in _monthArray) {
        CarOadLog(@"title --- %@",title);
    }
    
    NSInteger dayNum    = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    
    return @[@(yearNum),@(monthNum),@(dayNum)];

}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {

    return 40;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *customLabel = (UILabel *)view;

    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.adjustsFontSizeToFitWidth = YES;
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setBackgroundColor:[UIColor clearColor]];
        [customLabel setFont:UIFont_18];
        customLabel.textColor = TextBlackColor;
    }
    NSString *title;

    if (component==0) {
        title = _yearArray[row];
    }
    if (component==1) {
        title = _monthArray[row];
    }
    if (component==2) {
        title = _dayArray[row];
    }

    customLabel.text = title;
    return customLabel;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if (component == 0) {
        yearIndex = row;
    }
    if (component == 1) {
        monthIndex = row;
    }
    if (component == 2) {
        dayIndex = row;
    }
    
    if (component == 0){
        [self DaysOfMonthfromYear:[_yearArray[yearIndex] integerValue]];
        if (_monthArray.count-1<monthIndex) {
            monthIndex = _monthArray.count-1;
        }
        
    }
    
    if (component == 0 || component == 1){
        [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        if (_dayArray.count-1<dayIndex) {
            dayIndex = _dayArray.count-1;
        }

    }
    
    self.yearString = [NSString stringWithFormat:@"%@",_yearArray[yearIndex]];
    self.monthString = [NSString stringWithFormat:@"%@",_monthArray[monthIndex]];
    self.dayString = [NSString stringWithFormat:@"%@",_dayArray[dayIndex]];

    [pickerView reloadAllComponents];

    [_delegate choosePickerDate:self
                       yearDate:self.yearString
                    monthString:self.monthString
                      dayString:self.dayString];

}

#pragma mark - tools
//通过年求月数
- (NSInteger)DaysOfMonthfromYear:(NSInteger)year {
    
    NSInteger num_year  = year;
    NSInteger maxYear = self.maxLimitDate.year;
    NSInteger maxMonth = self.maxLimitDate.month;
    
    if (num_year == maxYear) {
        
        [self setMonthArray:maxMonth];
        return maxMonth;
        
    } else {
        
        [self setMonthArray:60];
        return 12;
        
    }
    
}

- (void)setMonthArray:(NSInteger)num
{
    [_monthArray removeAllObjects];
    
    for (int i=1; i<=num; i++) {
        
        [_monthArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
}

//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;

    NSInteger maxYear = self.maxLimitDate.year;
    NSInteger maxMonth = self.maxLimitDate.month;
    NSInteger maxDay = self.maxLimitDate.day;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    
    if (num_year == maxYear) {
        
        if (num_month < maxMonth) {
            
            switch (num_month) {
                case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
                    
                    [self setdayArray:31];
                    return 31;
                }
                case 4:case 6:case 9:case 11:{
                    [self setdayArray:30];
                    return 30;
                }
                case 2:{
                    if (isrunNian) {
                        [self setdayArray:29];
                        return 29;
                    }else{
                        [self setdayArray:28];
                        return 28;
                    }
                }
                default:
                    break;
            }
            
        } else if (num_month == maxMonth) {
            
            switch (num_month) {
                case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
                    
                    [self setdayArray:maxDay];
                    return maxDay;
                }
                case 4:case 6:case 9:case 11:{
                    
                    if (maxDay > 30) {
                        [self setdayArray:30];
                        return 30;
                    } else {
                        [self setdayArray:maxDay];
                        return maxDay;
                    }
                    
                }
                case 2:{
                    if (isrunNian) {
                        
                        if (maxDay > 29) {
                            [self setdayArray:29];
                            return 29;
                        } else {
                            [self setdayArray:maxDay];
                            return maxDay;
                        }
                        
                    }else{
                        
                        if (maxDay > 28) {
                            [self setdayArray:28];
                            return 28;
                        } else {
                            [self setdayArray:maxDay];
                            return maxDay;
                        }
                    }
                }
                default:
                    break;
            }
            
        }
        
    } else {
        
        switch (num_month) {
            case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
                [self setdayArray:31];
                return 31;
            }
            case 4:case 6:case 9:case 11:{
                [self setdayArray:30];
                return 30;
            }
            case 2:{
                if (isrunNian) {
                    [self setdayArray:29];
                    return 29;
                }else{
                    [self setdayArray:28];
                    return 28;
                }
            }
            default:
                break;
        }
        
    }
    
    return 0;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    
    for (int i=1; i<=num; i++) {
        
        [_dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    if (!date) {
        date = [NSDate date];
    }
    
    [self DaysOfMonthfromYear:date.year];
    [self DaysfromYear:date.year andMonth:date.month];

    yearIndex  = date.year-MINYEAR;
    monthIndex = date.month-1;
    dayIndex   = date.day-1;
    
    NSArray *indexArray;

    indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex)];

    [self.pickView reloadAllComponents];

    for (int i = 0; i<indexArray.count; i++) {

        [self.pickView selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];

    }

}

@end
