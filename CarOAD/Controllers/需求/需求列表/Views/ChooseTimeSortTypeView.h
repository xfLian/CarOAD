//
//  ChooseTimeSortTypeView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/4.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ChooseTimeSortTypeViewDelegate <NSObject>

/**
 选中的时间排序

 @param timeSortTypeData 选中的时间排序
 */
- (void) selectedTimeSortTypeData:(NSDictionary *)timeSortTypeData;

@end

@interface ChooseTimeSortTypeView : CustomView

@property (nonatomic, weak) id <ChooseTimeSortTypeViewDelegate> delegate;
@property (nonatomic, strong) id selectedData;

@end
