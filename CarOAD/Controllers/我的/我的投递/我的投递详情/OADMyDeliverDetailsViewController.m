//
//  OADMyDeliverDetailsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMyDeliverDetailsViewController.h"

#import "MyDeliverDetailsViewModel.h"
#import "MyDeliverDetailsRootModel.h"

#import "DeliverDetailsUserInfoCell.h"
#import "DeliverDetailsAddressCell.h"
#import "DeliverDetailsRequirementCell.h"
#import "DeliverDetailsCompanyInfoCell.h"

#import "RootTabBarViewController.h"
#import "OADMapsNavigationViewController.h"
#import "FindNeedInfoOfNearbyData.h"

@interface OADMyDeliverDetailsViewController ()<CustomAdapterTypeTableViewCellDelegate, AMapLocationManagerDelegate>

@property (nonatomic, strong) MyDeliverDetailsRootModel *rootModel;
@property (nonatomic, strong) AMapLocationManager       *locationManager;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *classModels;
@property (nonatomic, strong) NSMutableArray      *datasArray;

@property (nonatomic, strong) UILabel  *numberLabel;
@property (nonatomic, strong) UIButton *bottom_button;

@end

@implementation OADMyDeliverDetailsViewController

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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void) initialization {

    [self.params setObject:self.recruiId forKey:@"recruiId"];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    
    if (accountInfo.user_id.length > 0) {
        
        [self.params setObject:accountInfo.user_id forKey:@"userId"];
        
    } else {
        
        [self.params setObject:@"" forKey:@"userId"];
    }
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [MyDeliverDetailsViewModel requestPost_getPostInfoNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        int64_t delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            self.datasArray = [NSMutableArray array];
            [self.tableView reloadData];
            
            NSMutableArray *tmpDatasArray = [NSMutableArray array];
            //  获取用户数据
            MyDeliverDetailsRootModel *model = [[MyDeliverDetailsRootModel alloc] initWithDictionary:info];
            
            self.rootModel = model;
            
            [self loadUserInfoCellDataWithRootModel:model];
            [self loadAddressCellDataWithRootModel:model];
            [self loadRequirementCellDataWithRootModel:model];
            [self loadCompanyInfoCellDataWithRootModel:model];
            
            [self.tableView beginUpdates];
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < self.datasArray.count; i++) {
                
                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:i];
                [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                
                NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[i];
                NSMutableArray <TableViewCellDataAdapter *> *tmpAdapterArray = [NSMutableArray array];
                
                for (int j = 0; j < adapters.count; j++) {
                    
                    TableViewCellDataAdapter *adapter = adapters[j];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    adapter.indexPath = indexPath;
                    [indexPaths addObject:indexPath];
                    [tmpAdapterArray addObject:adapter];
                    
                }
                
                [tmpDatasArray addObject:tmpAdapterArray];
                
            }
            
            self.datasArray = [tmpDatasArray mutableCopy];
            
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            
            [self.locationManager startUpdatingLocation];
            
            MyDeliverDetailsData *data = model.data[0];
            
            if (data.status.length > 0) {
                
                self.bottomView.hidden = NO;
                
                if ([data.status isEqualToString:@"0"]) {
                    
                    self.bottom_button.enabled = YES;
                    [self.bottom_button setTitle:@"投递简历" forState:UIControlStateNormal];
                    self.bottom_button.backgroundColor = MainColor;
                    
                } else if ([data.status isEqualToString:@"1"]) {
                    
                    self.bottom_button.enabled = NO;
                    [self.bottom_button setTitle:@"投递成功" forState:UIControlStateNormal];
                    self.bottom_button.backgroundColor = TextGrayColor;
                    
                } else if ([data.status isEqualToString:@"2"]) {
                    
                    self.bottom_button.enabled = NO;
                    [self.bottom_button setTitle:@"已被查看" forState:UIControlStateNormal];
                    self.bottom_button.backgroundColor = TextGrayColor;
                    
                } else if ([data.status isEqualToString:@"3"]) {
                    
                    self.bottom_button.enabled = NO;
                    [self.bottom_button setTitle:@"不合适" forState:UIControlStateNormal];
                    self.bottom_button.backgroundColor = TextGrayColor;
                    
                }
                
            } else {
                
                self.bottomView.hidden = YES;
                
            }
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"职位详情";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)clickLeftItem {
    
    [super clickLeftItem];
    
    if (self.isNotivationPush) {
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        RootTabBarViewController *controllerVC = [[RootTabBarViewController alloc] init];
        delegate.window.rootViewController = controllerVC;
        
    }
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight - SafeAreaBottomHeight - 54 *Scale_Height);
    self.tableView.frame = self.contentView.bounds;
    self.tableView.backgroundColor = BackGrayColor;
    
    [DeliverDetailsUserInfoCell registerToTableView:self.tableView];
    [DeliverDetailsAddressCell registerToTableView:self.tableView];
    [DeliverDetailsRequirementCell registerToTableView:self.tableView];
    [DeliverDetailsCompanyInfoCell registerToTableView:self.tableView];
    
    {
        self.bottomView.frame = CGRectMake(0, self.view.height - 54 *Scale_Height - SafeAreaBottomHeight, Screen_Width, 54 *Scale_Height + SafeAreaBottomHeight);
        
        UIButton *bottom_button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 34 *Scale_Height)
                                                           title:@"投递简历"
                                                 backgroundImage:nil
                                                             tag:1000
                                                          target:self
                                                          action:@selector(buttonEvent:)];
        bottom_button.titleLabel.font = UIFont_M_16;
        [self.bottomView addSubview:bottom_button];
        bottom_button.layer.masksToBounds = YES;
        bottom_button.layer.cornerRadius  = 3.f *Scale_Width;
        bottom_button.backgroundColor = MainColor;
        [bottom_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bottom_button = bottom_button;
        
    }
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:self.recruiId forKey:@"recruitId"];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    if (accountInfo.default_cv_id.length > 0) {
        
        [params setObject:accountInfo.default_cv_id forKey:@"CVId"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请先添加简历" toView:self.view afterDelay:1.5f];
        return;
    }
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [MyDeliverDetailsViewModel requestPost_sendCVNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"投递成功" toView:self.view afterDelay:1.f];
        int64_t delayInSeconds = 1.1f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self initialization];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

