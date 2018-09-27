//
//  MapsNavigationView.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/8.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "MapsNavigationView.h"

#import "FindNeedInfoOfNearbyData.h"

#import "CustomAnnotationView.h"
#import "MapsTypeTool.h"

@interface MapsNavigationView ()<MAMapViewDelegate>
{
    
    MAPointAnnotation *tmpPointAnnotation;
    
}
@property (nonatomic, strong) MAMapView      *mapView;
@property (nonatomic, strong) MAUserLocation *userLocation;
@property (nonatomic, strong) UIButton       *locationButton;
@property (nonatomic, strong) NSArray        *datasArray;

@end

@implementation MapsNavigationView

- (void)buildSubview {
    
    self.mapView          = [[MAMapView alloc] initWithFrame:CGRectZero];
    self.mapView.delegate = self;
    self.mapView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.showsCompass      = NO;
    self.mapView.showsScale        = YES;
    self.mapView.scrollEnabled     = YES;
    self.mapView.zoomEnabled       = YES;
    self.mapView.rotateEnabled     = NO;
    [self.mapView setZoomLevel:16.7 animated:NO];
    [self addSubview:self.mapView];
    
    self.mapView.userTrackingMode  = MAUserTrackingModeFollow;
    self.mapView.showsUserLocation = YES;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.fillColor   = [UIColor colorWithRed:41.0/255.0 green:147.0/255.0 blue:240.0/255.0 alpha:0.4];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    r.strokeColor = [UIColor clearColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.lineWidth = 0;///精度圈 边线宽度，默认0
    r.enablePulseAnnimation = YES;///内部蓝色圆点是否使用律动效果, 默认YES
    r.locationDotFillColor = MainColor;///定位点蓝色圆点颜色，不设置默认蓝色
    [self.mapView updateUserLocationRepresentation:r];
    
    UIButton *locationButton = [UIButton createButtonWithFrame:CGRectZero
                                                    buttonType:kButtonNormal
                                                         title:nil
                                                         image:[UIImage imageNamed:@"user_location"]
                                                      higImage:nil
                                                           tag:1000
                                                        target:self
                                                        action:@selector(buttonEvent:)];
    [self addSubview:locationButton];
    self.locationButton = locationButton;
    
}

- (void)layoutSubviews {
    
    self.mapView.frame = self.bounds;
    self.locationButton.frame = CGRectMake(self.width - 45 *Scale_Width, self.height - 45 *Scale_Width, 30 *Scale_Width, 30 *Scale_Width);
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    self.mapView.centerCoordinate = self.userLocation.coordinate;
    
    FindNeedInfoOfNearbyData *model = self.datasArray[0];
    if (model.latitude.length > 0 && model.longitude.length > 0) {
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
        
        CLLocation *a_location = [location locationMarsFromBaidu];
        
        //  设置地图比例
        CGFloat zoom = [self getZoomWithLocation:a_location];
        [self.mapView setZoomLevel:zoom animated:YES];
        
    }
    
}

- (void) addPointAnnotation {
    
    NSArray *datasArray = self.data;
    self.datasArray     = [datasArray copy];
    
    for (FindNeedInfoOfNearbyData *model in datasArray) {
        
        if (model.latitude.length > 0 && model.longitude.length > 0) {
            
            CLLocation *location = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
            
            CLLocation *a_location = [location locationMarsFromBaidu];
            
            //  设置地图比例
            CGFloat zoom = [self getZoomWithLocation:a_location];
            [self.mapView setZoomLevel:zoom animated:YES];
            
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate         = CLLocationCoordinate2DMake(a_location.coordinate.latitude, a_location.coordinate.longitude);
            [self.mapView addAnnotation:pointAnnotation];
            
        }
        
    }
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]] && annotation.coordinate.latitude != self.userLocation.coordinate.latitude && annotation.coordinate.longitude != self.userLocation.coordinate.longitude)
    {
        
        static NSString      *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView  = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"map_annotation"];
        [annotationView sendDataArray:self.datasArray];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -15);
        return annotationView;
        
    }
    
    return nil;
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation; {
    
    if (updatingLocation == YES) {
        
        self.userLocation = userLocation;
        [_delegate updataUserLocationWithLocation:userLocation.location];
        
    }
    
}

- (CGFloat) getZoomWithLocation:(CLLocation *)location {
    
    double distance = [MapsTypeTool LantitudeLongitudeDist:self.userLocation.coordinate.longitude other_Lat:self.userLocation.coordinate.latitude self_Lon:location.coordinate.longitude self_Lat:location.coordinate.latitude];
    float tmpDistance = distance;
    
    if (tmpDistance > 0 && tmpDistance <= 10) {
        
        return 20 + 1 / (tmpDistance - 10);
        
    } else if (tmpDistance > 10 && tmpDistance <= 25) {
        
        return 19 + 1 / (tmpDistance - 15);
        
    } else if (tmpDistance > 25 && tmpDistance <= 50) {
        
        return 18 + 1 / (tmpDistance - 25);
        
    } else if (tmpDistance > 50 && tmpDistance <= 100) {
        
        return 17 + 1 / (tmpDistance - 50);
        
    } else if (tmpDistance > 100 && tmpDistance <= 200) {
        
        return 16 + 1 / (tmpDistance - 100);
        
    } else if (tmpDistance > 200 && tmpDistance <= 500) {
        
        return 15 + 1 / (tmpDistance - 300);
        
    } else if (tmpDistance > 500 && tmpDistance <= 1000) {
        
        return 14 + 1 / (tmpDistance - 500);
        
    } else if (tmpDistance > 1000 && tmpDistance <= 2000) {
        
        return 13 + 1 / (tmpDistance - 1000);
        
    } else if (tmpDistance > 2000 && tmpDistance <= 5000) {
        
        return 12 + 1 / (tmpDistance - 3000);
        
    } else if (tmpDistance > 5000 && tmpDistance <= 10000) {
        
        return 11 + 1 / (tmpDistance - 5000);
        
    } else if (tmpDistance > 10000 && tmpDistance <= 20000) {
        
        return 10 + 1 / (tmpDistance - 10000);
        
    } else if (tmpDistance > 20000 && tmpDistance <= 30000) {
        
        return 9 + 1 / (tmpDistance - 10000);
        
    } else if (tmpDistance > 30000 && tmpDistance <= 50000) {
        
        return 8 + 1 / (tmpDistance - 20000);
        
    } else if (tmpDistance > 50000 && tmpDistance <= 100000) {
        
        return 7 + 1 / (tmpDistance - 50000);
        
    } else {
        
        return 6;
        
    }
    
}

@end
