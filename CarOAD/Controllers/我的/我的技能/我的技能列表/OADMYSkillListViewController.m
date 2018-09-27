//
//  OADMYSkillListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMYSkillListViewController.h"

#import "MYSkillListViewModel.h"
#import "MYSkillListRootModel.h"
#import "PublishMySkillData.h"

#import "MYSkillListCell.h"

#import "OADMYSkillDetailesViewController.h"
#import "OADPublishMySkillViewController.h"
#import "OADOrderMessageListViewController.h"

@interface OADMYSkillListViewController ()<UITableViewDelegate, UITableViewDataSource, MYSkillListCellDelegate>

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *datasArray;

@end

@implementation OADMYSkillListViewController

- (NSMutableArray *)datasArray {
    
    if (_datasArray == nil) {
        
        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}

- (NSMutableDictionary *)params {
    
    if (!_params) {
        
        _params = [[NSMutableDictionary alloc] init];
    }
    
    return _params;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void) initialization {
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"我的技能";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight - SafeAreaBottomHeight - 60 *Scale_Height);
    self.tableView.frame = self.contentView.bounds;
    self.tableView.backgroundColor = BackGrayColor;
    
    [MYSkillListCell registerToTableView:self.tableView];
        
    NSMutableArray *images = [NSMutableArray array];
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:images forState:MJRefreshStateIdle];
    [header setImages:images forState:MJRefreshStatePulling];
    [header setImages:images forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    {
        
        self.bottomView.frame = CGRectMake(0, self.view.height - 60 *Scale_Height - SafeAreaBottomHeight, Screen_Width, 60 *Scale_Height + SafeAreaBottomHeight);
        self.bottomView.hidden = NO;
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.bottomView.width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"添加技能"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = MainColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_16;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bottomView addSubview:button];
        
    }
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    __weak OADMYSkillListViewController *weakSelf = self;
    PublishMySkillData *tmpData = [PublishMySkillData new];
    OADPublishMySkillViewController *viewController = [OADPublishMySkillViewController new];
    viewController.data = tmpData;
    viewController.publishSkillSuccess = ^(BOOL isPublishSkillSuccess) {

        if (isPublishSkillSuccess) {

            [weakSelf loadNewData];

        }

    };
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void) loadNewData {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [MYSkillListViewModel requestPost_getSkillListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        MYSkillListRootModel *rootModel  = [[MYSkillListRootModel alloc] initWithDictionary:info];
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        if (rootModel.data.count > 0) {
            
            for (MYSkillListData *tmpData in rootModel.data) {
                
                [dataArray addObject:tmpData];
                
            }
            
        }
        
        self.datasArray = [dataArray mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.f];
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10 *Scale_Height;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 10 *Scale_Height)];
    backView.backgroundColor = BackGrayColor;
    
    return backView;
    
}

//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.datasArray.count;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150 *Scale_Height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYSkillListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYSkillListCell" forIndexPath:indexPath];
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    cell.delegate         = self;
    if (self.datasArray.count > 0) {
        
        cell.data = self.datasArray[indexPath.section];
        [cell loadContent];
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYSkillListData *model = self.datasArray[indexPath.section];
    OADMYSkillDetailesViewController *viewController = [OADMYSkillDetailesViewController new];
    viewController.skillId = model.skillId;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark - MYSkillListCellDelegate
- (void) clickEdiSkillWithData:(id)data; {
    
    MYSkillListData *model = data;
    
    __weak OADMYSkillListViewController *weakSelf = self;
    PublishMySkillData *tmpData = [PublishMySkillData new];
    tmpData.skillId = model.skillId;
    
    OADPublishMySkillViewController *viewController = [OADPublishMySkillViewController new];
    viewController.data = tmpData;
    viewController.publishSkillSuccess = ^(BOOL isPublishSkillSuccess) {
        
        if (isPublishSkillSuccess) {
            
            [weakSelf loadNewData];
            
        }
        
    };
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void) clickDeleteSkillWithData:(id)data; {
    
    __weak OADMYSkillListViewController *weakSelf = self;
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:@"删除技能" message:@"简历技能后不可恢复，您确定删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        MYSkillListData *model = data;
        NSDictionary *params = @{@"skillId" : model.skillId};
        
        [MBProgressHUD showMessage:nil toView:self.view];
        
        [MYSkillListViewModel requestPost_deleteSkillNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
            
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
            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
            
        }];
        
    }];
    
    [alertDialog addAction:okAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
    }];
    [alertDialog addAction:cancelAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
    
}

- (void) clickChangeStateSkillWithData:(id)data; {
    
    MYSkillListData *model  = data;
    NSDictionary    *params = nil;
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    if ([model.skillState isEqualToString:@"Y"]) {
        
        params = @{@"skillId" : model.skillId,
                   @"userId" : accountInfo.user_id,
                   @"state" : @"N"
                   };
        
    } else {
        
        params = @{@"skillId" : model.skillId,
                   @"userId" : accountInfo.user_id,
                   @"state" : @"Y"
                   };
        
    }
    
    __weak OADMYSkillListViewController *weakSelf = self;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [MYSkillListViewModel requestPost_modifySkillStateNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:@"状态修改成功" toView:self.view afterDelay:1.f];
            int64_t delayInSeconds = 1.2f;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [weakSelf loadNewData];
                
            });
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

- (void) clickHandleSkillWithData:(id)data; {
    
    MYSkillListData *model = data;
    
    OADOrderMessageListViewController *viewController = [OADOrderMessageListViewController new];
    viewController.skillId = model.skillId;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
