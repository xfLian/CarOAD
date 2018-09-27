//
//  OADMYSkillDetailesViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMYSkillDetailesViewController.h"

#import "MYSkillDetailesRootModel.h"
#import "MYSkillDetailesViewModel.h"
#import "MYSkillListViewModel.h"

#import "MYSkillDetailesHeaderView.h"
#import "MySkillDetailsServiceContentCell.h"
#import "MySkillDetailsAddressCell.h"
#import "MySkillDetailsUserInfoTableViewCell.h"
#import "MySkillDetailsCommentListCell.h"

#import "RootTabBarViewController.h"
#import "OADMySkillCommentListViewController.h"
#import "OADOrderMessageListViewController.h"

@interface OADMYSkillDetailesViewController ()<CustomAdapterTypeTableViewCellDelegate, AMapLocationManagerDelegate, MYSkillDetailesHeaderViewDelegate>

@property (nonatomic, strong) MYSkillDetailesRootModel *rootModel;
@property (nonatomic, strong) AMapLocationManager      *locationManager;

@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *classModels;
@property (nonatomic, strong) NSMutableArray      *datasArray;

@property (nonatomic, strong) UILabel  *numberLabel;
@property (nonatomic, strong) UIButton *bottom_left_button;
@property (nonatomic, strong) UIButton *bottom_right_button;

@end