#pragma mark - 更新dataSours
- (void) loadUserInfoCellDataWithRootModel:(id)rootModel {
    
    MyDeliverDetailsRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MyDeliverDetailsData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        MyDeliverDetailsData *data = datasArray[0];
        
        self.adapters = [NSMutableArray array];
        [DeliverDetailsUserInfoCell cellHeightWithData:data];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsUserInfoCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:kDeliverDetailsUserInfoCellNormalType];
        
        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MyDeliverDetailsData *data = nil;
        [DeliverDetailsUserInfoCell cellHeightWithData:nil];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsUserInfoCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:kDeliverDetailsUserInfoCellNoDataType];
        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadAddressCellDataWithRootModel:(id)rootModel {
    
    MyDeliverDetailsRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MyDeliverDetailsData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        MyDeliverDetailsData *data = datasArray[0];
        [DeliverDetailsAddressCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsAddressCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.normalStringHeight
                                                                                                                cellType:kDeliverDetailsAddressCellNormalType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MyDeliverDetailsData *data = [[MyDeliverDetailsData alloc] init];
        [DeliverDetailsAddressCell cellHeightWithData:nil];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsAddressCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kDeliverDetailsAddressCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadRequirementCellDataWithRootModel:(id)rootModel {
    
    MyDeliverDetailsRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MyDeliverDetailsData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        MyDeliverDetailsData *data = datasArray[0];
        [DeliverDetailsRequirementCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsRequirementCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.normalStringHeight
                                                                                                                cellType:kDeliverDetailsRequirementCellNormalType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MyDeliverDetailsData *data = [[MyDeliverDetailsData alloc] init];
        [DeliverDetailsRequirementCell cellHeightWithData:nil];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsRequirementCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kDeliverDetailsRequirementCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadCompanyInfoCellDataWithRootModel:(id)rootModel {
    
    MyDeliverDetailsRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MyDeliverDetailsData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        
        self.adapters = [NSMutableArray array];
        for (int i = 0; i < datasArray.count; i++) {
            
            MyDeliverDetailsData *data = datasArray[i];
            [DeliverDetailsCompanyInfoCell cellHeightWithData:data];
            TableViewCellDataAdapter *educationExperienceAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsCompanyInfoCell"
                                                                                                                               data:data
                                                                                                                         cellHeight:data.normalStringHeight
                                                                                                                           cellType:kDeliverDetailsCompanyInfoCellNormalType];
            [self.adapters addObject:educationExperienceAdapter];
        }
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MyDeliverDetailsData *data = [[MyDeliverDetailsData alloc] init];
        [DeliverDetailsCompanyInfoCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsCompanyInfoCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kDeliverDetailsCompanyInfoCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode; {

    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[1];
    TableViewCellDataAdapter *adapter = adapters[0];
    MyDeliverDetailsData     *model   = adapter.data;
    [model calculateDistanceWithLocation:location];
    
    self.adapters = [NSMutableArray array];
    [DeliverDetailsAddressCell cellHeightWithData:model];
    TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"DeliverDetailsAddressCell"
                                                                                                                data:model
                                                                                                          cellHeight:model.normalStringHeight
                                                                                                            cellType:kDeliverDetailsAddressCellNormalType];
    [self.adapters addObject:jobIntensionAdapter];
    [self.datasArray replaceObjectAtIndex:1 withObject:self.adapters];
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
    
    
}

#pragma mark - TableViewDelegate
//设置头分区
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = BackGrayColor;
    
    if (section == 1 || section == 2 || section == 3) {
        
        backView.frame = CGRectMake(0, 0, Screen_Width, 50 *Scale_Height);
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Height, Screen_Width, 40 *Scale_Height)];
        contentView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:contentView];
        
        if (section == 1) {
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"工作地点"
                                                      font:UIFont_16
                                                 textColor:TextBlackColor
                                             textAlignment:NSTextAlignmentLeft
                                                       tag:100];
            [contentView addSubview:label];
            
        } else if (section == 2) {
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"职位要求"
                                                      font:UIFont_16
                                                 textColor:TextBlackColor
                                             textAlignment:NSTextAlignmentLeft
                                                       tag:100];
            [contentView addSubview:label];
            
        } else {
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"公司信息"
                                                      font:UIFont_16
                                                 textColor:TextBlackColor
                                             textAlignment:NSTextAlignmentLeft
                                                       tag:100];
            [contentView addSubview:label];
            
        }
        
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, contentView.height - 0.5f, Screen_Width, 0.5f)];
        lineView.backgroundColor = LineColor;
        [contentView addSubview:lineView];
        
    } else {
        
        backView.frame = CGRectMake(0, 0, Screen_Width, 10 *Screen_Height);
        
    }
    
    return backView;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1 || section == 2 || section == 3) {
        
        return 50 *Scale_Height;
        
    } else {
        
        return 10 *Scale_Height;
        
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 3) {
        
        return 10 *Scale_Height;
        
    } else {
        
        return 0.01;
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 3) {
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 10 *Screen_Height)];
        backView.backgroundColor = BackGrayColor;
        
        return backView;
        
    } else {
        
        return nil;
        
    }
    
}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.datasArray.count;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[section];
    
    return adapters.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[indexPath.section];
    
    return adapters[indexPath.row].cellHeight;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[indexPath.section];
    TableViewCellDataAdapter *adapter = adapters[indexPath.row];
    CustomAdapterTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter                     = adapter;
    cell.data                            = adapter.data;
    cell.tableView                       = tableView;
    cell.indexPath                       = indexPath;
    cell.delegate                        = self;
    
    [cell loadContent];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[indexPath.section];
        TableViewCellDataAdapter *adapter = adapters[indexPath.row];
        MyDeliverDetailsData *data = adapter.data;
        
        if (data.address.length > 0) {
            
            FindNeedInfoOfNearbyData *model = [FindNeedInfoOfNearbyData new];
            model.demandTitle = data.ShopName;
            model.demandType  = data.address;
            model.demandImg   = data.shopImg;
            model.longitude   = data.longitude;
            model.latitude    = data.latitude;
            
            OADMapsNavigationViewController *viewController = [OADMapsNavigationViewController new];
            viewController.data = model;
            [self.navigationController pushViewController:viewController animated:YES];
            
        }

    }

}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    CustomAdapterTypeTableViewCell *tmpCell = (CustomAdapterTypeTableViewCell *)cell;
    tmpCell.display     = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
