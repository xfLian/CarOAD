//
//  ChooseCarTypeView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/3.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ChooseCarTypeViewDelegate <NSObject>

/**
 选中的车辆品牌类型

 @param carBrandData 选中的车品牌
 @param carTypeData 选中的车类型
 */
- (void) selectedCarBrandData:(NSDictionary *)carBrandData
                  carTypeData:(NSDictionary *)carTypeData;

@end

@interface ChooseCarTypeView : CustomView

@property (nonatomic, weak) id <ChooseCarTypeViewDelegate> delegate;
@property (nonatomic, strong) id selectedData;

@end
