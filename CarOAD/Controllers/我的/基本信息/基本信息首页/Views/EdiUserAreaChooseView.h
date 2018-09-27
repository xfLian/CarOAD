//
//  EdiUserAreaChooseView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol EdiUserAreaChooseViewDelegate <NSObject>

/**
 获取到的城市信息

 @param provinceData 省份数据
 @param cityData 市数据
 @param areaData 区县数据
 */
- (void) getSelectedProvinceData:(NSDictionary *)provinceData
                        cityData:(NSDictionary *)cityData
                        areaData:(NSDictionary *)areaData;

@end

@interface EdiUserAreaChooseView : CustomView

@property (nonatomic, weak) id<EdiUserAreaChooseViewDelegate> delegate;

- (void) buildsubview;
- (void) showWithDuration:(CGFloat)duration animations:(BOOL)animations;
- (void) hideWithDuration:(CGFloat)duration animations:(BOOL)animations;

@end
