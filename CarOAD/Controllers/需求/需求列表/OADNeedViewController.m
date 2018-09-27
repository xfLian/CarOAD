//
//  OADNeedViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADNeedViewController.h"

#import "AdvertiseMainSubView.h"
#import "AdvertiseChooseTypeView.h"
#import "SearchRecruitListView.h"

//  请求服务器方法类
#import "HomePageViewModel.h"
#import "NeedInfomationListCell.h"
#import "DemandListRootModel.h"

#import "OADFindNeedInfoOfNearbyViewController.h"
#import "OADMyOrderDetailsViewController.h"

@interface OADNeedViewController ()<AdvertiseMainSubViewDelegate, AdvertiseChooseTypeViewDelegate, SearchRecruitListViewDelegate, UITableViewDelegate, UITableViewDataSource, CustomAdapterTypeTableViewCellDelegate, AMapLocationManagerDelegate>
{

    NSInteger     PageNo;
    NSDictionary *selectedProvinceData;
    NSDictionary *selectedCityData;
    NSDictionary *selectedAreaData;
    NSDictionary *selectedCarBrandData;
    NSDictionary *selectedCarTypeData;
    NSDictionary *selectedNeedTypeData;
    NSDictionary *selectedTimeSortData;
    
    CLLocation *userLocation;

}
@property (nonatomic, strong) AdvertiseMainSubView    *chooseButtonView;
@property (nonatomic, strong) AdvertiseChooseTypeView *advertiseChooseTypeView;
@property (nonatomic, strong) SearchRecruitListView   *searchRecruitListView;
@property (nonatomic, strong) AMapLocationManager     *locationManager;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OADNeedViewController

- (AMapLocationManager *)locationManager {
    
    if (!_locationManager) {
        
        _locationManager          = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        _locationManager.locatingWithReGeocode = NO;
        _locationManager.locationTimeout  = 10;
        _locationManager.reGeocodeTimeout = 10;
        
    }
    
    return _locationManager;
    
}

- (NSMutableDictionary *)params {

    if (!_params) {

        _params = [[NSMutableDictionary alloc] init];
    }

    return _params;

}

- (SearchRecruitListView *)searchRecruitListView {

    if (!_searchRecruitListView) {

        _searchRecruitListView          = [[SearchRecruitListView alloc] init];
        _searchRecruitListView.delegate = self;

    }
    
    return _searchRecruitListView;
    
}

- (AdvertiseChooseTypeView *)advertiseChooseTypeView {

    if (!_advertiseChooseTypeView) {

        _advertiseChooseTypeView = [[AdvertiseChooseTypeView alloc] initWithFrame:CGRectMake(0, self.chooseButtonView.y + self.chooseButtonView.height, Screen_Width, self.contentView.height - (self.chooseButtonView.y + self.chooseButtonView.height))];
        _advertiseChooseTypeView.delegate = self;
        [self.contentView addSubview:_advertiseChooseTypeView];

    }

    return _advertiseChooseTypeView;

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;

    if (self.isHomePagePush == YES) {
        
        self.tabBarController.tabBar.hidden = YES;

        CGRect frame = self.tableView.frame;
        frame.size.height += (49 + SafeAreaBottomHeight);
        self.tableView.frame = frame;
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTimer];
    
    [self initialization];
    
}

- (void) initialization {
    
    [self.params setObject:@""  forKey:@"demandTitle"];
    [self.params setObject:@"0"  forKey:@"provinceId"];
    [self.params setObject:@"0"  forKey:@"cityId"];
    [self.params setObject:@"0"  forKey:@"areaId"];
    [self.params setObject:@"0"  forKey:@"brandId"];
    [self.params setObject:@"0"  forKey:@"carTypeId"];
    [self.params setObject:@"0"  forKey:@"demandTypeId"];
    [self.params setObject:@"0"  forKey:@"sortDate"];
    [self.params setObject:@"15" forKey:@"pageStep"];

    [self.tableView.mj_header beginRefreshing];

}

- (void)setNavigationController {

    if (self.isHomePagePush == YES) {
        
        self.leftItemText = @"返回";
        
    }
    
    [super setNavigationController];

    self.navigationItem.title = @"需求信息";

    UIButton *rightNavButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavButton.frame           = CGRectMake(0, 0, 44, 44);
    UIImage *ima                   = [UIImage imageNamed:@"Search_white"];
    rightNavButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [rightNavButton setImage:ima forState:UIControlStateNormal];
    [rightNavButton addTarget:self
                       action:@selector(clickRightItem)
             forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightNavButton];
    self.navigationItem.rightBarButtonItem = item;

}

