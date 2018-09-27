//
//  OADMyOrderDetailsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMyOrderDetailsViewController.h"

#import "MyOrderDetailsRootModel.h"
#import "MyOrderDetailsViewModel.h"
#import "MyOrderListViewModel.h"

#import "OrderDetailsHeaderView.h"
#import "OrderDetailsDescriptioCell.h"
#import "OrderDetailsAddressCell.h"
#import "OrderDetailsShopInfoCell.h"
#import "OrderDetailsCommentCell.h"

#import "RootTabBarViewController.h"
#import "OADIWantToOrderViewController.h"
#import "OADMapsNavigationViewController.h"
#import "FindNeedInfoOfNearbyData.h"

@interface OADMyOrderDetailsViewController ()<CustomAdapterTypeTableViewCellDelegate, AMapLocationManagerDelegate, OrderDetailsHeaderViewDelegate>
{
    
    NSString   *shopPhone;
    CLLocation *userLocation;
    
}
@property (nonatomic, strong) MyOrderDetailsRootModel *rootModel;
@property (nonatomic, strong) MyOrderDetailsData      *headerViewData;
@property (nonatomic, strong) AMapLocationManager     *locationManager;

@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;

@property (nonatomic, strong) OrderDetailsHeaderView *headerView;
@property (nonatomic, strong) NSMutableDictionary    *params;
@property (nonatomic, strong) NSMutableArray         *classModels;
@property (nonatomic, strong) NSMutableArray         *datasArray;

@property (nonatomic, strong) UILabel  *numberLabel;
@property (nonatomic, strong) UIButton *bottom_left_button;
@property (nonatomic, strong) UIButton *bottom_right_button;
@property (nonatomic, strong) UIButton *delete_button;
@property (nonatomic, strong) UIButton *order_button;
@property (nonatomic, strong) UIView   *bottomBackView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OADMyOrderDetailsViewController

