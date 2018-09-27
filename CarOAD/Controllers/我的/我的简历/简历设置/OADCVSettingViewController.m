//
//  OADCVSettingViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADCVSettingViewController.h"

#import "CVSettingViewModel.h"
#import "ResumeListRootModel.h"

#import "CVSettingIsDefaultCell.h"
#import "CVSettingIsOpenCell.h"
#import "CVSettingShieldingShopCell.h"

#import "OADAddShieldingShopViewController.h"

@interface OADCVSettingViewController ()<UITableViewDelegate, UITableViewDataSource, CVSettingIsDefaultCellDelegate, CVSettingIsOpenCellDelegate, CVSettingShieldingShopCellDelegate>
{
    
    BOOL isOpen;
    
}
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableDictionary *datasArrayData;

@end

@implementation OADCVSettingViewController

- (NSMutableDictionary *)datasArrayData {
    
    if (_datasArrayData == nil) {
        
        _datasArrayData = [[NSMutableDictionary alloc] init];
    }
    return _datasArrayData;
}

- (NSMutableDictionary *)params {
    
    if (!_params) {
        
        _params = [[NSMutableDictionary alloc] init];
    }
    
    return _params;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
    [self loadNewData];
    
}

- (void) initialization {
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    
    ResumeListRootModel *rootModel = self.data;
    [self.datasArrayData setObject:rootModel.data forKey:@"firstSectionData"];
    [self.datasArrayData setObject:rootModel.data forKey:@"secoudSectionData"];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"简历设置";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = BackGrayColor;
    
    [CVSettingIsDefaultCell registerToTableView:self.tableView];
    [CVSettingIsOpenCell registerToTableView:self.tableView];
    [CVSettingShieldingShopCell registerToTableView:self.tableView];
    self.tableView.tableFooterView = [self creatFooterView];
    
}

- (UIView *) creatFooterView {
    
    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height + SafeAreaBottomHeight)];
    footerView.backgroundColor = BackGrayColor;
    
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 20 *Scale_Height, footerView.width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"添加屏蔽店铺"
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
    
    __weak OADCVSettingViewController *weakSelf = self;
    OADAddShieldingShopViewController *viewController = [OADAddShieldingShopViewController new];
    viewController.addSuccess = ^(BOOL addSuccess) {
        
        if (addSuccess) {
            
            [weakSelf loadNewData];
            
        }
        
    };
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void) loadNewData {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [CVSettingViewModel requestPost_getExceptShopNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        NSArray *dataArray = info[@"data"];
        
        [self.datasArrayData removeObjectForKey:@"thirdSectionData"];
        
        if (dataArray.count > 0) {
            
            [self.datasArrayData setObject:dataArray forKey:@"thirdSectionData"];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [self.datasArrayData removeObjectForKey:@"thirdSectionData"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
            
        });
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

#pragma mark - TableViewDelegate
//设置头分区
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return [self createSectionHeaderViewWithTitle:@"设置默认简历" content:@"开启后默认快速投递该简历"];
        
    } else if (section == 1) {
        
        return [self createSectionHeaderViewWithTitle:@"设置公开程度" content:@""];
        
    } else {
        
        return [self createSectionHeaderViewWithTitle:@"不希望以下店铺看到我" content:@""];
        
    }
    
}

- (UIView *) createSectionHeaderViewWithTitle:(NSString *)title content:(NSString *)content {
    
    UIView *backView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 60 *Scale_Height)];
    backView.backgroundColor = BackGrayColor;
    
    UIView *contentView         = [[UIView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Height, Screen_Width, 50 *Scale_Height)];
    contentView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:contentView];
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, (contentView.height - 20 *Scale_Height) / 2, 200 *Scale_Width, 20 *Scale_Height)
                                              labelType:kLabelNormal
                                                   text:title
                                                   font:UIFont_16
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [contentView addSubview:titleLabel];
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(15 *Scale_Width, (contentView.height - 20 *Scale_Height) / 2, titleLabel.width, 20 *Scale_Height);
    
    UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(titleLabel.x + titleLabel.width + 10 *Scale_Width, (contentView.height - 20 *Scale_Height) / 2, contentView.width - (titleLabel.x + titleLabel.width + 25 *Scale_Width), 20 *Scale_Height)
                                              labelType:kLabelNormal
                                                   text:content
                                                   font:UIFont_15
                                              textColor:TextGrayColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [contentView addSubview:contentLabel];
    
    UIView *h_lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, contentView.height - 0.7f, contentView.width, 0.7f)];
    h_lineView.backgroundColor = LineColor;
    [contentView addSubview:h_lineView];
    
    return backView;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60 *Scale_Height;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section == 0) {

        NSArray *dataArray = self.datasArrayData[@"firstSectionData"];
        return dataArray.count;
        
    } else if (section == 1) {
        
        NSArray *dataArray = self.datasArrayData[@"secoudSectionData"];
        return dataArray.count;
        
    } else {

        NSArray *dataArray = self.datasArrayData[@"thirdSectionData"];
        return dataArray.count;
        
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45 *Scale_Height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        CVSettingIsDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CVSettingIsDefaultCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.row = indexPath.row;
        cell.delegate = self;
        NSArray *dataArray = self.datasArrayData[@"firstSectionData"];
        if (dataArray.count > 0) {
            
            cell.data = dataArray[indexPath.row];
            [cell loadContent];
            
        }
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        CVSettingIsOpenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CVSettingIsOpenCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.row = indexPath.row;
        cell.delegate = self;
        NSArray *dataArray = self.datasArrayData[@"secoudSectionData"];
        if (dataArray.count > 0) {
            
            cell.data = dataArray[indexPath.row];
            [cell loadContent];
            
        }
        
        return cell;
        
    } else {
        
        CVSettingShieldingShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CVSettingShieldingShopCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.row = indexPath.row;
        cell.delegate = self;
        NSArray *dataArray = self.datasArrayData[@"thirdSectionData"];
        if (dataArray.count > 0) {
            
            cell.data = dataArray[indexPath.row];
            [cell loadContent];
            
        }
        
        return cell;
        
    }
    
}