- (void) clickRightItem {

    [self.advertiseChooseTypeView hide];
    [self.chooseButtonView loadUI];
    [self.searchRecruitListView show];

}

- (void)buildSubView {

    [super buildSubView];
    
    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaBottomHeight - SafeAreaTopHeight - 49);

    AdvertiseMainSubView *chooseButtonView = [[AdvertiseMainSubView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    chooseButtonView.buttonTitleArray      = @[@"区域",@"车型",@"类型",@"时间"];
    [chooseButtonView buildsubview];
    chooseButtonView.delegate              = self;
    [self.contentView addSubview:chooseButtonView];
    self.chooseButtonView = chooseButtonView;
    
    self.tableView.frame = CGRectMake(0, chooseButtonView.y + chooseButtonView.height, Screen_Width, self.contentView.height - (chooseButtonView.y + chooseButtonView.height));
    [NeedInfomationListCell registerToTableView:self.tableView];

    NSMutableArray *images = [NSMutableArray array];

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:images forState:MJRefreshStateIdle];
    [header setImages:images forState:MJRefreshStatePulling];
    [header setImages:images forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

    }];

    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                  refreshingAction:@selector(loadMoreData)];

    self.tableView.mj_footer = footer;

    UIButton *findInfoOfNearbyButton = [UIButton createButtonWithFrame:CGRectMake(Screen_Width - 55 *Scale_Width, self.contentView.height - 70 *Scale_Width - 49, 40 *Scale_Width, 40 *Scale_Width)
                                                    buttonType:kButtonNormal
                                                         title:nil
                                                         image:[UIImage imageNamed:@"look_over_nearby"]
                                                      higImage:nil
                                                           tag:1000
                                                        target:self
                                                        action:@selector(buttonEvent:)];
    [self.contentView addSubview:findInfoOfNearbyButton];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    OADFindNeedInfoOfNearbyViewController *viewController = [OADFindNeedInfoOfNearbyViewController new];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

/**
 *  加载新数据
 */
- (void) loadNewData {

    PageNo = 1;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];

    [self startNetworking];

}

/**
 *  发送请求加载更多的微博数据
 */
- (void) loadMoreData {

    PageNo ++;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];

    [self startNetworking];
    
}

- (void) startNetworking {
    
    [HomePageViewModel requestPost_getHomePageDemandListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        [self requestSucessWithData:info];
        
    } error:^(NSString *errorMessage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (PageNo == 1) {
                
                self.adapters = [NSMutableArray array];
                [self.tableView reloadData];
                
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
            
            if (self.adapters.count < 15) {
                
                self.tableView.mj_footer.hidden = YES;
                
            } else {
                
                self.tableView.mj_footer.hidden = NO;
                
            }
            
        });
        
    } failure:^(NSError *error) {
        
        [self requestFailedWithError:error];
        
    }];

}

- (void) requestSucessWithData:(id)data; {

    DemandListRootModel *rootModel = [[DemandListRootModel alloc] initWithDictionary:data];

    if ([rootModel.result integerValue] == 1) {

        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            NSMutableArray *dataArray = [[NSMutableArray alloc] init];

            if (self.adapters.count > 0) {

                for (TableViewCellDataAdapter *adapter in self.adapters) {

                    DemandListData *tmpData = adapter.data;
                    [dataArray addObject:tmpData];

                }

            }

            if (PageNo == 1) {

                [dataArray removeAllObjects];

            }
            
            if (rootModel.data.count > 0) {

                for (DemandListData *tmpData in rootModel.data) {

                    [dataArray addObject:tmpData];

                }

            }

            dispatch_async(dispatch_get_main_queue(), ^{

                self.adapters = [NSMutableArray array];
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];

                if (dataArray.count > 0) {

                    NSMutableArray *indexPaths = [NSMutableArray array];
                    for (int i = 0; i < dataArray.count; i++) {

                        DemandListData *model = dataArray[i];
                        DemandListData *newModel = [model timeModelWithData:model];

                        TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"NeedInfomationListCell"
                                                                                                                        data:newModel
                                                                                                                  cellHeight:115 *Scale_Height
                                                                                                                    cellType:0];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        adapter.indexPath      = indexPath;
                        [self.adapters addObject:adapter];
                        [indexPaths addObject:indexPath];

                    }

                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];

                } else {

                    if (PageNo == 1) {
                        
                        [MBProgressHUD showMessageTitle:@"数据为空" toView:self.view afterDelay:1.f];
                        
                    }
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }
                
                if (self.adapters.count < 15) {
                    
                    self.tableView.mj_footer.hidden = YES;
                    
                } else {
                    
                    self.tableView.mj_footer.hidden = NO;
                    
                }
                
                if (userLocation.coordinate.latitude > 0) {
                    
                    for (int count = 0; count < self.adapters.count; count++) {
                        
                        TableViewCellDataAdapter *adapter = self.adapters[count];
                        DemandListData           *model   = adapter.data;
                        
                        [model calculateDistanceWithLocation:userLocation];
                        
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCountLocationCell object:nil];
                    
                } else {
                    
                    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
                        
                        if (error)
                        {
                            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                            
                            if (error.code == AMapLocationErrorLocateFailed)
                            {
                                return;
                            }
                        }
                        
                        for (int count = 0; count < self.adapters.count; count++) {
                            
                            TableViewCellDataAdapter *adapter = self.adapters[count];
                            DemandListData           *model   = adapter.data;
                            
                            [model calculateDistanceWithLocation:location];
                            
                        }
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCountLocationCell object:nil];
                        
                        userLocation = location;
                        
                    }];
                    
                }
                
            });

        });

    } else {

        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
            self.tableView.mj_footer.hidden = NO;

        });

    }

}

