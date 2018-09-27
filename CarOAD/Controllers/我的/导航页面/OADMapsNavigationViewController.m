//
//  OADMapsNavigationViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/8.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "OADMapsNavigationViewController.h"

#import "FindNeedInfoOfNearbyData.h"

#import "MapsNavigationView.h"

@interface OADMapsNavigationViewController ()<MapsNavigationViewDelegate>
{
    
    BOOL        isLoadLocation;
    CLLocation *userLocation;
    
}
@property (nonatomic, strong) MapsNavigationView *mapView;
@end

@implementation OADMapsNavigationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationEvent:)
                                                 name:@"GoToTheDestination"
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GoToTheDestination" object:nil];
    
}

#pragma mark - 通知方法
- (void) notificationEvent:(NSNotification *)notification {
    
    FindNeedInfoOfNearbyData *model    = notification.object;
    CLLocation               *location = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"导航"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    NSURL *apple_App = [NSURL URLWithString:@"http://maps.apple.com/"];
    if ([[UIApplication sharedApplication] canOpenURL:apple_App]) {
        
        NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f&saddr=%f,%f",location.coordinate.latitude,
                             location.coordinate.longitude, userLocation.coordinate.latitude, userLocation.coordinate.longitude];
        
        UIAlertAction *systemMapAction = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [alertController addAction:systemMapAction];
    }
    
    NSURL *baidu_App = [NSURL URLWithString:@"baidumap://"];
    if ([[UIApplication sharedApplication] canOpenURL:baidu_App]) {
        
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving", userLocation.coordinate.latitude, userLocation.coordinate.longitude, location.coordinate.latitude, location.coordinate.longitude];
        
        UIAlertAction *baiduMapAction = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [alertController addAction:baiduMapAction];
    }
    
    NSURL *gaode_App = [NSURL URLWithString:@"iosamap://"];
    if ([[UIApplication sharedApplication] canOpenURL:gaode_App]) {
        
        CLLocation *a_location = [location locationMarsFromBaidu];
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2", AppName, BundleId, @"终点", a_location.coordinate.latitude, a_location.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        UIAlertAction *aMapAction = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [alertController addAction:aMapAction];
    }
    
    NSURL *comgoogle_App = [NSURL URLWithString:@"comgooglemaps://"];
    if ([[UIApplication sharedApplication] canOpenURL:comgoogle_App]) {
        
        CLLocation *newLocation = [location locationMarsFromBaidu];
        
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving", AppName, BundleId, newLocation.coordinate.latitude, newLocation.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        UIAlertAction *aMapAction = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [alertController addAction:aMapAction];
        
    }
    
    NSURL *qq_App = [NSURL URLWithString:@"qqmap://"];
    if ([[UIApplication sharedApplication] canOpenURL:qq_App]) {
        
        CLLocation *newLocation = [location locationMarsFromBaidu];
        
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",newLocation.coordinate.latitude, newLocation.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        UIAlertAction *aMapAction = [UIAlertAction actionWithTitle:@"腾讯地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [alertController addAction:aMapAction];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"导航";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void) buildSubView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MapsNavigationView *mapView   = [[MapsNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    mapView.backgroundColor = [UIColor whiteColor];
    mapView.delegate        = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
}

- (void) initialization {
    
    FindNeedInfoOfNearbyData *data = self.data;
    NSArray *datasArray = @[data];
    self.mapView.data = datasArray;
    [self.mapView addPointAnnotation];
    
}

#pragma mark - MapsNavigationViewDelegate
- (void) updataUserLocationWithLocation:(CLLocation *)location; {
    
    if (location.coordinate.latitude > 0 && location.coordinate.longitude > 0) {
        
        userLocation = location;
        
        if (isLoadLocation == NO) {
            
            [self initialization];
            isLoadLocation = YES;
            
        }
        
    }
    
}

@end
