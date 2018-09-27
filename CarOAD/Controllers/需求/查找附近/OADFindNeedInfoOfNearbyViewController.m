//
//  OADFindNeedInfoOfNearbyViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/26.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADFindNeedInfoOfNearbyViewController.h"

#import "AMapAddressData.h"
#import "FindNeedInfoOfNearbyViewModel.h"
#import "FindNeedInfoOfNearbyRootModel.h"

#import "FindNeedInfoOfNearbyMapView.h"
#import "FindNeedInfoOfNearbyCell.h"

#import "MapsTypeTool.h"

@interface OADFindNeedInfoOfNearbyViewController ()<FindNeedInfoOfNearbyMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CustomAdapterTypeTableViewCellDelegate, UIActionSheetDelegate>
{
    
    BOOL            isLocationSuccess;
    UIActionSheet  *_actionSheet;
    NSMutableArray *_mapsUrlArray;
    CLLocation     *userLocation;
    
}

@property (nonatomic, strong) FindNeedInfoOfNearbyMapView *mapView;
@property (nonatomic, strong) UITableView                 *tableView;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray <TableViewCellDataAdapter *> *adapters;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OADFindNeedInfoOfNearbyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    [self createTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationEvent:)
                                                 name:@"GoToTheDestination"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectedLocationAnnotation:)
                                                 name:@"SelectedLocationAnnotation"
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GoToTheDestination" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectedLocationAnnotation" object:nil];
    
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
        
        CLLocation *a_location = [location locationMarsFromBaidu];
        
        NSString *urlString=[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f&saddr=%f,%f",a_location.coordinate.latitude,
                             a_location.coordinate.longitude, userLocation.coordinate.latitude, userLocation.coordinate.longitude];
        
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
        
        CLLocation *to_location = [location locationMarsFromBaidu];

        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2", AppName, BundleId, @"终点", to_location.coordinate.latitude, to_location.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
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

- (void)selectedLocationAnnotation:(NSNotification *)notification {
    
    FindNeedInfoOfNearbyData *model = notification.object;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:model.cell_tag - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildsubView];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"附近查找";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void) buildsubView {
    
    FindNeedInfoOfNearbyMapView *mapView   = [[FindNeedInfoOfNearbyMapView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, self.view.width, self.view.height - SafeAreaTopHeight)];
    mapView.backgroundColor = [UIColor whiteColor];
    mapView.delegate        = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.height - Screen_Width, 150 *Scale_Height, Screen_Width) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.transform       = CGAffineTransformMakeRotation(-M_PI_2);
    tableView.tag             = 100;
    tableView.pagingEnabled   = YES;
    tableView.showsVerticalScrollIndicator   = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    [FindNeedInfoOfNearbyCell registerToTableView:tableView];
    
    CGRect tableViewRect       = self.tableView.frame;
    tableViewRect.origin.x    += ABS(150 *Scale_Height - Screen_Width) / 2;
    tableViewRect.origin.y    += ABS(150 *Scale_Height - Screen_Width) / 2;
    self.tableView.frame       = tableViewRect;
    
    CGRect startRect      = self.tableView.frame;
    startRect.origin.y    = self.view.height;
    self.tableView.frame  = startRect;
    
}

- (void) loadViewRect {

    CGRect mapViewRect      = self.mapView.frame;
    mapViewRect.size.height = self.view.height - 150 *Scale_Height - 64;
    
    CGRect endRect   = self.tableView.frame;
    
    if (self.adapters.count > 0) {
        
        endRect.origin.y = self.view.height - 150 *Scale_Height;
        mapViewRect.size.height = self.view.height - 150 *Scale_Height - 64;
        
    } else {
        
        endRect.origin.y = self.view.height;
        mapViewRect.size.height = self.view.height - 64;
        
    }

    [UIView animateWithDuration:0.25f animations:^{
        
        self.tableView.frame = endRect;
        
    } completion:^(BOOL finished) {
        
        self.mapView.frame = mapViewRect;
        
    }];
    
}

#pragma mark -
- (void) updataUserLocationWithLocation:(CLLocation *)location; {

    if (location.coordinate.latitude > 0 && location.coordinate.longitude > 0) {
        
        CLLocation *baidu_location = [location locationBaiduFromMars];
        [self getNeedInfoWithLocation:baidu_location];
        
    }
    
}

- (void) userLocationMakeADifferenceWithNewLocation:(CLLocation *)newLocation; {
    
    userLocation = newLocation;
    
    if (newLocation.coordinate.latitude > 0 && newLocation.coordinate.longitude > 0) {
        
        if (isLocationSuccess == NO) {
            
            CLLocation *baidu_location = [newLocation locationBaiduFromMars];
            [self getNeedInfoWithLocation:baidu_location];
            
        }
        
        isLocationSuccess = YES;
        
    }
    
}

