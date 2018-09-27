//
//  EdiUserInfomationChooseTypeView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

typedef enum : NSUInteger {

    job_status_view = 0,
    address_view,
    age_view,
    education_view,
    work_experience_view,
    salary_range_view,
    type_of_work_view,
    nature_of_work_view,
    cert_level_view,
    skill_level_view,
    unit_view,
    sercice_type_view,

} EChooseJobTypeType;

@protocol EdiUserInfomationChooseTypeViewDelegate <NSObject>

@optional
- (void) chooseJobTypeWithData:(id)data forViewType:(EChooseJobTypeType)viewType;

- (void) getSelectedProvinceData:(NSDictionary *)provinceData
                        cityData:(NSDictionary *)cityData
                        areaData:(NSDictionary *)areaData;

- (void) chooseYearDate:(NSString *)yearString
            monthString:(NSString *)monthString
              dayString:(NSString *)dayString;

- (void) getSelectedCategoryData:(NSDictionary *)categoryData
                      catenaData:(NSDictionary *)catenaData
                   categoryInfoData:(NSDictionary *)categoryInfoData;

@end

@interface EdiUserInfomationChooseTypeView : CustomView

@property (nonatomic, weak) id<EdiUserInfomationChooseTypeViewDelegate> delegate;

- (void) showChooseTypeViewWithType:(EChooseJobTypeType)viewType;
- (void) hide;

@end