- (void) requestFailedWithError:(NSError *)error; {

    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];

    [MBProgressHUD showMessageTitle:@"连接服务器失败！"];

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

    return self.adapters[indexPath.row].cellHeight;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCellDataAdapter *adapter = self.adapters[indexPath.row];
    DemandListData           *model   = adapter.data;
    
    if (userLocation.coordinate.longitude > 0 && userLocation.coordinate.latitude > 0) {
        
        [model calculateDistanceWithLocation:userLocation];
    }
    
    NeedInfomationListCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter     = adapter;
    cell.data            = model;
    cell.tableView       = tableView;
    cell.indexPath       = indexPath;
    cell.delegate        = self;
    [cell loadContent];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        TableViewCellDataAdapter *adapter  = self.adapters[indexPath.row];
        DemandListData           *newModel = adapter.data;
        
        OADMyOrderDetailsViewController *viewController = [OADMyOrderDetailsViewController new];
        viewController.demandId                         = newModel.demandId;
        viewController.isNeedListPush                   = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

#pragma mark - TimerEvent
- (void)createTimer {

    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerEvent {
    
    for (int count = 0; count < self.adapters.count; count++) {

        TableViewCellDataAdapter *adapter = self.adapters[count];
        DemandListData           *model   = adapter.data;
        
        [model countDown];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCountDownTimeCell object:nil];
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NeedInfomationListCell *tmpCell = (NeedInfomationListCell *)cell;
    tmpCell.display     = YES;
    [tmpCell loadTimeContent];
    [tmpCell loadDistanceContent];
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    CustomAdapterTypeTableViewCell *tmpCell = (CustomAdapterTypeTableViewCell *)cell;
    tmpCell.display     = NO;
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
}

#pragma mark - AdvertiseMainSubViewDelegate
- (void) clickHideChooseTypeView; {
    
    [self.advertiseChooseTypeView hide];
    
}

- (void) clickchooseButtonWithType:(NSInteger)type; {
    
    [self.advertiseChooseTypeView show];
    
    if (type == 0) {
        
        NSMutableDictionary *contentDic = [NSMutableDictionary new];
        
        if (selectedProvinceData && selectedCityData && selectedAreaData) {
            
            [contentDic setObject:selectedProvinceData forKey:@"selectedProvince"];
            [contentDic setObject:selectedCityData     forKey:@"selectedCity"];
            [contentDic setObject:selectedAreaData     forKey:@"selectedArea"];
            
        }
        
        [self.advertiseChooseTypeView showContentViewWithType:area_view contentDic:contentDic];
        
    } else if (type == 1) {

        NSMutableDictionary *contentDic = [NSMutableDictionary new];

        if (selectedCarBrandData && selectedCarTypeData) {

            [contentDic setObject:selectedCarBrandData forKey:@"selectedCarBrand"];
            [contentDic setObject:selectedCarTypeData  forKey:@"selectedCarType"];

        }

        [self.advertiseChooseTypeView showContentViewWithType:car_type contentDic:contentDic];

    } else if (type == 2) {

        NSMutableDictionary *contentDic = [NSMutableDictionary new];

        if (selectedNeedTypeData) {
            
            [contentDic setObject:selectedNeedTypeData forKey:@"selectedNeedType"];
            
        }

        [self.advertiseChooseTypeView showContentViewWithType:demand_type contentDic:contentDic];

    } else if (type == 3) {

        NSMutableDictionary *contentDic = [NSMutableDictionary new];

        if (selectedTimeSortData) {

            [contentDic setObject:selectedTimeSortData forKey:@"selectedTimeSort"];

        }

        [self.advertiseChooseTypeView showContentViewWithType:time_sort contentDic:contentDic];

    }

}


#pragma mark - AdvertiseChooseTypeViewDelegate
- (void) hideChooseTypeView; {

    [self.chooseButtonView loadUI];

}

- (void) choosedProvinceData:(NSDictionary *)provinceData
                    cityData:(NSDictionary *)cityData
                    areaData:(NSDictionary *)areaData; {
    
    selectedProvinceData = provinceData;
    selectedCityData     = cityData;
    selectedAreaData     = areaData;
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.adapters           = [dataArray mutableCopy];
    
    NSMutableArray *buttonTitleArray = [NSMutableArray new];
    buttonTitleArray                 = [self.chooseButtonView.buttonTitleArray mutableCopy];
    NSString *areaString = areaData[@"area"];
    
    [buttonTitleArray replaceObjectAtIndex:0 withObject:areaString];
    
    self.chooseButtonView.buttonTitleArray = [buttonTitleArray copy];
    [self.chooseButtonView loadUI];

    NSString *provinceId = provinceData[@"provinceid"];
    NSString *cityId     = cityData[@"cityid"];
    NSString *areaId     = areaData[@"areaId"];

    if (provinceId.length > 0 && cityId.length > 0 && areaId.length > 0) {

        [self.params setObject:@""         forKey:@"demandTitle"];
        [self.params setObject:provinceId  forKey:@"provinceId"];
        [self.params setObject:cityId      forKey:@"cityId"];
        [self.params setObject:areaId      forKey:@"areaId"];

        [self.tableView.mj_header beginRefreshing];

    }

}

- (void) selectedCarBrandData:(NSDictionary *)carBrandData
                  carTypeData:(NSDictionary *)carTypeData; {

    selectedCarBrandData = carBrandData;
    selectedCarTypeData  = carTypeData;

    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.adapters           = [dataArray mutableCopy];

    [self.chooseButtonView loadUI];

    NSString *carBrandId = carBrandData[@"brandId"];
    NSString *carTypeId  = carTypeData[@"carTypeId"];

    if (carBrandId.length > 0 && carTypeId.length > 0) {

        [self.params setObject:@""         forKey:@"demandTitle"];
        [self.params setObject:carBrandId  forKey:@"brandId"];
        [self.params setObject:carTypeId   forKey:@"carTypeId"];

        [self.tableView.mj_header beginRefreshing];

    }

    [self.params setObject:@"0"  forKey:@"sortDate"];

}

- (void) selectedDemandTypeData:(NSDictionary *)demandTypeData; {

    selectedNeedTypeData = demandTypeData;

    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.adapters             = [dataArray mutableCopy];
    
    [self.chooseButtonView loadUI];
    
    NSString *demandTypeId = demandTypeData[@"demandTyepId"];
    
    if (demandTypeId.length > 0) {
        
        [self.params setObject:@""          forKey:@"demandTitle"];
        [self.params setObject:demandTypeId forKey:@"demandTypeId"];
        
        [self.tableView.mj_header beginRefreshing];
        
    }
    
}

- (void) selectedTimeSortTypeData:(NSDictionary *)timeSortTypeData; {

    selectedTimeSortData = timeSortTypeData;

    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.adapters           = [dataArray mutableCopy];

    [self.chooseButtonView loadUI];

    NSString *sortDate = timeSortTypeData[@"titleId"];

    if (sortDate.length > 0) {
        
        [self.params setObject:@""      forKey:@"demandTitle"];
        [self.params setObject:sortDate forKey:@"sortDate"];
        
        [self.tableView.mj_header beginRefreshing];
        
    }
    
}

#pragma mark - SearchRecruitListViewDelegate
- (void) searchRecruitListWithText:(NSString *)text; {

    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.adapters            = [dataArray mutableCopy];

    if (text.length > 0) {

        self.chooseButtonView.buttonTitleArray = @[@"区域",@"车型",@"类型",@"时间"];
        [self.chooseButtonView loadUI];
        [self initialization];
        [self.params setObject:text forKey:@"demandTitle"];

        [self.tableView.mj_header beginRefreshing];

    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