- (void) getNeedInfoWithLocation:(CLLocation *)location {
    
    NSDictionary *params = @{@"longitude" : [NSString stringWithFormat:@"%f",location.coordinate.longitude],
                             @"latitude"  : [NSString stringWithFormat:@"%f",location.coordinate.latitude]};

    [MBProgressHUD showMessage:nil toView:self.view];
    [FindNeedInfoOfNearbyViewModel requestPost_getDemandByMapNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            FindNeedInfoOfNearbyRootModel *rootModel = [[FindNeedInfoOfNearbyRootModel alloc] initWithDictionary:info];
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            if (rootModel.data.count > 0) {
                
                for (FindNeedInfoOfNearbyData *tmpData in rootModel.data) {
                    
                    [dataArray addObject:tmpData];
                    
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.adapters = [NSMutableArray array];
                [self.tableView reloadData];
                
                if (dataArray.count > 0) {
                    
                    NSMutableArray *indexPaths = [NSMutableArray array];
                    for (int i = 0; i < dataArray.count; i++) {
                        
                        FindNeedInfoOfNearbyData *model    = dataArray[i];
                        FindNeedInfoOfNearbyData *newModel = [model timeModelWithData:model];
                        newModel.cell_tag                  = i + 1;
                        
                        double distance = [MapsTypeTool LantitudeLongitudeDist:[newModel.longitude doubleValue] other_Lat:[newModel.latitude  doubleValue] self_Lon:userLocation.coordinate.longitude self_Lat:userLocation.coordinate.latitude];
                        float tmpDistance = distance / 1000;
                        newModel.distance = [NSString stringWithFormat:@"%.2f",tmpDistance];
                        
                        TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"FindNeedInfoOfNearbyCell"
                                                                                                                        data:newModel
                                                                                                                  cellHeight:0 *Scale_Height
                                                                                                                    cellType:0];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        adapter.indexPath      = indexPath;
                        [self.adapters addObject:adapter];
                        [indexPaths addObject:indexPath];
                        
                    }
                    
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                    [self loadViewRect];
                    
                    [self.mapView removeAllAnnotations];

                    [self addMapAnnotation];
                    
                } else {
                    
                    [MBProgressHUD showMessageTitle:@"没有更多数据了" toView:self.view afterDelay:1.f];
                    
                }
                
            });
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
        self.adapters = [NSMutableArray array];
        [self.tableView reloadData];
        [self loadViewRect];
        
        [self.mapView removeAllAnnotations];

    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.adapters.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Screen_Width;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCellDataAdapter *adapter = self.adapters[indexPath.row];
    
    FindNeedInfoOfNearbyCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter     = adapter;
    cell.data            = adapter.data;
    cell.tableView       = tableView;
    cell.indexPath       = indexPath;
    cell.delegate        = self;
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    [cell loadContent];
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCellDataAdapter *adapter = self.adapters[indexPath.row];
    FindNeedInfoOfNearbyData *model   = adapter.data;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
    CLLocation *a_location = [location locationMarsFromBaidu];
    [self.mapView setMapViewCenterWithLocation:a_location];
    
}

#pragma mark - TimerEvent
- (void)createTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerEvent {
    
    for (int count = 0; count < self.adapters.count; count++) {
        
        TableViewCellDataAdapter *adapter = self.adapters[count];
        FindNeedInfoOfNearbyData *model   = adapter.data;
        
        [model countDown];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCountDownTimeFindNeedInfoOfNearbyCell object:nil];
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FindNeedInfoOfNearbyCell *tmpCell = (FindNeedInfoOfNearbyCell *)cell;
    tmpCell.display = YES;
    [tmpCell loadTimeContent];
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    CustomAdapterTypeTableViewCell *tmpCell = (CustomAdapterTypeTableViewCell *)cell;
    tmpCell.display = NO;
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {
    
    [self.mapView removeAllAnnotations];
    
    NSInteger tag = scrollView.contentOffset.y / Screen_Width;
    TableViewCellDataAdapter *adapter = self.adapters[tag];
    FindNeedInfoOfNearbyData *model   = adapter.data;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
    CLLocation *a_location = [location locationMarsFromBaidu];
    [self.mapView setMapViewCenterWithLocation:a_location];
    [self addMapAnnotation];
    
}

#pragma mark - 添加地图标注
- (void) addMapAnnotation {
    
    if (self.adapters.count > 0) {
        
        NSMutableArray *datasArray = [NSMutableArray array];
        
        for (TableViewCellDataAdapter *adapter in self.adapters) {
            
            FindNeedInfoOfNearbyData *model = adapter.data;
            [datasArray addObject:model];
            
        }
        
        self.mapView.data = datasArray;
        [self.mapView addPointAnnotation];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
