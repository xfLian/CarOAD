//
//  EdiUserInfomationChooseTypeView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "EdiUserInfomationChooseTypeView.h"

#import "EdiJobStatusChooseView.h"
#import "EdiUserAreaChooseView.h"
#import "EdiUserAgeChooseView.h"
#import "PublishMySkillChooseTypeOfServiceView.h"

@interface EdiUserInfomationChooseTypeView()<EdiJobStatusChooseViewDelegate, EdiUserAreaChooseViewDelegate, EdiUserAgeChooseViewDelegate, PublishMySkillChooseTypeOfServiceViewDelegate>
{

    id selectedData;
    NSDictionary *selectedProvinceData;
    NSDictionary *selectedCityData;
    NSDictionary *selectedAreaData;
    
    NSDictionary *selectedCategoryData;
    NSDictionary *selectedCatenaData;
    NSDictionary *selectedCategoryInfoData;

    NSString *selectedYearString;
    NSString *selectedMonthString;
    NSString *selectedDayString;

}
@property (nonatomic, strong) UIWindow *windows;
@property (nonatomic, strong) UIView   *backView;
@property (nonatomic, strong) UIView   *maskView;
@property (nonatomic, strong) UIView   *contentView;

@property (nonatomic, assign) EChooseJobTypeType      viewType;
@property (nonatomic, strong) EdiJobStatusChooseView *chooseJobStatusView;
@property (nonatomic, strong) EdiUserAreaChooseView  *chooseAreaView;
@property (nonatomic, strong) EdiUserAgeChooseView   *chooseAgeView;
@property (nonatomic, strong) PublishMySkillChooseTypeOfServiceView *chooseTypeOfServiceView;

@end

@implementation EdiUserInfomationChooseTypeView

