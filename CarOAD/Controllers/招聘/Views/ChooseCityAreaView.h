//
//  ChooseCityAreaView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ChooseCityAreaViewDelegate <NSObject>

/**
 获取到的城市信息

 @param provinceData 省份数据
 @param cityData 市数据
 @param areaData 区县数据
 */
- (void) choosedProvinceData:(NSDictionary *)provinceData
                    cityData:(NSDictionary *)cityData
                    areaData:(NSDictionary *)areaData;

@end

@interface ChooseCityAreaView : CustomView

@property (nonatomic, weak) id <ChooseCityAreaViewDelegate> delegate;
@property (nonatomic, strong) id selectedData;

@end
