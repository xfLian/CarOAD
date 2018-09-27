//
//  EdiUserAgeChooseView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@class EdiUserAgeChooseView;

@protocol EdiUserAgeChooseViewDelegate <NSObject>

- (void) choosePickerDate:(EdiUserAgeChooseView *)pickerView
                 yearDate:(NSString *)yearString
              monthString:(NSString *)monthString
                dayString:(NSString *)dayString;

@end

@interface EdiUserAgeChooseView : CustomView

@property (nonatomic, weak) id<EdiUserAgeChooseViewDelegate> delegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *buttonText;

@property (nonatomic, retain) NSDate    *currentDate;
@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）

- (void) buildsubview;
- (void) showWithDuration:(CGFloat)duration animations:(BOOL)animations;
- (void) hideWithDuration:(CGFloat)duration animations:(BOOL)animations;

@end
