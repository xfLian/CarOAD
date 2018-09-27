//
//  MapsNavigationView.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/8.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@class MapsNavigationView;

@protocol MapsNavigationViewDelegate <NSObject>

- (void) updataUserLocationWithLocation:(CLLocation *)location;

@end

@interface MapsNavigationView : CustomView

@property (nonatomic, weak) id <MapsNavigationViewDelegate> delegate;

/**
 添加点标记
*/
- (void) addPointAnnotation;

@end
