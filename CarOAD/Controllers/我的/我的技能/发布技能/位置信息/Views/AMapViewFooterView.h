//
//  AMapViewFooterView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/26.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@class AMapViewFooterView;

@protocol AMapViewFooterViewDelegate <NSObject>

- (void) startPublishUserLocation;

@end

@interface AMapViewFooterView : CustomView

@property (nonatomic, weak) id <AMapViewFooterViewDelegate> delegate;

@end
