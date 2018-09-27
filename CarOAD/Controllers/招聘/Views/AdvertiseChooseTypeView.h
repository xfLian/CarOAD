//
//  AdvertiseChooseTypeView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

typedef enum : NSUInteger {

    area_view,
    need_infomation_view,
    time_limit_view,
    car_type,
    demand_type,
    time_sort,

} EViewType;

@protocol AdvertiseChooseTypeViewDelegate <NSObject>

- (void) hideChooseTypeView;

@optional
/**
 获取到的城市信息

 @param provinceData 省份数据
 @param cityData 市数据
 @param areaData 区县数据
 */
- (void) choosedProvinceData:(NSDictionary *)provinceData
                    cityData:(NSDictionary *)cityData
                    areaData:(NSDictionary *)areaData;

/**
 获取到的要求信息

 @param salaryDataArray 月薪范围
 @param timeLimitDataArray 工作年限
 @param occupationDataArray 技术工种
 @param jobTypeDataArray 工作性质
 */
- (void) selectedSalaryData:(NSArray *)salaryDataArray
              timeLimitData:(NSArray *)timeLimitDataArray
             occupationData:(NSArray *)occupationDataArray
                jobTypeData:(NSArray *)jobTypeDataArray;

/**
 获取到的时间范围

 @param timeLimitData 时间范围数据
 */
- (void) selectedTimeLimitData:(NSDictionary *)timeLimitData;

/**
 选中的车辆品牌类型

 @param carBrandData 选中的车品牌
 @param carTypeData 选中的车类型
 */
- (void) selectedCarBrandData:(NSDictionary *)carBrandData
                  carTypeData:(NSDictionary *)carTypeData;

/**
 选中的需求类型

 @param demandTypeData 选中的需求类型
 */
- (void) selectedDemandTypeData:(NSDictionary *)demandTypeData;

/**
 选中的时间排序

 @param timeSortTypeData 选中的时间排序
 */
- (void) selectedTimeSortTypeData:(NSDictionary *)timeSortTypeData;

@end

@interface AdvertiseChooseTypeView : CustomView

@property (nonatomic, weak) id <AdvertiseChooseTypeViewDelegate> delegate;

- (void) showContentViewWithType:(EViewType)viewType contentDic:(NSDictionary *)contentDic;
- (void) show;
- (void) hide;

@end
