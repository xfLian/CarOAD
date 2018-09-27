//
//  OADMyLocationViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMyLocationViewController.h"

#import "AMapSearchView.h"
#import "AMapMainView.h"
#import "AMapAddressCell.h"
#import "AMapViewFooterView.h"

@interface OADMyLocationViewController ()<UITableViewDelegate, UITableViewDataSource, AMapSearchDelegate, AMapLocationManagerDelegate, AMapSearchViewDelegate, AMapViewFooterViewDelegate, AMapMainViewDelegate>
{
    
    BOOL        isSelectedAddress;
    BOOL        isHavePoiSearch;
    NSString   *locationCity;
    CLLocation *locationOfWaitingForPublish;
    CLLocation *userLocation;
    
}
@property (nonatomic, strong) AMapAddressData     *selectedData;
@property (nonatomic, strong) AMapSearchView      *searchView;
@property (nonatomic, strong) AMapMainView        *mapView;
@property (nonatomic, strong) AMapViewFooterView  *footerView;
@property (nonatomic, strong) AMapSearchAPI       *search;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) UIView              *headerView;
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableArray      *datasArray;
@property (nonatomic, strong) UILabel             *selectedAddressLabel;
@property (nonatomic, strong) UIButton            *selectedUserLocationButton;

@end

@implementation OADMyLocationViewController

- (AMapLocationManager *)locationManager {
    
    if (!_locationManager) {
        
        _locationManager          = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        _locationManager.locatingWithReGeocode = YES;
        _locationManager.locationTimeout  = 10;
        _locationManager.reGeocodeTimeout = 10;
        
    }
    
    return _locationManager;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self userStartLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialization];
    [self buildsubView];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"我的位置";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void) initialization {
    
    self.datasArray = [NSMutableArray array];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
}

- (void) buildsubView {
    
    [super buildSubView];

    AMapSearchView *searchView = [[AMapSearchView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 48 *Scale_Height)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.delegate        = self;
    [self.contentView addSubview:searchView];
    self.searchView = searchView;
    
    AMapMainView *mapView   = [[AMapMainView alloc] initWithFrame:CGRectMake(0, searchView.y + searchView.height, self.contentView.width, self.contentView.height - (searchView.y + searchView.height))];
    mapView.backgroundColor = [UIColor whiteColor];
    mapView.delegate        = self;
    [self.contentView addSubview:mapView];
    self.mapView = mapView;
    
    UIView *headerView = [self createHeaderViewWithFrame:CGRectMake(0, self.contentView.height, Screen_Width, 50 *Scale_Height)];
    [self.contentView addSubview:headerView];
    self.headerView = headerView;
    
    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, headerView.y + headerView.height, Screen_Width, 195 *Scale_Height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.tag             = 100;
    [self.contentView addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[AMapAddressCell class] forCellReuseIdentifier:@"AMapAddressCell"];
    
    AMapViewFooterView *footerView   = [[AMapViewFooterView alloc] initWithFrame:CGRectMake(0, tableView.y + tableView.height, Screen_Width, 60 *Scale_Height)];
    footerView.backgroundColor       = [UIColor whiteColor];
    footerView.delegate              = self;
    [self.contentView addSubview:footerView];
    self.footerView = footerView;
    
}

- (UIView *) createHeaderViewWithFrame:(CGRect)frame {
    
    UIView *headerView         = [[UIView alloc]initWithFrame:frame];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, headerView.width - 60 *Scale_Width, headerView.height)
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:UIFont_16
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [headerView addSubview:titleLabel];
    self.selectedAddressLabel = titleLabel;
    
    UIButton *selectedButton = [UIButton createButtonWithFrame:CGRectMake(headerView.width - 35 *Scale_Width, (headerView.height - 20 *Scale_Width) / 2, 20 *Scale_Width, 20 *Scale_Width)
                                                    buttonType:kButtonSel
                                                         title:nil
                                                         image:nil
                                                      higImage:[UIImage imageNamed:@"choose_user_location"]
                                                           tag:1000
                                                        target:self
                                                        action:@selector(buttonEvent:)];
    [headerView addSubview:selectedButton];
    self.selectedUserLocationButton = selectedButton;
    self.selectedUserLocationButton.selected = YES;
    
    UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.height - 0.5f, headerView.width, 0.5f)];
    lineView.backgroundColor = LineColor;
    [headerView addSubview:lineView];
    
    return headerView;
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    self.selectedUserLocationButton.selected = YES;
    
    AMapGeoPoint *newLocation = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    [self.mapView setMapViewCenterWithLocation:newLocation];
    
    AMapAddressData *poiData = [AMapAddressData new];
    poiData.location         = newLocation;
    poiData.address          = self.selectedAddressLabel.text;
    self.selectedData        = poiData;
    [self.mapView addPointAnnotationWithPoiData:poiData];
    
    NSMutableArray *datasArray = [[NSMutableArray alloc] init];
    for (AMapAddressData *model in self.datasArray) {
        
        model.isSelected = NO;
        
        [datasArray addObject:model];
        
    }
    
    self.datasArray = [datasArray mutableCopy];
    [self.tableView reloadData];
    
}

