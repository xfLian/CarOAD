//
//  OADMessageListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/5.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "OADMessageListViewController.h"

#import "MessageListRootModel.h"
#import "MessageListViewModel.h"

#import "MessageListCell.h"

#import "OADMessageDetailsViewController.h"

@interface OADMessageListViewController ()<UITableViewDelegate, UITableViewDataSource, CustomAdapterTypeTableViewCellDelegate>

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray <TableViewCellDataAdapter *> *adapters;

@end

@implementation OADMessageListViewController

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
    
    [self steartNetWorking];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"消息";
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
    
    [MessageListCell registerToTableView:tableView];
    
}

- (void) steartNetWorking {
    
    self.adapters = [NSMutableArray array];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [MessageListViewModel requestPost_getNoticeListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        //  获取用户数据
        MessageListRootModel *rootModel = [[MessageListRootModel alloc] initWithDictionary:info];

        if (rootModel.data.count > 0) {
            
            NSMutableArray *indexPaths = [NSMutableArray array];
            
            for (int i = 0; i < rootModel.data.count; i++) {
                
                MessageListData *model = rootModel.data[i];
                
                if (i == rootModel.data.count - 1) {
                    
                    model.isShowLineView = NO;
                    
                } else {
                    
                    model.isShowLineView = YES;
                    
                }
                
                TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MessageListCell"
                                                                                                                data:model
                                                                                                          cellHeight:74 *Scale_Height
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
    
    return nil;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
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
    
    TableViewCellDataAdapter *adapter = self.adapters[indexPath.row];
    MessageListData *model = adapter.data;
    OADMessageDetailsViewController *viewController = [OADMessageDetailsViewController new];
    viewController.noticeTypeId = model.noticeTypeId;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
