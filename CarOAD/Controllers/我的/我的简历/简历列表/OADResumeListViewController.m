//
//  OADResumeListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADResumeListViewController.h"

#import "ResumeListNoDataView.h"
#import "ResumeListCell.h"
#import "ResumeListRootModel.h"

#import "ResumeListViewModel.h"
#import "UserInfomationDataModel.h"
#import "UserInfomationRootModel.h"

#import "OADCreateCVViewController.h"
#import "OADUserInfomationViewController.h"
#import "OADCVBrowseViewController.h"
#import "OADCVSettingViewController.h"

@interface OADResumeListViewController ()<ResumeListNoDataViewDelegate, CustomAdapterTypeTableViewCellDelegate, ResumeListCellDelegate>

@property (nonatomic, strong) ResumeListNoDataView *noDataView;
@property (nonatomic, strong) ResumeListRootModel  *rootModel;
@property (nonatomic, strong) UIButton             *rightNavButton;
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation OADResumeListViewController

- (ResumeListNoDataView *)noDataView {

    if (!_noDataView) {

        _noDataView = [[ResumeListNoDataView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _noDataView.delegate = self;

    }

    return _noDataView;

}

- (NSMutableDictionary *)params {

    if (!_params) {

        _params = [[NSMutableDictionary alloc] init];
    }

    return _params;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;

    [self initialization];
    
}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void) initialization {

    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {

        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];

        [self.params setObject:accountInfo.user_id forKey:@"userId"];

        [self.tableView.mj_header beginRefreshing];
        
    }

}

- (void)setNavigationController {

    self.navTitle     = @"我的简历";
    self.leftItemText = @"返回";

    [super setNavigationController];

    UIButton *rightNavButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavButton.frame           = CGRectMake(0, 0, 44, 44);
    UIImage *ima                   = [UIImage imageNamed:@"set_white_eight"];
    rightNavButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [rightNavButton setImage:ima forState:UIControlStateNormal];
    [rightNavButton addTarget:self
                       action:@selector(clickRightItem)
             forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightNavButton];
    self.navigationItem.rightBarButtonItem = item;
    
    self.rightNavButton = rightNavButton;
    self.rightNavButton.enabled = NO;

}

- (void) clickRightItem {

    OADCVSettingViewController *viewController = [OADCVSettingViewController new];
    viewController.data = self.rootModel;
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)buildSubView {

    [super buildSubView];
    
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.noDataView];
    self.noDataView.hidden = YES;

    self.tableView.backgroundColor = BackGrayColor;

    [ResumeListCell registerToTableView:self.tableView];
    
    NSMutableArray *images = [NSMutableArray array];

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:images forState:MJRefreshStateIdle];
    [header setImages:images forState:MJRefreshStatePulling];
    [header setImages:images forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;

}

- (UIView *) creatFooterView {

    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height + SafeAreaBottomHeight)];
    footerView.backgroundColor = BackGrayColor;

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 20 *Scale_Height, footerView.width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"创建简历"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = MainColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_16;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [footerView addSubview:button];
        
    }

    return footerView;

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        [self gotoCreateResume];

    }

}

