//
//  AMapMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"
#import "AMapAddressData.h"

@class AMapMainView;

@protocol AMapMainViewDelegate <NSObject>

- (void) updataUserLocationWithLocation:(CLLocation *)location;
- (void) userLocationMakeADifferenceWithNewLocation:(CLLocation *)newLocation;

@end

@interface AMapMainView : CustomView

@property (nonatomic, weak) id <AMapMainViewDelegate> delegate;

/**
 添加点标记

 @param poi poi数据
 */
- (void) addPointAnnotationWithPoiData:(AMapAddressData *)poi;

/**
 设置地图中心点

 @param location 定位点坐标
 */
- (void) setMapViewCenterWithLocation:(AMapGeoPoint *)location;

@end
