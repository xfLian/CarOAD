//
//  OADMyOrderListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMyOrderListViewController.h"

#import "MyOrderListRootModel.h"
#import "MyOrderListViewModel.h"

#import "MyOrderListCell.h"

#import "OADMyOrderDetailsViewController.h"

@interface OADMyOrderListViewController ()<CustomAdapterTypeTableViewCellDelegate, NormalTabsViewDelegate>
{
    
    NSInteger PageNo;
    
}

@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OADMyOrderListViewController

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

    [self createTimer];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void) initialization {
    
    self.adapters = [NSMutableArray array];

    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    [self.params setObject:@"0"  forKey:@"demandOrderState"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"我的接单";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    NormalTabsView *tabsView = [[NormalTabsView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    tabsView.buttonTitleArray = @[@"全部",@"接单中",@"不合适",@"有意向",@"已成交"];
    [tabsView buildsubview];
    tabsView.delegate = self;
    [self.contentView addSubview:tabsView];
    
    self.tableView.frame = CGRectMake(0, tabsView.y + tabsView.height, Screen_Width, self.contentView.height - (tabsView.y + tabsView.height));
    self.tableView.backgroundColor = BackGrayColor;
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
    
    [MyOrderListCell registerToTableView:self.tableView];
    
}

- (void) loadNewData {
    
    PageNo = 1;
    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    
    [self steartNetWorking];
    
}

- (void) loadMoreData {
    
    PageNo ++;
    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    
    [self steartNetWorking];
    
}

- (void) steartNetWorking {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [MyOrderListViewModel requestPost_getDemandOrderListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        //  获取用户数据
        MyOrderListRootModel *rootModel = [[MyOrderListRootModel alloc] initWithDictionary:info];
        NSMutableArray *dataArray  = [[NSMutableArray alloc] init];
        
        if (self.adapters.count > 0) {
            
            for (TableViewCellDataAdapter *adapter in self.adapters) {
                
                MyOrderListData *newModel = adapter.data;
                [dataArray addObject:newModel];
                
            }
            
        }
        
        if (PageNo == 1) {
            
            [dataArray removeAllObjects];
            
        }
        
        if (rootModel.data.count > 0) {
            
            for (MyOrderListData *tmpData in rootModel.data) {
                
                [dataArray addObject:tmpData];
                
            }
            
        }
        
        int64_t delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.adapters = [NSMutableArray array];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
                
            if (dataArray.count > 0) {
                
                NSMutableArray *indexPaths = [NSMutableArray array];
                for (int i = 0; i < dataArray.count; i++) {
                    
                    MyOrderListData *model = dataArray[i];
                    MyOrderListData *newModel = [model timeModelWithData:model];
                    
                    TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MyOrderListCell"
                                                                                                                    data:newModel
                                                                                                              cellHeight:115 *Scale_Height
                                                                                                                cellType:0];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    adapter.indexPath      = indexPath;
                    [self.adapters addObject:adapter];
                    [indexPaths addObject:indexPath];
                    
                }
                
                [self.tableView reloadData];
                
            } else {
                
                [MBProgressHUD showMessageTitle:@"没有更多数据了" toView:self.view afterDelay:1.f];
                
            }

            
        });
        
    } error:^(NSString *errorMessage) {
        
        if (PageNo == 1) {
            
            [self.adapters removeAllObjects];
            [self.tableView reloadData];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        self.tableView.mj_footer.hidden = YES;
        
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCellDataAdapter *adapter = self.adapters[indexPath.row];
    MyOrderListData *newModel = adapter.data;
    
    OADMyOrderDetailsViewController *viewController = [OADMyOrderDetailsViewController new];
    viewController.demandId      = newModel.demandId;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
}

#pragma mark - TimerEvent
- (void)createTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    for (int count = 0; count < self.adapters.count; count++) {
        
        TableViewCellDataAdapter *adapter = self.adapters[count];
        MyOrderListData          *model   = adapter.data;
        
        [model countDown];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCountDownTimeCell object:nil];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyOrderListCell *tmpCell = (MyOrderListCell *)cell;
    tmpCell.display     = YES;
    [tmpCell loadTimeContent];
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    CustomAdapterTypeTableViewCell *tmpCell = (CustomAdapterTypeTableViewCell *)cell;
    tmpCell.display     = NO;
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak OADMyOrderListViewController *weakSelf = self;
    
    [tableView setEditing:NO animated:YES];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除该消息？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            TableViewCellDataAdapter *adapter = weakSelf.adapters[indexPath.row];
            MyOrderListData          *tmpData = adapter.data;
            OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
            NSDictionary *params = @{@"demandOrderId" : tmpData.demandId,
                                     @"userId" : accountInfo.user_id};
            [MyOrderListViewModel requestPost_cancelDemandOrderNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"删除成功" toView:self.view afterDelay:1.f];
                int64_t delayInSeconds = 1.2f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    
                    [weakSelf loadNewData];
                    
                });
                
            } error:^(NSString *errorMessage) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
                
            } failure:^(NSError *error) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
                
            }];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

#pragma mark - NormalTabsViewDelegate
- (void) clickTabsButtonWithType:(NSInteger)type; {
    
    [self.params setObject:[NSString stringWithFormat:@"%ld",type] forKey:@"demandOrderState"];
    [self.tableView.mj_header beginRefreshing];
    
}

@end