- (QTCheckImageScrollView *)checkImageScrollView {
    
    if (!_checkImageScrollView) {
        
        _checkImageScrollView = [QTCheckImageScrollView new];
        
    }
    
    return _checkImageScrollView;
    
}

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

    [self initialization];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTimer];
    
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void) initialization {
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    NSDictionary   *params = @{@"demandId" : self.demandId,
                               @"userId"   : accountInfo.user_id
                               };
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [MyOrderDetailsViewModel requestPost_getDemandInfoNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        int64_t delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            self.datasArray = [NSMutableArray array];
            [self.tableView reloadData];
            
            NSMutableArray *tmpDatasArray = [NSMutableArray array];
            //  获取用户数据
            MyOrderDetailsRootModel *model = [[MyOrderDetailsRootModel alloc] initWithDictionary:info];
            
            self.rootModel = model;
            
            MyOrderDetailsData *newModel = [model.data[0] timeModelWithData:model.data[0]];
            self.headerViewData          = newModel;
            self.headerView.data         = newModel;
            [self.headerView loadContent];
            
            [self loadServiceContentCellDataWithRootModel:model];
            [self loadAddressCellDataWithModel:newModel];
            [self loadUserInfoCellDataWithRootModel:model];
            [self loadCommentListCellDataWithRootModel:model];
            
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
            
            if (userLocation.coordinate.latitude > 0) {
                
                NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[1];
                TableViewCellDataAdapter *adapter = adapters[0];
                MyOrderDetailsData       *model   = adapter.data;
                [model calculateDistanceWithLocation:userLocation];
                
                self.adapters = [NSMutableArray array];
                [OrderDetailsAddressCell cellHeightWithData:model];
                TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsAddressCell"
                                                                                                                            data:model
                                                                                                                      cellHeight:model.normalStringHeight
                                                                                                                        cellType:kOrderDetailsAddressCellNormalType];
                [self.adapters addObject:jobIntensionAdapter];
                [self.datasArray replaceObjectAtIndex:1 withObject:self.adapters];
                
                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                
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
                    
                    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[1];
                    TableViewCellDataAdapter *adapter = adapters[0];
                    MyOrderDetailsData       *model   = adapter.data;
                    [model calculateDistanceWithLocation:location];
                    
                    self.adapters = [NSMutableArray array];
                    [OrderDetailsAddressCell cellHeightWithData:model];
                    TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsAddressCell"
                                                                                                                                data:model
                                                                                                                          cellHeight:model.normalStringHeight
                                                                                                                            cellType:kOrderDetailsAddressCellNormalType];
                    [self.adapters addObject:jobIntensionAdapter];
                    [self.datasArray replaceObjectAtIndex:1 withObject:self.adapters];
                    
                    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
                    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    
                    userLocation = location;
                    
                }];
                
            }
            
            MyOrderDetailsData *data = model.data[0];
            
            if (data.msgCount.length > 0) {
                
                self.numberLabel.text = [NSString stringWithFormat:@"共%@条",data.msgCount];
                
            } else {
                
                self.numberLabel.text = @"共0条";
                
            }
            
            if (self.isNeedListPush == YES) {
                
                if (data.demandState.length > 0) {
                    
                    if ([data.demandState isEqualToString:@"4"]) {
                        
                        self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight - self.bottomView.height);
                        self.bottomView.hidden = NO;
                        self.bottom_left_button.hidden = YES;
                        self.bottom_right_button.hidden = YES;
                        self.delete_button.hidden = YES;
                        self.order_button.hidden = NO;
                        
                    } else {
                        
                        self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight);
                        self.bottomView.hidden = YES;
                        self.bottom_left_button.hidden = YES;
                        self.bottom_right_button.hidden = YES;
                        self.delete_button.hidden = YES;
                        self.order_button.hidden = YES;
                        
                    }
                    
                } else {
                    
                    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight);
                    self.bottomView.hidden = YES;
                    self.bottom_left_button.hidden = YES;
                    self.bottom_right_button.hidden = YES;
                    self.delete_button.hidden = YES;
                    self.order_button.hidden = YES;
                    
                }
                
            } else {
                
                if (data.demandState.length > 0) {
                    
                    if ([data.demandState isEqualToString:@"0"]) {
                        
                        self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight - self.bottomView.height);
                        self.bottomView.hidden = NO;
                        self.bottom_left_button.hidden = NO;
                        self.bottom_right_button.hidden = NO;
                        self.delete_button.hidden = YES;
                        self.order_button.hidden = YES;
                        
                    } else if ([data.demandState isEqualToString:@"1"]) {
                        
                        self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight);
                        self.bottomView.hidden = YES;
                        self.bottom_left_button.hidden = YES;
                        self.bottom_right_button.hidden = YES;
                        self.delete_button.hidden = YES;
                        self.order_button.hidden = YES;
                        
                    } else if ([data.demandState isEqualToString:@"2"]) {
                        
                        self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight - self.bottomView.height);
                        self.bottomView.hidden = NO;
                        self.tableView.hidden      = YES;
                        self.bottom_left_button.hidden = YES;
                        self.bottom_right_button.hidden = YES;
                        self.delete_button.hidden = NO;
                        self.order_button.hidden = YES;
                        
                    }
                    
                } else {
                    
                    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight);
                    self.bottomView.hidden = YES;
                    self.bottom_left_button.hidden = YES;
                    self.bottom_right_button.hidden = YES;
                    self.delete_button.hidden = YES;
                    self.order_button.hidden = YES;
                    
                }
                
            }
            
            self.tableView.frame = self.contentView.bounds;

            if (model.orderMsgList.count > 0) {
                
                self.tableView.tableFooterView = [self createTableFooterView];
                
            } else {
                
                self.tableView.tableFooterView = nil;
                
            }
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.f];
        
    }];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"详情";
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
    
    self.tableView.frame = CGRectMake(0, 0, Screen_Width, self.contentView.height);
    self.tableView.backgroundColor = BackGrayColor;
    OrderDetailsHeaderView *headerView = [[OrderDetailsHeaderView alloc] init];
    headerView.delegate                = self;
    self.tableView.tableHeaderView     = headerView;
    self.headerView = headerView;
    
    [OrderDetailsDescriptioCell registerToTableView:self.tableView];
    [OrderDetailsAddressCell registerToTableView:self.tableView];
    [OrderDetailsShopInfoCell registerToTableView:self.tableView];
    [OrderDetailsCommentCell registerToTableView:self.tableView];
    
    {
        
        self.bottomView.frame = CGRectMake(0, self.view.height - 54 *Scale_Height - SafeAreaBottomHeight, Screen_Width, 54 *Scale_Height + SafeAreaBottomHeight);
        
        UIView *bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5f, Screen_Width, 54 *Scale_Height)];
        bottomBackView.backgroundColor = [UIColor whiteColor];
        [self.bottomView addSubview:bottomBackView];
        self.bottomBackView = bottomBackView;
        
        UIButton *leftButton = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, (Screen_Width - 50 *Scale_Width) / 2, 34 *Scale_Height)
                                                         title:@"取消接单"
                                               backgroundImage:nil
                                                           tag:1000
                                                        target:self
                                                        action:@selector(buttonEvent:)];
        leftButton.titleLabel.font     = [UIFont fontWithName:@"Avenir-Book" size:15.f *Scale_Width];
        [bottomBackView addSubview:leftButton];
        leftButton.layer.masksToBounds = YES;
        leftButton.layer.borderWidth   = 0.7f;
        leftButton.layer.borderColor   = TextGrayColor.CGColor;
        leftButton.layer.cornerRadius  = 3.f *Scale_Width;
        self.bottom_left_button = leftButton;
        self.bottom_left_button.hidden = YES;
        
        UIButton *rightButton = [UIButton createWithLeftImageAndRightTextButtonWithFrame:CGRectMake(Screen_Width / 2 + 10 *Scale_Width, 10 *Scale_Height, (Screen_Width - 50 *Scale_Width) / 2, 34 *Scale_Height)
                                                                                   title:@"电话沟通"
                                                                                   image:[UIImage imageNamed:@"call_phone_white"]
                                                                                     tag:1001
                                                                                  target:self
                                                                                  action:@selector(buttonEvent:)];
        rightButton.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:15.f *Scale_Width];
        [bottomBackView addSubview:rightButton];
        rightButton.layer.masksToBounds = YES;
        rightButton.layer.cornerRadius  = 3.f *Scale_Width;
        rightButton.backgroundColor = MainColor;
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bottom_right_button = rightButton;
        self.bottom_right_button.hidden = YES;
        
        UIButton *deleteButton = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 34 *Scale_Height)
                                                           title:@"删除"
                                                 backgroundImage:nil
                                                             tag:1002
                                                          target:self
                                                          action:@selector(buttonEvent:)];
        deleteButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:15.f *Scale_Width];
        [bottomBackView addSubview:deleteButton];
        deleteButton.layer.masksToBounds = YES;
        deleteButton.layer.cornerRadius  = 3.f *Scale_Width;
        deleteButton.backgroundColor = MainColor;
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.delete_button = deleteButton;
        self.delete_button.hidden = YES;
        
        UIButton *order_button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 34 *Scale_Height)
                                                           title:@"我要接单"
                                                 backgroundImage:nil
                                                             tag:1003
                                                          target:self
                                                          action:@selector(buttonEvent:)];
        order_button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:15.f *Scale_Width];
        [bottomBackView addSubview:order_button];
        order_button.layer.masksToBounds = YES;
        order_button.layer.cornerRadius  = 3.f *Scale_Width;
        order_button.backgroundColor = MainColor;
        [order_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.order_button = order_button;
        self.order_button.hidden = YES;
        
    }
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    //  判断用户登录
    if (sender.tag == 1000) {
        
        __weak OADMyOrderDetailsViewController *weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消接单"
                                                                                 message:@"您的接单正在进行中，您确定要取消吗？"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf cancelDemandOrder];
            
        }];
        [alertController addAction:OKAction];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
    } else if (sender.tag == 1001) {
        
        if (shopPhone.length > 0) {
            
            NSString *num = CustomerServicePhone; //number为号码字
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"暂无联系方式" toView:self.view afterDelay:1.f];
            
        }
        
    } else if (sender.tag == 1002) {
        
        __weak OADMyOrderDetailsViewController *weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除接单"
                                                                                 message:@"您确定要删除接单吗？"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf cancelDemandOrder];
            
        }];
        [alertController addAction:OKAction];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
    } else if (sender.tag == 1003) {
        
        OADIWantToOrderViewController *viewController = [OADIWantToOrderViewController new];
        viewController.data                           = self.headerViewData;
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (sender.tag == 1004) {
        
        
        
    }
    
}

