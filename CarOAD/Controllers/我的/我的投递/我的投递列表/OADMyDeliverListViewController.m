//
//  OADMyDeliverListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMyDeliverListViewController.h"

#import "MyDeliverListRootModel.h"
#import "MyDeliverListViewModel.h"

#import "MyDeliverListCell.h"

#import "OADMyDeliverDetailsViewController.h"

@interface OADMyDeliverListViewController ()<CustomAdapterTypeTableViewCellDelegate, NormalTabsViewDelegate>
{
    
    NSInteger PageNo;
    
}
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation OADMyDeliverListViewController

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
    
    [self.tableView.mj_header beginRefreshing];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void) initialization {
    
    self.adapters = [NSMutableArray array];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    [self.params setObject:@"0"  forKey:@"status"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"我的投递";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    NormalTabsView *tabsView = [[NormalTabsView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    tabsView.buttonTitleArray = @[@"全部",@"被查看",@"不合适"];
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
    
    [MyDeliverListCell registerToTableView:self.tableView];
    
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
    
    [MyDeliverListViewModel requestPost_getSendCVNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        //  获取用户数据
        MyDeliverListRootModel *rootModel = [[MyDeliverListRootModel alloc] initWithDictionary:info];
        NSMutableArray *dataArray  = [[NSMutableArray alloc] init];
        
        if (self.adapters.count > 0) {
            
            for (TableViewCellDataAdapter *adapter in self.adapters) {
                
                MyDeliverListData *newModel = adapter.data;
                [dataArray addObject:newModel];
                
            }
            
        }
        
        if (PageNo == 1) {
            
            [dataArray removeAllObjects];
            
        }
        
        if (rootModel.data.count > 0) {
            
            for (MyDeliverListData *tmpData in rootModel.data) {
                
                [dataArray addObject:tmpData];
                
            }
            
        }
        
        int64_t delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.adapters = [NSMutableArray array];
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            if (dataArray.count > 0) {
                
                NSMutableArray *indexPaths = [NSMutableArray array];
                for (int i = 0; i < dataArray.count; i++) {
                    
                    MyDeliverListData *model = dataArray[i];
                    
                    TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MyDeliverListCell"
                                                                                                                    data:model
                                                                                                              cellHeight:110 *Scale_Height
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
    MyDeliverListData *model          = adapter.data;
    OADMyDeliverDetailsViewController *viewController = [OADMyDeliverDetailsViewController new];
    viewController.recruiId           = model.recruitId;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
}

#pragma mark - NormalTabsViewDelegate
- (void) clickTabsButtonWithType:(NSInteger)type; {
    
    [self.params setObject:[NSString stringWithFormat:@"%ld",type] forKey:@"status"];
    [self.tableView.mj_header beginRefreshing];
    
}

@end
