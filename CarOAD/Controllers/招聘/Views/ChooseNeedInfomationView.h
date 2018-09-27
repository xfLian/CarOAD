//
//  ChooseNeedInfomationView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ChooseNeedInfomationViewDelegate <NSObject>

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

@end

@interface ChooseNeedInfomationView : CustomView

@property (nonatomic, weak) id <ChooseNeedInfomationViewDelegate> delegate;

@property (nonatomic, strong) id selectedData;

@end
