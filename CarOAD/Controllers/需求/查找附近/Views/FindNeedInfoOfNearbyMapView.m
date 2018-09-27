
//
//  FindNeedInfoOfNearbyMapView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "FindNeedInfoOfNearbyMapView.h"

#import "FindNeedInfoOfNearbyData.h"

#import "CustomAnnotationView.h"

@interface FindNeedInfoOfNearbyMapView ()<MAMapViewDelegate>
{
    
    MAPointAnnotation *tmpPointAnnotation;
    
}
@property (nonatomic, strong) MAMapView      *mapView;
@property (nonatomic, strong) MAUserLocation *userLocation;
@property (nonatomic, strong) UIButton       *locationButton;
@property (nonatomic, strong) NSMutableArray *annotationsArray;
@property (nonatomic, strong) NSArray        *datasArray;

@end

@implementation FindNeedInfoOfNearbyMapView

- (NSMutableArray *)annotationsArray {
    
    if (!_annotationsArray) {
        
        _annotationsArray = [NSMutableArray array];
    }
    
    return _annotationsArray;
    
}

- (void)buildSubview {
    
    self.mapView          = [[MAMapView alloc] initWithFrame:CGRectZero];
    self.mapView.delegate = self;
    self.mapView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.showsCompass      = NO;
    self.mapView.showsScale        = YES;
    self.mapView.scrollEnabled     = YES;
    self.mapView.zoomEnabled       = YES;
    self.mapView.rotateEnabled     = NO;
    [self.mapView setZoomLevel:16.1 animated:NO];
    [self addSubview:self.mapView];
    
    self.mapView.userTrackingMode  = MAUserTrackingModeFollow;
    self.mapView.showsUserLocation = YES;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = YES;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.fillColor   = [UIColor clearColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
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

    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude);
    
    [self.mapView setZoomLevel:16.1 animated:YES];
    
    [_delegate updataUserLocationWithLocation:self.userLocation.location];
    
}

- (void) removeAllAnnotations; {
    
    if (self.annotationsArray.count > 0) {
        
        [self.mapView removeAnnotations:self.annotationsArray];
        
    }
    
}

- (void) addPointAnnotation {
    
    NSArray *datasArray = self.data;
    self.datasArray     = [datasArray copy];
    
    for (FindNeedInfoOfNearbyData *model in datasArray) {
        
        if (model.latitude.length > 0 && model.longitude.length > 0) {
            
            CLLocation *location = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
            
            CLLocation *a_location = [location locationMarsFromBaidu];

            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate         = a_location.coordinate;
            [self.mapView addAnnotation:pointAnnotation];
            [self.annotationsArray addObject:pointAnnotation];
            
        }

    }
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
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
        [_delegate userLocationMakeADifferenceWithNewLocation:userLocation.location];
        
    }
    
}

- (void) setMapViewCenterWithLocation:(CLLocation *)location; {
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude);
    [self.mapView setZoomLevel:16.1 animated:YES];
    
}

@end