- (void)buildViewWithType:(EChooseJobTypeType)viewType {

    //  获取目前页面窗口
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    self.windows      = windows;

    //  创建背景view
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windows.width,  windows.height)];

    //  创建容器view
    UIView *maskView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width,  backView.height)];
    maskView.backgroundColor = [UIColor grayColor];
    maskView.alpha           = 0.3f;
    [backView addSubview:maskView];
    self.maskView = maskView;

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(KeyboardHide)];
    tapGestureRecognizer.cancelsTouchesInView    = NO;
    [maskView addGestureRecognizer:tapGestureRecognizer];

    [windows addSubview:backView];
    self.backView = backView;

    UIView *contentView         = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height, backView.width,  250 *Scale_Height)];
    contentView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:contentView];
    self.contentView = contentView;

    UIButton *closebutton = [UIButton createButtonWithFrame:CGRectMake(20 *Scale_Width, 10 *Scale_Height, 60 *Scale_Width, 30 *Scale_Height)
                                                 title:@"取消"
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    closebutton.backgroundColor     = MainColor;
    closebutton.layer.masksToBounds = YES;
    closebutton.layer.cornerRadius  = 3 *Scale_Height;
    closebutton.titleLabel.font     = UIFont_15;
    [closebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:closebutton];

    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(contentView.width - 80 *Scale_Width, 10 *Scale_Height, 60 *Scale_Width, 30 *Scale_Height)
                                                 title:@"确定"
                                       backgroundImage:nil
                                                   tag:1001
                                                target:self
                                                action:@selector(buttonEvent:)];
    button.backgroundColor     = MainColor;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius  = 3 *Scale_Height;
    button.titleLabel.font     = UIFont_15;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:button];

    UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5 *Scale_Height, contentView.width, 0.5 *Scale_Width)];
    lineView.backgroundColor = LineColor;
    [contentView addSubview:lineView];

    CGRect frame   = contentView.frame;
    frame.origin.y = backView.height - 250 *Scale_Height;

    [UIView animateWithDuration:0.3f animations:^{

        contentView.frame = frame;

    }];

    NSArray *contentArray = nil;

    if (viewType == job_status_view || viewType == education_view || viewType == work_experience_view || viewType == salary_range_view || viewType == type_of_work_view || viewType == nature_of_work_view || viewType == cert_level_view || viewType == skill_level_view || viewType == unit_view) {

        if (viewType == job_status_view) {

            contentArray = @[@{@"title":@"在职-考虑机会",
                               @"titleId":@"1"}
                             ,@{@"title":@"离职-可随时到岗",
                                @"titleId":@"2"}
                             ,@{@"title":@"在职-月底到岗",
                                @"titleId":@"3"}
                             ,@{@"title":@"在职-暂不考虑",
                                @"titleId":@"4"}];

        } else if (viewType == education_view) {

            contentArray = @[@{@"title":@"高中以下",
                                @"titleId":@"2"}
                             ,@{@"title":@"高中",
                                @"titleId":@"3"}
                             ,@{@"title":@"中专",
                                @"titleId":@"4"}
                             ,@{@"title":@"大专",
                                @"titleId":@"5"}
                             ,@{@"title":@"本科及以上",
                                @"titleId":@"6"}];
            
        } else if (viewType == work_experience_view) {

            contentArray = @[@{@"title":@"不限",
                                @"titleId":@"1"}
                             ,@{@"title":@"应届生",
                                @"titleId":@"2"}
                             ,@{@"title":@"1年以内",
                                @"titleId":@"3"}
                             ,@{@"title":@"1-3年",
                                @"titleId":@"4"}
                             ,@{@"title":@"3-5年",
                                @"titleId":@"5"}
                             ,@{@"title":@"5-10年",
                                @"titleId":@"6"}
                             ,@{@"title":@"10年以上",
                                @"titleId":@"7"}];

        } else if (viewType == salary_range_view) {
            
            contentArray = @[@{@"title":@"面议",
                               @"titleId":@"1"}
                             ,@{@"title":@"1千-3千",
                                @"titleId":@"2"}
                             ,@{@"title":@"3千-5千",
                                @"titleId":@"3"}
                             ,@{@"title":@"5千-8千",
                                @"titleId":@"4"}
                             ,@{@"title":@"8千-1万",
                                @"titleId":@"5"}
                             ,@{@"title":@"1万以上",
                                @"titleId":@"6"}];
            
        } else if (viewType == type_of_work_view) {
            
            contentArray = @[@{@"title":@"洗车工",
                                @"titleId":@"1"}
                             ,@{@"title":@"美容工",
                                @"titleId":@"2"}
                             ,@{@"title":@"维修工",
                                @"titleId":@"3"}
                             ,@{@"title":@"钣金工",
                                @"titleId":@"4"}
                             ,@{@"title":@"喷漆工",
                                @"titleId":@"5"}
                             ,@{@"title":@"机电工",
                                @"titleId":@"6"}];
            
        } else if (viewType == nature_of_work_view) {
            
            contentArray = @[@{@"title":@"不限",
                               @"titleId":@"1"}
                             ,@{@"title":@"全职",
                                @"titleId":@"2"}
                             ,@{@"title":@"兼职",
                                @"titleId":@"3"}
                             ,@{@"title":@"实习",
                                @"titleId":@"4"}];
            
        } else if (viewType == cert_level_view) {
            
            contentArray = @[@{@"title":@"一级",
                               @"titleId":@"1"}
                             ,@{@"title":@"二级",
                                @"titleId":@"2"}
                             ,@{@"title":@"三级",
                                @"titleId":@"3"}];
            
        } else if (viewType == skill_level_view) {
            
            contentArray = @[@{@"title":@"初级",
                               @"titleId":@"1"}
                             ,@{@"title":@"中级",
                                @"titleId":@"2"}
                             ,@{@"title":@"高级",
                                @"titleId":@"3"}];
            
        } else if (viewType == unit_view) {
            
            contentArray = @[@{@"title":@"周",
                               @"titleId":@"1"}
                             ,@{@"title":@"小时",
                                @"titleId":@"2"}
                             ,@{@"title":@"次",
                                @"titleId":@"3"}];
            
        }
        
        EdiJobStatusChooseView *chooseJobStatusView = [[EdiJobStatusChooseView alloc] initWithFrame:CGRectMake(0, 50 *Scale_Height, backView.width, 200 *Scale_Height)];
        chooseJobStatusView.data = contentArray;
        chooseJobStatusView.delegate = self;
        [chooseJobStatusView buildsubview];
        [contentView addSubview:chooseJobStatusView];
        [chooseJobStatusView showWithDuration:0.3f animations:YES];
        self.chooseJobStatusView = chooseJobStatusView;

    } else if (viewType == address_view) {

        EdiUserAreaChooseView  *chooseAreaView = [[EdiUserAreaChooseView alloc] initWithFrame:CGRectMake(0, 50 *Scale_Height, backView.width, 200 *Scale_Height)];
        chooseAreaView.data = contentArray;
        chooseAreaView.delegate = self;
        [chooseAreaView buildsubview];
        [contentView addSubview:chooseAreaView];
        [chooseAreaView showWithDuration:0.3f animations:YES];
        self.chooseAreaView = chooseAreaView;

    } else if (viewType == sercice_type_view) {
        
        PublishMySkillChooseTypeOfServiceView  *chooseTypeOfServiceView = [[PublishMySkillChooseTypeOfServiceView alloc] initWithFrame:CGRectMake(0, 50 *Scale_Height, backView.width, 200 *Scale_Height)];
        chooseTypeOfServiceView.data = contentArray;
        chooseTypeOfServiceView.delegate = self;
        [chooseTypeOfServiceView buildsubview];
        [contentView addSubview:chooseTypeOfServiceView];
        [chooseTypeOfServiceView showWithDuration:0.3f animations:YES];
        self.chooseTypeOfServiceView = chooseTypeOfServiceView;
        
    } else if (viewType == age_view) {

        NSString *minDateString = @"1900-01-01";

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        //  开始结束时间
        NSDate *minDate = [formatter dateFromString:minDateString];

        EdiUserAgeChooseView *chooseAgeView = [[EdiUserAgeChooseView alloc] initWithFrame:CGRectMake(0, 50 *Scale_Height, backView.width, 200 *Scale_Height)];
        chooseAgeView.minLimitDate = minDate;
        chooseAgeView.maxLimitDate = [NSDate date];
        chooseAgeView.currentDate  = [NSDate date];
        chooseAgeView.delegate = self;
        [chooseAgeView buildsubview];
        [contentView addSubview:chooseAgeView];
        [chooseAgeView showWithDuration:0.3f animations:YES];
        self.chooseAgeView = chooseAgeView;
        
    }

}

