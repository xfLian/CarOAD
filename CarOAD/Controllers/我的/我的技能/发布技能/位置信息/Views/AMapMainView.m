//
//  AMapMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AMapMainView.h"

@interface AMapMainView ()<MAMapViewDelegate>
{
    
    MAPointAnnotation *tmpPointAnnotation;
    
}
@property (nonatomic, strong) MAMapView      *mapView;
@property (nonatomic, strong) MAUserLocation *userLocation;
@property (nonatomic, strong) UIButton       *locationButton;

@end

@implementation AMapMainView

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
    
    [_delegate updataUserLocationWithLocation:self.userLocation.location];
    
}

- (void) addPointAnnotationWithPoiData:(AMapAddressData *)poi {
    
    if (tmpPointAnnotation) {
        
        [self.mapView removeAnnotation:tmpPointAnnotation];
        
    }
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate         = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
    pointAnnotation.title              = poi.name;
    
    [self.mapView addAnnotation:pointAnnotation];
    
    tmpPointAnnotation = pointAnnotation;
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]] && annotation.coordinate.latitude != self.userLocation.coordinate.latitude && annotation.coordinate.longitude != self.userLocation.coordinate.longitude)
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout = NO;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop   = YES;       //设置标注动画显示，默认为NO
        annotationView.draggable      = NO;       //设置标注可以拖动，默认为NO
        annotationView.pinColor       = MAPinAnnotationColorRed;
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

- (void) setMapViewCenterWithLocation:(AMapGeoPoint *)location; {
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(location.latitude,location.longitude);
    [self.mapView setZoomLevel:16.7 animated:YES];
    
}

@end