- (void) cancelDemandOrder {
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    NSDictionary   *params = @{@"demandOrderId" : self.demandId,
                               @"userId"        : accountInfo.user_id
                               };
    
    [MyOrderListViewModel requestPost_cancelDemandOrderNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"取消成功" toView:self.view afterDelay:1.f];
        int64_t delayInSeconds = 1.2f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.f];
        
    }];
    
}

#pragma mark - 更新dataSours
- (void) loadServiceContentCellDataWithRootModel:(id)rootModel {
    
    MyOrderDetailsRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MyOrderDetailsData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        MyOrderDetailsData *data = datasArray[0];
        
        self.adapters = [NSMutableArray array];
        [OrderDetailsDescriptioCell cellHeightWithData:data];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsDescriptioCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:kOrderDetailsDescriptioCellNormalType];
        
        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MyOrderDetailsData *data = nil;
        [OrderDetailsDescriptioCell cellHeightWithData:nil];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsDescriptioCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:kOrderDetailsDescriptioCellNoDataType];
        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadAddressCellDataWithModel:(id)model {
    
    MyOrderDetailsData *data = model;
    
    if (data) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        [datasArray addObject:data];
        self.adapters = [NSMutableArray array];
        MyOrderDetailsData *data = datasArray[0];
        [OrderDetailsAddressCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsAddressCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.normalStringHeight
                                                                                                                cellType:kOrderDetailsAddressCellNormalType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MyOrderDetailsData *data = [[MyOrderDetailsData alloc] init];
        [OrderDetailsAddressCell cellHeightWithData:nil];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsAddressCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kOrderDetailsAddressCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadUserInfoCellDataWithRootModel:(id)rootModel {
    
    MyOrderDetailsRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MyOrderDetailsData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        MyOrderDetailsData *data = datasArray[0];
        [OrderDetailsShopInfoCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsShopInfoCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.normalStringHeight
                                                                                                                cellType:kOrderDetailsShopInfoCellNormalType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MyOrderDetailsData *data = [[MyOrderDetailsData alloc] init];
        [OrderDetailsShopInfoCell cellHeightWithData:nil];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsShopInfoCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kOrderDetailsShopInfoCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadCommentListCellDataWithRootModel:(id)rootModel {
    
    MyOrderDetailsRootModel *model = rootModel;
    
    if (model.orderMsgList.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MyOrderDetailsOrderMsgList *data in model.orderMsgList) {
            
            [datasArray addObject:data];
            
        }
        
        self.adapters = [NSMutableArray array];
        for (int i = 0; i < datasArray.count; i++) {
            
            MyOrderDetailsOrderMsgList *educationExperience = datasArray[i];
            [OrderDetailsCommentCell cellHeightWithData:educationExperience];
            MyOrderDetailsOrderMsgList *newModel = [educationExperience timeModelWithData:educationExperience];
            TableViewCellDataAdapter *educationExperienceAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsCommentCell"
                                                                                                                               data:newModel
                                                                                                                         cellHeight:newModel.normalStringHeight
                                                                                                                           cellType:kOrderDetailsCommentCellNormalType];
            [self.adapters addObject:educationExperienceAdapter];
        }
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MyOrderDetailsOrderMsgList *data = [[MyOrderDetailsOrderMsgList alloc] init];
        [OrderDetailsCommentCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsCommentCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kOrderDetailsCommentCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode; {
    
    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[1];
    TableViewCellDataAdapter *adapter = adapters[0];
    MyOrderDetailsData       *model   = adapter.data;
    [model calculateDistanceWithLocation:location];
    
    self.adapters = [NSMutableArray array];
    [OrderDetailsAddressCell cellHeightWithData:model];
    TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderDetailsAddressCell"
                                                                                                                data:model
                                                                                                          cellHeight:model.normalStringHeight
                                                                                                            cellType:kOrderDetailsAddressCellNormalType];
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
    
    if (section == 0 || section == 2 || section == 3) {
        
        backView.frame = CGRectMake(0, 0, Screen_Width, 50 *Scale_Height);
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Height, Screen_Width, 40 *Scale_Height)];
        contentView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:contentView];
        
        if (section == 0) {
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"故障描述"
                                                      font:UIFont_16
                                                 textColor:TextBlackColor
                                             textAlignment:NSTextAlignmentLeft
                                                       tag:100];
            [contentView addSubview:label];
            
        } else if (section == 2) {
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"商家信息"
                                                      font:UIFont_16
                                                 textColor:TextBlackColor
                                             textAlignment:NSTextAlignmentLeft
                                                       tag:100];
            [contentView addSubview:label];
            
        } else {
            
            UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                      labelType:kLabelNormal
                                                           text:@"接单留言"
                                                           font:UIFont_16
                                                      textColor:TextBlackColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:100];
            [contentView addSubview:titleLabel];
            [titleLabel sizeToFit];
            titleLabel.frame = CGRectMake(15 *Scale_Width, 0, titleLabel.width, 40 *Scale_Height);
            
            UILabel *numberLabel = [UILabel createLabelWithFrame:CGRectMake(titleLabel.x + titleLabel.width + 10 *Scale_Width, 0, Screen_Width - (titleLabel.x + titleLabel.width + 25 *Scale_Width), 40 *Scale_Height)
                                                       labelType:kLabelNormal
                                                            text:@"共0条"
                                                            font:UIFont_15
                                                       textColor:TextGrayColor
                                                   textAlignment:NSTextAlignmentRight
                                                             tag:100];
            [contentView addSubview:numberLabel];
            self.numberLabel = numberLabel;
            
            MyOrderDetailsData *data = self.rootModel.data[0];
            
            if (data.msgCount.length > 0) {
                
                self.numberLabel.text = [NSString stringWithFormat:@"共%@条",data.msgCount];
                
            } else {
                
                self.numberLabel.text = @"共0条";
                
            }
            
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
    
    if (section == 0 || section == 2 || section == 3) {
        
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

- (UIView *) createTableFooterView {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50 *Scale_Height)];
    backView.backgroundColor = [UIColor clearColor];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    contentView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:contentView];
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:contentView.bounds
                                              labelType:kLabelNormal
                                                   text:@"查看更多留言"
                                                   font:UIFont_16
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentCenter
                                                    tag:100];
    [contentView addSubview:titleLabel];
    
    UIButton *button = [UIButton createButtonWithFrame:contentView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1004
                                                target:self
                                                action:@selector(buttonEvent:)];
    [contentView addSubview:button];
    
    return backView;
    
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

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[indexPath.section];
        TableViewCellDataAdapter *adapter = adapters[indexPath.row];
        MyOrderDetailsData *data = adapter.data;
        
        if (data.address.length > 0) {
            
            FindNeedInfoOfNearbyData *model = [FindNeedInfoOfNearbyData new];
            model.demandTitle = data.demandTitle;
            model.demandType  = data.address;
            model.demandImg   = data.shopLinkmanImg;
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

    CustomAdapterTypeTableViewCell *tmpCell = (CustomAdapterTypeTableViewCell *)cell;
    [tmpCell loadContent];
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    CustomAdapterTypeTableViewCell *tmpCell = (CustomAdapterTypeTableViewCell *)cell;
    tmpCell.display     = NO;
    
}

#pragma mark - TimerEvent
- (void)createTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerEvent {
    
    MyOrderDetailsData *model = self.headerViewData;
    [model countDown];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationDetailsCountDownTimeCell object:nil];
    
}

#pragma mark - MYSkillDetailesHeaderViewDelegate
- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag; {
    
    self.checkImageScrollView.imagesArray = [array copy];
    [self.checkImageScrollView showwithTag:tag];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
