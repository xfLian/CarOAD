//
//  AdvertiseChooseTypeView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AdvertiseChooseTypeView.h"

#import "ChooseCityAreaView.h"
#import "ChooseNeedInfomationView.h"
#import "ChooseTimeLimitView.h"
#import "ChooseCarTypeView.h"
#import "ChooseNeedTypeView.h"
#import "ChooseTimeSortTypeView.h"

@interface AdvertiseChooseTypeView()<ChooseCityAreaViewDelegate, ChooseNeedInfomationViewDelegate, ChooseTimeLimitViewDelegate, ChooseCarTypeViewDelegate, ChooseNeedTypeViewDelegate, ChooseTimeSortTypeViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) CGRect startRect;
@property (nonatomic, assign) CGRect endRect;

@end

@implementation AdvertiseChooseTypeView

- (void)buildsubview {

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];

    //  创建容器view
    UIView *maskView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width,  backView.height)];
    maskView.backgroundColor = [UIColor grayColor];
    maskView.alpha           = 0.6f;
    [backView addSubview:maskView];
    self.maskView = maskView;

    UIButton *button = [UIButton createButtonWithFrame:maskView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [maskView addSubview:button];

    UIView *contentView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width, backView.height - 200 *Scale_Height)];
    contentView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:contentView];
    self.contentView = contentView;

    self.endRect = contentView.frame;

    CGRect frame      = contentView.frame;
    frame.size.height = 0;
    contentView.frame = frame;

    self.startRect = frame;

    [self addSubview:backView];

    self.backView = backView;

}

- (void) showContentViewWithType:(EViewType)viewType contentDic:(NSDictionary *)contentDic; {

    for (UIView *subView in self.contentView.subviews) {

        if (subView) {

            [subView removeFromSuperview];

        }

    }

    if (viewType == area_view) {

        ChooseCityAreaView *cityAreaView = [[ChooseCityAreaView alloc] initWithFrame:self.contentView.bounds];
        cityAreaView.delegate            = self;
        [self.contentView addSubview:cityAreaView];

        cityAreaView.selectedData = contentDic;
        [cityAreaView loadContent];

    } else if (viewType == need_infomation_view) {

        ChooseNeedInfomationView *needInfomationView = [[ChooseNeedInfomationView alloc] initWithFrame:self.contentView.bounds];
        needInfomationView.delegate                  = self;
        [self.contentView addSubview:needInfomationView];

        needInfomationView.selectedData = contentDic;

        [needInfomationView loadContent];

    } else if (viewType == time_limit_view) {

        ChooseTimeLimitView *timeLimitView = [[ChooseTimeLimitView alloc] initWithFrame:self.contentView.bounds];
        timeLimitView.delegate             = self;
        [self.contentView addSubview:timeLimitView];

        [timeLimitView loadContent];
        
    } else if (viewType == car_type) {

        ChooseCarTypeView *carTypeView = [[ChooseCarTypeView alloc] initWithFrame:self.contentView.bounds];
        carTypeView.delegate           = self;
        [self.contentView addSubview:carTypeView];

        carTypeView.selectedData = contentDic;

        [carTypeView loadContent];

    } else if (viewType == demand_type) {

        ChooseNeedTypeView *needTypeView = [[ChooseNeedTypeView alloc] initWithFrame:self.contentView.bounds];
        needTypeView.delegate            = self;
        [self.contentView addSubview:needTypeView];

        needTypeView.selectedData = contentDic;

        [needTypeView loadContent];

    } else if (viewType == time_sort) {

        ChooseTimeSortTypeView *timeSortTypeView = [[ChooseTimeSortTypeView alloc] initWithFrame:self.contentView.bounds];
        timeSortTypeView.delegate                = self;
        [self.contentView addSubview:timeSortTypeView];

        timeSortTypeView.selectedData = contentDic;

        [timeSortTypeView loadContent];

    }

}

- (void) show; {

    self.hidden = NO;

    for (UIView *subView in self.subviews) {

        if (subView) {

            [subView removeFromSuperview];

        }

    }
    [self buildsubview];

    self.backView.alpha = 1.f;

    [UIView animateWithDuration:0.25f animations:^{

        self.contentView.frame = self.endRect;

    }];

}

- (void) hide; {

    [UIView animateWithDuration:0.15f animations:^{

        self.backView.alpha = 0.f;

    }];

    for (UIView *view in self.backView.subviews) {

        [view removeFromSuperview];

    }

    [self.backView removeFromSuperview];

    self.hidden = YES;

}

- (void) buttonEvent:(UIButton *)sender {

    [self hide];
    [_delegate hideChooseTypeView];

}

#pragma mark - ChooseCityAreaViewDelegate
- (void) choosedProvinceData:(NSDictionary *)provinceData
                    cityData:(NSDictionary *)cityData
                    areaData:(NSDictionary *)areaData; {

    [self hide];
    [_delegate choosedProvinceData:provinceData cityData:cityData areaData:areaData];
    
}

#pragma mark - ChooseNeedInfomationViewDelegate
- (void) selectedSalaryData:(NSArray *)salaryDataArray
              timeLimitData:(NSArray *)timeLimitDataArray
             occupationData:(NSArray *)occupationDataArray
                jobTypeData:(NSArray *)jobTypeDataArray; {

    [self hide];
    [_delegate selectedSalaryData:salaryDataArray
                    timeLimitData:timeLimitDataArray
                   occupationData:occupationDataArray
                      jobTypeData:jobTypeDataArray];

}

#pragma mark - ChooseTimeLimitViewDelegate
- (void) selectedTimeLimitData:(NSDictionary *)timeLimitData; {

    [self hide];
    [_delegate selectedTimeLimitData:timeLimitData];

}

#pragma mark - ChooseCarTypeViewDelegate
- (void) selectedCarBrandData:(NSDictionary *)carBrandData
                  carTypeData:(NSDictionary *)carTypeData; {

    [self hide];
    [_delegate selectedCarBrandData:carBrandData carTypeData:carTypeData];

}

#pragma mark - ChooseNeedTypeViewDelegate
- (void) selectedDemandTypeData:(NSDictionary *)demandTypeData; {

    [self hide];
    [_delegate selectedDemandTypeData:demandTypeData];

}

#pragma mark - ChooseTimeSortTypeViewDelegate
- (void) selectedTimeSortTypeData:(NSDictionary *)timeSortTypeData; {

    [self hide];
    [_delegate selectedTimeSortTypeData:timeSortTypeData];

}

@end
