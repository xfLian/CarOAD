//
//  OADMySkillCommentListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMySkillCommentListViewController.h"

#import "MySkillCommentListRootModel.h"
#import "MYSkillDetailesViewModel.h"
#import "MYSkillListViewModel.h"

#import "MySkillDetailsCommentListCell.h"

@interface OADMySkillCommentListViewController ()<CustomAdapterTypeTableViewCellDelegate>
{
    
    NSInteger PageNo;
    
}
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation OADMySkillCommentListViewController

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
    
    [self.params setObject:self.skillId forKey:@"skillId"];
    [self.params setObject:@"15" forKey:@"pageStep"];

}

- (void)setNavigationController {
    
    self.navTitle     = @"全部评价";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];

    self.tableView.backgroundColor = BackGrayColor;
    [MySkillDetailsCommentListCell registerToTableView:self.tableView];

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

    [MYSkillDetailesViewModel requestPost_getCommentListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        //  获取用户数据
        MySkillCommentListRootModel *rootModel = [[MySkillCommentListRootModel alloc] initWithDictionary:info];
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSMutableArray *dataArray  = [[NSMutableArray alloc] init];
        
        if (self.adapters.count > 0) {
            
            for (TableViewCellDataAdapter *adapter in self.adapters) {
                
                MYSkillDetailesOrderMsgList *newModel = adapter.data;
                [dataArray addObject:newModel];
                
            }
            
        }
        
        if (PageNo == 1) {
            
            [dataArray removeAllObjects];
            
        }
        
        if (rootModel.orderMsgList.count > 0) {
            
            for (MYSkillDetailesOrderMsgList *tmpData in rootModel.orderMsgList) {
                
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
                    
                    MYSkillDetailesOrderMsgList *model = dataArray[i];
                    
                    [MySkillDetailsCommentListCell cellHeightWithData:model];
                    TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MySkillDetailsCommentListCell"
                                                                                                                    data:model
                                                                                                              cellHeight:model.normalStringHeight
                                                                                                                cellType:kMySkillDetailsCommentListCellNormalType];
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
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