#pragma mark - EdiJobStatusChooseViewDelegate
- (void) getSelectedData:(id)data; {

    selectedData = data;

}

#pragma mark - EdiUserAreaChooseViewDelegate
- (void) getSelectedProvinceData:(NSDictionary *)provinceData
                        cityData:(NSDictionary *)cityData
                        areaData:(NSDictionary *)areaData; {

    selectedProvinceData = provinceData;
    selectedCityData     = cityData;
    selectedAreaData     = areaData;

}

#pragma mark - PublishMySkillChooseTypeOfServiceViewDelegate
- (void) getSelectedCategoryData:(NSDictionary *)categoryData
                      catenaData:(NSDictionary *)catenaData
                   categoryInfoData:(NSDictionary *)categoryInfoData; {
    
    selectedCategoryData  = categoryData;
    selectedCatenaData    = catenaData;
    selectedCategoryInfoData = categoryInfoData;
    
}

#pragma mark - EdiUserAgeChooseViewDelegate
- (void) choosePickerDate:(EdiUserAgeChooseView *)pickerView yearDate:(NSString *)yearString monthString:(NSString *)monthString dayString:(NSString *)dayString; {

    selectedYearString = yearString;
    selectedMonthString = monthString;
    selectedDayString = dayString;

}

- (void) buttonEvent:(UIButton *)sender {

    [self hide];

    if (sender.tag == 1001) {

        if (self.viewType == job_status_view || self.viewType == education_view || self.viewType == work_experience_view || self.viewType == salary_range_view || self.viewType == type_of_work_view || self.viewType == nature_of_work_view || self.viewType == cert_level_view || self.viewType == skill_level_view || self.viewType == unit_view) {

            [_delegate chooseJobTypeWithData:selectedData forViewType:self.viewType];

        } else if (self.viewType == address_view) {

            [_delegate getSelectedProvinceData:selectedProvinceData
                                      cityData:selectedCityData
                                      areaData:selectedAreaData];

        } else if (self.viewType == age_view) {

            [_delegate chooseYearDate:selectedYearString
                          monthString:selectedMonthString
                            dayString:selectedDayString];

        } else if (self.viewType == sercice_type_view) {
            
            [_delegate getSelectedCategoryData:selectedCategoryData
                                    catenaData:selectedCatenaData
                                 categoryInfoData:selectedCategoryInfoData];
            
        }
        
    }
    
}

- (void) showChooseTypeViewWithType:(EChooseJobTypeType)viewType; {

    self.viewType = viewType;

    [self buildViewWithType:viewType];

}

- (void) hide; {

    CGRect frame   = self.contentView.frame;
    frame.origin.y = self.backView.height;

    [UIView animateWithDuration:0.25f animations:^{

        self.contentView.frame = frame;
        self.maskView.alpha    = 0.f;

    } completion:^(BOOL finished) {

        for (UIView *view in self.backView.subviews) {
            
            [view removeFromSuperview];
            
        }
        [self.backView removeFromSuperview];

    }];

}

- (void) KeyboardHide; {

    [self hide];

}

@end