#pragma mark - CVSettingIsDefaultCellDelegate
- (void) clickSetDefaultCVWithData:(id)data; {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    ResumeListData *model = data;
    [params setObject:model.CVId forKey:@"CVId"];
    
    [CVSettingViewModel requestPost_setCVDefaulNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        NSMutableArray *tmpDataArray = [NSMutableArray array];
        NSArray        *dataArray = self.datasArrayData[@"firstSectionData"];
        for (int i = 0;i < dataArray.count; i++) {
            
            ResumeListData *tmpModel = dataArray[i];
            
            if ([model.CVId integerValue] == [tmpModel.CVId integerValue]) {
                
                tmpModel.isDefault = @"1";
                
                OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
                accountInfo.default_cv_id   = model.CVId;
                [OADSaveAccountInfoTool saveAccountInfo:accountInfo];
                
            } else {
                
                tmpModel.isDefault = @"0";
                
            }
            
            [tmpDataArray addObject:tmpModel];
            
        }
        
        [self.datasArrayData setObject:tmpDataArray forKey:@"firstSectionData"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
            [MBProgressHUD showMessageTitle:@"设置成功" toView:self.view afterDelay:1.5f];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

#pragma mark - CVSettingIsOpenCellDelegate
- (void) clickSetOpenCVWithData:(id)data; {
    
    __weak OADCVSettingViewController *weakSelf = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"设置简历公开程度" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"公开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        isOpen = 1;
        [weakSelf setCVIsOpenWithData:data];
        
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        isOpen = 0;
        [weakSelf setCVIsOpenWithData:data];
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void) setCVIsOpenWithData:(id)data {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    ResumeListData *model     = data;
    [params setObject:model.CVId forKey:@"CVId"];
    
    if (isOpen == 0) {
        
        [params setObject:@"0" forKey:@"isOpen"];
        
    } else {
        
        [params setObject:@"1" forKey:@"isOpen"];
        
    }
    
    [CVSettingViewModel requestPost_setCVOpenNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        NSMutableArray *tmpDataArray = [NSMutableArray array];
        NSArray        *dataArray = self.datasArrayData[@"secoudSectionData"];
        for (int i = 0;i < dataArray.count; i++) {
            
            ResumeListData *tmpModel = dataArray[i];
            
            if ([model.CVId integerValue] == [tmpModel.CVId integerValue]) {
                
                if (isOpen == 0) {
                    
                    tmpModel.isOpen = @"0";
                    
                } else {
                    
                    tmpModel.isOpen = @"1";
                    
                }
                
            }
            
            [tmpDataArray addObject:tmpModel];
            
        }
        
        [self.datasArrayData setObject:tmpDataArray forKey:@"secoudSectionData"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
            [MBProgressHUD showMessageTitle:@"设置成功" toView:self.view afterDelay:1.5f];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

#pragma mark - CVSettingShieldingShopCellDelegate
- (void) clickDeleteShieldingShopWithData:(id)data; {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    NSDictionary   *model     = data;
    [params setObject:model[@"shopId"] forKey:@"shopId"];
    
    [CVSettingViewModel requestPost_cancelExceptShopNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:@"取消屏蔽店铺成功" toView:self.view afterDelay:1.f];
            int64_t delayInSeconds = 1.2f;      // 延迟的时间
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [self loadNewData];
                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