@implementation OADMYSkillDetailesViewController

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
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
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
    
    NSDictionary *params = @{@"skillId" : self.skillId};
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [MYSkillDetailesViewModel requestPost_getSkillInfoNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        int64_t delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            self.datasArray = [NSMutableArray array];
            [self.tableView reloadData];
            
            NSMutableArray *tmpDatasArray = [NSMutableArray array];
            //  获取用户数据
            MYSkillDetailesRootModel *model = [[MYSkillDetailesRootModel alloc] initWithDictionary:info];
            self.rootModel = model;
            
            MYSkillDetailesHeaderView *headerView = [[MYSkillDetailesHeaderView alloc] init];
            headerView.data                       = model.data[0];
            headerView                            = [headerView createHeaderView];
            self.tableView.tableHeaderView        = headerView;
            headerView.delegate                   = self;
            
            [self loadServiceContentCellDataWithRootModel:model];
            [self loadAddressCellDataWithRootModel:model];
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
            
            [self.locationManager startUpdatingLocation];
            
            MYSkillDetailesData *data = model.data[0];
            
            if (data.commentCount.length > 0) {
                
                self.numberLabel.text = [NSString stringWithFormat:@"共%@条",data.commentCount];
                
            } else {
                
                self.numberLabel.text = @"共0条";
                
            }
            
            self.bottomView.hidden = NO;
            if (data.skillState.length > 0 && [data.skillState isEqualToString:@"Y"]) {
                
                [self.bottom_left_button setTitle:@"暂停服务" forState:UIControlStateNormal];
                
            } else {
                
                [self.bottom_left_button setTitle:@"恢复服务" forState:UIControlStateNormal];
                
            }
            
            if (model.orderMsgList.count > 0) {
                
                self.tableView.tableFooterView = [self createTableFooterView];
                
            } else {
                
                self.tableView.tableFooterView = nil;
                
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
    
    self.navTitle     = @"技能详情";
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
    
    [MySkillDetailsServiceContentCell registerToTableView:self.tableView];
    [MySkillDetailsAddressCell registerToTableView:self.tableView];
    [MySkillDetailsUserInfoTableViewCell registerToTableView:self.tableView];
    [MySkillDetailsCommentListCell registerToTableView:self.tableView];
    
    {

         self.bottomView.frame = CGRectMake(0, self.view.height - 54 *Scale_Height - SafeAreaBottomHeight, Screen_Width, 54 *Scale_Height + SafeAreaBottomHeight);
        
        UIButton *leftButton = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, (Screen_Width - 50 *Scale_Width) / 2, 34 *Scale_Height)
                                                             title:@"恢复服务"
                                                   backgroundImage:nil
                                                               tag:1000
                                                            target:self
                                                            action:@selector(buttonEvent:)];
        leftButton.titleLabel.font     = [UIFont fontWithName:@"Avenir-Book" size:15.f *Scale_Width];
        [self.bottomView addSubview:leftButton];
        leftButton.layer.masksToBounds = YES;
        leftButton.layer.borderWidth   = 0.7f;
        leftButton.layer.borderColor   = TextGrayColor.CGColor;
        leftButton.layer.cornerRadius  = 3.f *Scale_Width;
        self.bottom_left_button = leftButton;
        
        UIButton *rightButton = [UIButton createButtonWithFrame:CGRectMake(Screen_Width / 2 + 10 *Scale_Width, 10 *Scale_Height, (Screen_Width - 50 *Scale_Width) / 2, 34 *Scale_Height)
                                                         title:@"去处理"
                                               backgroundImage:nil
                                                           tag:1001
                                                        target:self
                                                        action:@selector(buttonEvent:)];
        rightButton.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:15.f *Scale_Width];
        [self.bottomView addSubview:rightButton];
        rightButton.layer.masksToBounds = YES;
        rightButton.layer.borderWidth   = 0.7f;
        rightButton.layer.borderColor   = TextGrayColor.CGColor;
        rightButton.layer.cornerRadius  = 3.f *Scale_Width;
        self.bottom_right_button = leftButton;
        
    }

}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        
        MYSkillDetailesData *data = self.rootModel.data[0];
        
        NSDictionary *params = nil;
        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
        [self.params setObject:accountInfo.user_id forKey:@"userId"];
        if ([data.skillState isEqualToString:@"Y"]) {
            
            params = @{@"skillId" : self.skillId,
                       @"userId" : accountInfo.user_id,
                       @"state" : @"N"
                       };
            
        } else {
            
            params = @{@"skillId" : self.skillId,
                       @"userId" : accountInfo.user_id,
                       @"state" : @"Y"
                       };
            
        }
        
        __weak OADMYSkillDetailesViewController *weakSelf = self;
        [MBProgressHUD showMessage:nil toView:self.view];
        
        [MYSkillListViewModel requestPost_modifySkillStateNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"状态修改成功" toView:self.view afterDelay:1.f];
                int64_t delayInSeconds = 1.2f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    
                    [weakSelf initialization];
                    
                });
                
            });
            
        } error:^(NSString *errorMessage) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
            
        }];
        
    } else if (sender.tag == 1001) {
                        
        OADOrderMessageListViewController *viewController = [OADOrderMessageListViewController new];
        viewController.skillId = self.skillId;
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else {
        
        OADMySkillCommentListViewController *viewController = [OADMySkillCommentListViewController new];
        viewController.skillId = self.skillId;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

#pragma mark - 更新dataSours
- (void) loadServiceContentCellDataWithRootModel:(id)rootModel {
    
    MYSkillDetailesRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MYSkillDetailesData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        MYSkillDetailesData *data = datasArray[0];
        
        self.adapters = [NSMutableArray array];
        [MySkillDetailsServiceContentCell cellHeightWithData:data];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsServiceContentCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:kMySkillDetailsServiceContentCellNormalType];
        
        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MYSkillDetailesData *data = nil;
        [MySkillDetailsServiceContentCell cellHeightWithData:nil];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsServiceContentCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:kMySkillDetailsServiceContentCellNoDataType];
        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadAddressCellDataWithRootModel:(id)rootModel {
    
    MYSkillDetailesRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MYSkillDetailesData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        MYSkillDetailesData *data = datasArray[0];
        [MySkillDetailsAddressCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsAddressCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.normalStringHeight
                                                                                                                cellType:kMySkillDetailsAddressCellNormalType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MYSkillDetailesData *data = [[MYSkillDetailesData alloc] init];
        [MySkillDetailsAddressCell cellHeightWithData:nil];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsAddressCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kMySkillDetailsAddressCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadUserInfoCellDataWithRootModel:(id)rootModel {
    
    MYSkillDetailesRootModel *model = rootModel;
    
    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MYSkillDetailesData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        MYSkillDetailesData *data = datasArray[0];
        [MySkillDetailsUserInfoTableViewCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsUserInfoTableViewCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.normalStringHeight
                                                                                                                cellType:kMySkillDetailsUserInfoTableViewCellNormalType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MYSkillDetailesData *data = [[MYSkillDetailesData alloc] init];
        [MySkillDetailsUserInfoTableViewCell cellHeightWithData:nil];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsUserInfoTableViewCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kMySkillDetailsUserInfoTableViewCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

- (void) loadCommentListCellDataWithRootModel:(id)rootModel {
    
    MYSkillDetailesRootModel *model = rootModel;
    
    if (model.orderMsgList.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (MYSkillDetailesOrderMsgList *data in model.orderMsgList) {
            
            [datasArray addObject:data];
            
        }

        self.adapters = [NSMutableArray array];
        for (int i = 0; i < datasArray.count; i++) {
            
            MYSkillDetailesOrderMsgList *educationExperience = datasArray[i];
            [MySkillDetailsCommentListCell cellHeightWithData:educationExperience];
            TableViewCellDataAdapter *educationExperienceAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsCommentListCell"
                                                                                                                               data:educationExperience
                                                                                                                         cellHeight:educationExperience.normalStringHeight
                                                                                                                           cellType:kMySkillDetailsCommentListCellNormalType];
            [self.adapters addObject:educationExperienceAdapter];
        }
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        MYSkillDetailesOrderMsgList *data = [[MYSkillDetailesOrderMsgList alloc] init];
        [MySkillDetailsCommentListCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsCommentListCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kMySkillDetailsCommentListCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    }
    
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode; {
    
    CarOadLog(@"位置变化");
    
    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[1];
    TableViewCellDataAdapter *adapter = adapters[0];
    MYSkillDetailesData      *model   = adapter.data;
    [model calculateDistanceWithLocation:location];
    
    self.adapters = [NSMutableArray array];
    [MySkillDetailsAddressCell cellHeightWithData:model];
    TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsAddressCell"
                                                                                                                data:model
                                                                                                          cellHeight:model.normalStringHeight
                                                                                                            cellType:kMySkillDetailsAddressCellNormalType];
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
    
    if (section == 0 || section == 3) {
        
        backView.frame = CGRectMake(0, 0, Screen_Width, 50 *Scale_Height);
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Height, Screen_Width, 40 *Scale_Height)];
        contentView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:contentView];
        
        if (section == 0) {
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     labelType:kLabelNormal
                                                          text:@"服务内容"
                                                          font:UIFont_16
                                                     textColor:TextBlackColor
                                                 textAlignment:NSTextAlignmentLeft
                                                           tag:100];
            [contentView addSubview:label];
            
        } else {
            
            UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 0, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"评价"
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
    
    if (section == 0 || section == 3) {
        
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
                                                   text:@"查看更多评论"
                                                   font:UIFont_16
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentCenter
                                                    tag:100];
    [contentView addSubview:titleLabel];
    
    UIButton *button = [UIButton createButtonWithFrame:contentView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1002
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
    
    [cell loadContent];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
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
