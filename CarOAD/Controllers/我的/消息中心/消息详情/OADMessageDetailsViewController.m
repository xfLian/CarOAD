//
//  OADMessageDetailsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/5.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "OADMessageDetailsViewController.h"

#import "MessageDetailsViewModel.h"
#import "MessageDetailsRootModel.h"

#import "MessageDetailsCell.h"

#import "OADMyOrderDetailsViewController.h"
#import "OADMYSkillDetailesViewController.h"
#import "OADMyDeliverDetailsViewController.h"

@interface OADMessageDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, CustomAdapterTypeTableViewCellDelegate, MessageDetailsCellDelegate>

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray <TableViewCellDataAdapter *> *adapters;

@end

@implementation OADMessageDetailsViewController

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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void) initialization {
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    [self.params setObject:self.noticeTypeId forKey:@"noticeTypeId"];
    
    [self steartNetWorking];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"消息详情";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, self.view.height - 64) style:UITableViewStyleGrouped];
    tableView.backgroundColor = BackGrayColor;
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator   = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.tag             = 100;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.contentInset = UIEdgeInsetsMake(10 *Scale_Height, 0, 0, 0);
    
    [MessageDetailsCell registerToTableView:tableView];
    
}

- (void) steartNetWorking {
    
    self.adapters = [NSMutableArray array];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [MessageDetailsViewModel requestPost_getNoticeInfoNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        CarOadLog(@"info --- %@",info);
        
        //  获取用户数据
        MessageDetailsRootModel *rootModel = [[MessageDetailsRootModel alloc] initWithDictionary:info];
        
        if (rootModel.data.count > 0) {
            
            NSMutableArray *indexPaths = [NSMutableArray array];
            
            for (int i = 0; i < rootModel.data.count; i++) {
                
                MessageDetailsData *model = rootModel.data[i];
                [MessageDetailsCell cellHeightWithData:model];
                TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MessageDetailsCell"
                                                                                                                data:model
                                                                                                          cellHeight:model.normalStringHeight
                                                                                                            cellType:0];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                adapter.indexPath      = indexPath;
                [self.adapters addObject:adapter];
                [indexPaths addObject:indexPath];
                
            }
            
        }
        
        int64_t delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self.tableView reloadData];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

#pragma mark - TableViewDelegate
//设置头分区
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView         = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.backgroundColor = [UIColor clearColor];
    
    TableViewCellDataAdapter *adapter = self.adapters[section];
    MessageDetailsData *model = adapter.data;
    
    if (model.lastNoticeDate.length > 0) {
        
        headerView.frame = CGRectMake(0, 0, Screen_Width, 26 *Scale_Height);
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd hh:mm"];
        NSDate *date = [formatter dateFromString:model.lastNoticeDate];
        [formatter setDateFormat:@"MM月dd日 hh:mm"];
        NSString *dateString = [formatter stringFromDate:date];
        
        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@""
                                                       font:UIFont_13
                                                  textColor:[UIColor whiteColor]
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:100];
        [headerView addSubview:titleLabel];
        titleLabel.text = dateString;
        
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake((headerView.width - titleLabel.width - 10 *Scale_Width) / 2, 4 *Scale_Height, titleLabel.width + 10 *Scale_Width, 22 *Scale_Height);
        titleLabel.layer.masksToBounds = YES;
        titleLabel.backgroundColor = CarOadColor(183, 183, 183);
        titleLabel.layer.cornerRadius  = 3 *Scale_Width;
        
        return headerView;
        
    } else {
        
        headerView.frame = CGRectZero;
        
        return nil;
        
    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    TableViewCellDataAdapter *adapter = self.adapters[section];
    MessageDetailsData *model = adapter.data;
    
    if (model.lastNoticeDate.length > 0) {
        
        return 26 *Scale_Height;
        
    } else {
        
        return 0.01;
        
    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
    
}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.adapters.count;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.adapters[indexPath.section].cellHeight;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCellDataAdapter *adapter = self.adapters[indexPath.section];
    MessageDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.tableView           = tableView;
    cell.indexPath           = indexPath;
    cell.delegate            = self;
    cell.cellSubDelegate     = self;
    [cell loadContent];
    
    return cell;
    
}

#pragma mark - MessageDetailsCellDelegate
- (void) clickChankDetailsWithData:(id)data; {
    
    //XT-系统通知 XQ-技术需求通知 JN-技能服务通知 JL-简历投递通知 QT-其他通知
    MessageDetailsData *model = data;
    
    if ([model.noticeTypeId isEqualToString:@"XQ"]) {
        
        OADMyOrderDetailsViewController *viewController = [OADMyOrderDetailsViewController new];
        viewController.demandId      = model.projectId;
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if ([model.noticeTypeId isEqualToString:@"JN"]) {
        
        OADMYSkillDetailesViewController *viewController = [OADMYSkillDetailesViewController new];
        viewController.skillId = model.projectId;
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if ([model.noticeTypeId isEqualToString:@"JL"]) {
        
        OADMyDeliverDetailsViewController *viewController = [OADMyDeliverDetailsViewController new];
        viewController.recruiId           = model.projectId;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

@end