- (void) gotoCreateResume; {

    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {

        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
        NSDictionary   *params      = @{@"userId":accountInfo.user_id};

        [MBProgressHUD showMessage:nil toView:self.view];
        [UserInfomationDataModel requestPost_getUserInfoNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

            UserInfomationRootModel *rootModel = [[UserInfomationRootModel alloc] initWithDictionary:info];
            UserInfomationData      *data      = rootModel.data[0];

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            dispatch_async(dispatch_get_main_queue(), ^{

                if ([data.phoneIdenti isEqualToString:@"Y"]) {

                    [ResumeListViewModel requestPost_createCVNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

                        dispatch_async(dispatch_get_main_queue(), ^{

                            OADCreateCVViewController *viewController = [OADCreateCVViewController new];
                            viewController.data                       = data;
                            viewController.cvId                       = info[@"CVId"];
                            [self.navigationController pushViewController:viewController animated:YES];

                        });

                    } error:^(NSString *errorMessage) {

                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

                    } failure:^(NSError *error) {

                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];

                    }];

                } else {

                    OADUserInfomationViewController *viewController = [OADUserInfomationViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];

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

}

- (void) loadNewData {

    self.adapters = [NSMutableArray array];

    [MBProgressHUD showMessage:nil toView:self.view];
    self.rightNavButton.enabled = NO;

    [ResumeListViewModel requestPost_getResumeListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        CarOadLog(@"info --- %@",info);
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];

            NSMutableArray      *datasArray = [[NSMutableArray alloc] init];
            ResumeListRootModel *rootModel  = [[ResumeListRootModel alloc] initWithDictionary:info];
            self.rootModel = rootModel;
            
            for (ResumeListData *model in rootModel.data) {

                [datasArray addObject:model];

            }

            NSMutableArray *indexPaths = [NSMutableArray array];

            for (int i = 0; i < datasArray.count; i++) {

                ResumeListData *model = datasArray[i];

                [ResumeListCell cellHeightWithData:model];
                TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"ResumeListCell"
                                                                                                                data:model
                                                                                                          cellHeight:model.normalStringHeight
                                                                                                            cellType:kShowButtonCellNormalType];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                adapter.indexPath      = indexPath;
                [self.adapters addObject:adapter];
                [indexPaths addObject:indexPath];

            }

            [self.tableView.mj_header endRefreshing];
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            self.rightNavButton.enabled = YES;

            if (self.adapters.count <= 0) {

                self.tableView.hidden  = YES;
                self.noDataView.hidden = NO;

            } else if (self.adapters.count > 0 && self.adapters.count < 3) {

                self.tableView.hidden  = NO;
                self.noDataView.hidden = YES;
                self.tableView.tableFooterView = [self creatFooterView];

            } else {

                self.tableView.hidden  = NO;
                self.noDataView.hidden = YES;
                self.tableView.tableFooterView = nil;

            }
            for (ResumeListData *model in datasArray) {
                
                if ([model.isDefault integerValue] == 1) {
                    
                    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
                    accountInfo.default_cv_id   = model.CVId;
                    [OADSaveAccountInfoTool saveAccountInfo:accountInfo];
                    
                }
                
            }

        });

    } error:^(NSString *errorMessage) {

        self.tableView.hidden  = YES;
        self.noDataView.hidden = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

    } failure:^(NSError *error) {

        self.tableView.hidden  = YES;
        self.noDataView.hidden = NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomAdapterTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedEvent];

}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {



}

#pragma mark - ResumeListCellDelegate
- (void) clickCheckPreviewCVWithRow:(NSInteger)row; {

    TableViewCellDataAdapter *adapter = self.adapters[row];
    ResumeListData *data = adapter.data;
    OADCVBrowseViewController *viewController = [OADCVBrowseViewController new];
    viewController.cvId                       = data.CVId;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void) clickRefreshCVWithRow:(NSInteger)row; {

    TableViewCellDataAdapter *adapter = self.adapters[row];
    ResumeListData *data = adapter.data;
    
    NSDictionary *params = @{@"CVId" : data.CVId};
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [ResumeListViewModel requestPost_refreshCVNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:@"刷新成功" toView:self.view afterDelay:1.f];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];

}

- (void) clickEdiCVWithRow:(NSInteger)row; {
    
    TableViewCellDataAdapter *adapter = self.adapters[row];
    ResumeListData *data = adapter.data;

    OADCreateCVViewController *viewController = [OADCreateCVViewController new];
    viewController.cvId                       = data.CVId;
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void) clickDeleteCVWithRow:(NSInteger)row; {

    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    TableViewCellDataAdapter *adapter = self.adapters[row];
    ResumeListData           *data = adapter.data;
    
    if ([data.isDefault integerValue] == 1) {
        
        [MBProgressHUD showMessageTitle:@"默认简历不能删除" toView:self.view afterDelay:1.f];
        
    } else {
        
        NSDictionary *params = @{@"userId" : accountInfo.user_id,
                                 @"CVId"   : data.CVId};
        
        __weak OADResumeListViewController *weakSelf = self;
        
        UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:@"删除简历" message:@"简历删除后不可恢复，您确定删除吗？" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [MBProgressHUD showMessage:nil toView:self.view];
            [ResumeListViewModel requestPost_deleteCVNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD showMessageTitle:@"删除成功" toView:self.view afterDelay:1.f];
                    int64_t delayInSeconds = 1.2f;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        
                        [weakSelf loadNewData];
                        
                    });
                    
                });
                
            } error:^(NSString *errorMessage) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
                
            } failure:^(NSError *error) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.f];
                
            }];
            
        }];
        
        [alertDialog addAction:okAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            
        }];
        [alertDialog addAction:cancelAction];
        [self presentViewController:alertDialog animated:YES completion:nil];

    }
    
}

@end