- (void) userStartLocation {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        if (isHavePoiSearch == NO) {
            
            AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
            
            request.location            = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
            /* 按照距离排序. */
            request.sortrule            = 0;
            request.requireExtension    = YES;
            
            [self.search AMapPOIAroundSearch:request];

            if (regeocode)
            {
                
                locationCity = regeocode.city;
                
                if (isSelectedAddress == NO) {
                    
                    if (regeocode.formattedAddress.length > 0) {
                        
                        self.selectedAddressLabel.text = regeocode.formattedAddress;
                        
                    } else {
                        
                        self.selectedAddressLabel.text = @"";
                        
                    }
                    
                    AMapGeoPoint *newLocation = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
                    [self.mapView setMapViewCenterWithLocation:newLocation];
                    
                    AMapAddressData *poiData = [AMapAddressData new];
                    poiData.location         = newLocation;
                    poiData.address          = regeocode.formattedAddress;
                    self.selectedData        = poiData;
                    [self.mapView addPointAnnotationWithPoiData:poiData];
                    
                }
                
            }
            
        }

    }];
    
}

- (void) userLocationMakeADifferenceWithNewLocation:(CLLocation *)newLocation; {
    
    userLocation = newLocation;

}

#pragma mark - AMapSearchViewDelegate
- (void) startPoiSearchWithText:(NSString *)searchText; {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    isHavePoiSearch = YES;
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = searchText;
    request.requireExtension    = YES;
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    request.city                = locationCity;
    [self.search AMapPOIKeywordsSearch:request];
    
}

#pragma mark - AMapMainViewDelegate
- (void) updataUserLocationWithLocation:(CLLocation *)location; {
    
    isHavePoiSearch   = NO;
    isSelectedAddress = NO;
    [self userStartLocation];
    
}

#pragma mark - AMapViewFooterViewDelegate
- (void) startPublishUserLocation; {
    
    AMapAddressData *poiData = self.selectedData;
    self.getUserLocation(poiData);
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma  mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error; {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
    [self.datasArray removeAllObjects];
    for (AMapPOI *poi in response.pois) {

        AMapAddressData *model = [AMapAddressData new];
        model.uid              = poi.uid;
        model.name             = poi.name;
        model.location         = poi.location;
        model.address          = poi.address;
        
        [self.datasArray addObject:model];
        
    }
    
    if (self.selectedData.isSelected == YES) {
        
        for (int i = 0; i < self.datasArray.count; i++) {
            
            AMapAddressData *model = self.datasArray[i];
            if ([model.uid isEqualToString:self.selectedData.uid]) {
                
                model.isSelected = YES;
                [self.datasArray replaceObjectAtIndex:i withObject:model];
                
            }
            
        }

    }
    [self.tableView reloadData];
    
    CGRect headerViewRect = self.headerView.frame;
    headerViewRect.origin.y = self.view.height - 60 *Scale_Height - 245 *Scale_Height;
    
    CGRect tableViewRect   = self.tableView.frame;
    tableViewRect.origin.y = headerViewRect.origin.y + headerViewRect.size.height;
    
    CGRect footerViewRect   = self.footerView.frame;
    footerViewRect.origin.y = tableViewRect.origin.y + tableViewRect.size.height;
    
    CGRect mapViewRect      = self.mapView.frame;
    mapViewRect.size.height = headerViewRect.origin.y - (self.searchView.y + self.searchView.height);
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.headerView.frame = headerViewRect;
        self.tableView.frame  = tableViewRect;
        self.footerView.frame = footerViewRect;
        
    } completion:^(BOOL finished) {
        
        self.mapView.frame = mapViewRect;
        
    }];
    
    if (isHavePoiSearch == YES) {
        
        AMapAddressData *model = self.datasArray[0];
        if (model.name.length > 0) {
            
            self.selectedAddressLabel.text = model.name;
            [self.mapView addPointAnnotationWithPoiData:model];
            [self.mapView setMapViewCenterWithLocation:model.location];
            
        } else {
            
            self.selectedAddressLabel.text = @"";
            
        }
        
    }
    
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
    
    return self.datasArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65 *Scale_Height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AMapAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMapAddressCell" forIndexPath:indexPath];
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;

    if (self.datasArray.count > 0) {
        
        cell.data = self.datasArray[indexPath.row];
        [cell loadContent];
        
    }
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedUserLocationButton.selected = NO;
    isSelectedAddress = YES;
    
    AMapAddressData *poiData = self.datasArray[indexPath.row];
    self.selectedData        = poiData;
    
    [self.mapView addPointAnnotationWithPoiData:poiData];
    [self.mapView setMapViewCenterWithLocation:poiData.location];
    
    NSMutableArray *datasArray = [[NSMutableArray alloc] init];
    for (AMapAddressData *model in self.datasArray) {
        
        if ([model.uid isEqualToString:self.selectedData.uid]) {
            
            model.isSelected = YES;
            
        } else {
            
            model.isSelected = NO;
            
        }
        
        [datasArray addObject:model];
        
    }
    
    self.datasArray = [datasArray mutableCopy];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
