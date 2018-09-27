//
//  OADOrderMessageListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADOrderMessageListViewController.h"

#import "OrderMessageListRootModel.h"
#import "OrderMessageListViewModel.h"

#import "OrderMessageListCell.h"

@interface OADOrderMessageListViewController ()<UITableViewDelegate, UITableViewDataSource, CustomAdapterTypeTableViewCellDelegate, NormalTabsViewDelegate, OrderMessageListCellDelegate>
{
    
    NSInteger PageNo;
    
}
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray <TableViewCellDataAdapter *> *adapters;

@end

@implementation OADOrderMessageListViewController

- (NSMutableDictionary *)params {
    
    if (!_params) {
        
        _params = [[NSMutableDictionary alloc] init];
    }
    
    return _params;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void) initialization {
    
    self.adapters = [NSMutableArray array];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    [self.params setObject:@"0" forKey:@"skillOrderState"];
    [self.params setObject:self.skillId forKey:@"skillId"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"接单留言";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];

    NormalTabsView *tabsView = [[NormalTabsView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    tabsView.buttonTitleArray = @[@"全部",@"待处理",@"不合适",@"已成交"];
    [tabsView buildsubview];
    tabsView.delegate = self;
    [self.contentView addSubview:tabsView];
    
    self.tableView.frame = CGRectMake(0, tabsView.y + tabsView.height, Screen_Width, self.contentView.height - (tabsView.y + tabsView.height));
    self.tableView.backgroundColor = BackGrayColor;
    [OrderMessageListCell registerToTableView:self.tableView];
    
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
    
    [OrderMessageListViewModel requestPost_getSkillOrderListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        //  获取用户数据
        OrderMessageListRootModel *rootModel = [[OrderMessageListRootModel alloc] initWithDictionary:info];
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSMutableArray *dataArray  = [[NSMutableArray alloc] init];
        
        if (self.adapters.count > 0) {
            
            for (TableViewCellDataAdapter *adapter in self.adapters) {
                
                OrderMessageListData *newModel = adapter.data;
                [dataArray addObject:newModel];
                
            }
            
        }
        
        if (PageNo == 1) {
            
            [dataArray removeAllObjects];
            
        }
        
        if (rootModel.data.count > 0) {
            
            for (OrderMessageListData *tmpData in rootModel.data) {
                
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
                
                for (int i = 0; i < dataArray.count; i++) {
                    
                    OrderMessageListData *model = dataArray[i];
                    
                    [OrderMessageListCell cellHeightWithData:model];
                    TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"OrderMessageListCell"
                                                                                                                    data:model
                                                                                                              cellHeight:model.normalStringHeight
                                                                                                                cellType:kOrderMessageListCellNormalType];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    adapter.indexPath      = indexPath;
                    [self.adapters addObject:adapter];
                    [indexPaths addObject:indexPath];
                    
                }
                
                [self.tableView reloadData];
                
            } else {
                
                [MBProgressHUD showMessageTitle:@"没有更多数据了" toView:self.view afterDelay:1.f];
                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                
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
    
    
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
}

#pragma mark - OrderMessageListCellDelegate
- (void) clickCellButtonWithType:(NSInteger)type data:(id)data; {
    
    if (type == 0) {
        
        OrderMessageListData *model = data;
        
        if (model.shopPhone.length > 0) {
            
            NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",model.shopPhone]; //number为号码字
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"暂无联系电话" toView:self.view afterDelay:1.f];
            
        }
        
    } else if (type == 1 || type == 2) {
        
        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
        OrderMessageListData *model = data;
        NSDictionary *params = @{@"userId" : accountInfo.user_id,
                                 @"skillState" : [NSString stringWithFormat:@"%ld",type + 1],
                                 @"skillOrderId" : model.skillOrderId
                                 };
        
        __weak OADOrderMessageListViewController *weakSelf = self;
        [MBProgressHUD showMessage:nil toView:self.view];
        [OrderMessageListViewModel requestPost_modifySkillOrderNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [MBProgressHUD showMessageTitle:@"处理成功" toView:self.view afterDelay:1.f];
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
        
    }
    
}

#pragma mark - NormalTabsViewDelegate
- (void) clickTabsButtonWithType:(NSInteger)type; {
    
    CarOadLog(@"%ld",type);
    
    [self.params setObject:[NSString stringWithFormat:@"%ld",type] forKey:@"skillOrderState"];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
