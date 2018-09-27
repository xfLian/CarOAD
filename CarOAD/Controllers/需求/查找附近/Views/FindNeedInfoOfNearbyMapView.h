//
//  FindNeedInfoOfNearbyMapView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

#import "AMapAddressData.h"

@class FindNeedInfoOfNearbyMapView;

@protocol FindNeedInfoOfNearbyMapViewDelegate <NSObject>

- (void) updataUserLocationWithLocation:(CLLocation *)location;
- (void) userLocationMakeADifferenceWithNewLocation:(CLLocation *)newLocation;

@end

@interface FindNeedInfoOfNearbyMapView : CustomView

@property (nonatomic, weak) id <FindNeedInfoOfNearbyMapViewDelegate> delegate;

/**
 移除所有的标注
 */
- (void) removeAllAnnotations;

/**
 添加点标记
 */
- (void) addPointAnnotation;

/**
 设置地图中心点
 
 @param location 定位点坐标
 */
- (void) setMapViewCenterWithLocation:(CLLocation *)location;

@end
