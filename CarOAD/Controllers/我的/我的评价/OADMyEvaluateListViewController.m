//
//  OADMyEvaluateListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMyEvaluateListViewController.h"

#import "MyEvaluateListRootModel.h"
#import "MyEvaluateListViewModel.h"

#import "MyEvaluateListCell.h"

#import "OADMYSkillDetailesViewController.h"
#import "OADMyOrderDetailsViewController.h"

@interface OADMyEvaluateListViewController ()<UITableViewDelegate, UITableViewDataSource, CustomAdapterTypeTableViewCellDelegate, NormalTabsViewDelegate>
{
    
    NSInteger PageNo;
    
}
@property (nonatomic, strong) MyEvaluateListRootModel *rootModel;
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation OADMyEvaluateListViewController

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

- (void) viewWillDisappear:(BOOL)animated {
    
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
    [self.params setObject:@"1" forKey:@"commentType"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"来自商家的评价";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    NormalTabsView *tabsView = [[NormalTabsView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    tabsView.buttonTitleArray = @[@"技能服务的评价",@"技术需求的评论"];
    [tabsView buildsubview];
    tabsView.delegate = self;
    [self.contentView addSubview:tabsView];

    self.tableView.frame = CGRectMake(0, tabsView.y + tabsView.height, Screen_Width, self.contentView.height - (tabsView.y + tabsView.height));
    
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
    
    [MyEvaluateListCell registerToTableView:self.tableView];
    
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
    
    [MyEvaluateListViewModel requestPost_getAllCommentListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        CarOadLog(@"info --- %@",info);
        
        //  获取用户数据
        MyEvaluateListRootModel *rootModel = [[MyEvaluateListRootModel alloc] initWithDictionary:info];
        
        self.rootModel = rootModel;
        
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSMutableArray *dataArray  = [[NSMutableArray alloc] init];
        
        if (self.adapters.count > 0) {
            
            for (TableViewCellDataAdapter *adapter in self.adapters) {
                
                MyEvaluateListCommentList *newModel = adapter.data;
                [dataArray addObject:newModel];
                
            }
            
        }
        
        if (PageNo == 1) {
            
            [dataArray removeAllObjects];
            
        }
        
        if (rootModel.commentList.count > 0) {
            
            for (MyEvaluateListCommentList *tmpData in rootModel.commentList) {
                
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
                    
                    MyEvaluateListCommentList *model = dataArray[i];
                    
                    [MyEvaluateListCell cellHeightWithData:model];
                    TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"MyEvaluateListCell"
                                                                                                                    data:model
                                                                                                              cellHeight:model.normalStringHeight
                                                                                                                cellType:kMyEvaluateListCellNormalType];
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
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    backView.backgroundColor = [UIColor whiteColor];
    
    MyEvaluateListData *data = self.rootModel.data[0];
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:@"全部评论（0）"
                                                   font:UIFont_15
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [backView addSubview:titleLabel];
    
    if (data.commentCount.length > 0) {
        
        titleLabel.text = [NSString stringWithFormat:@"全部评论（%@）",data.commentCount];
        
    } else {
        
        titleLabel.text = @"全部评论（0）";
        
    }
    
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(15 *Scale_Width, 0, titleLabel.width, backView.height);
    
    UILabel *numberLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:@"0"
                                                   font:UIFont_15
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [backView addSubview:numberLabel];
    
    if (data.creditScore.length > 0) {
        
        numberLabel.text = [NSString stringWithFormat:@"%@",data.creditScore];
        
    } else {
        
        numberLabel.text = @"0";
        
    }
    
    [numberLabel sizeToFit];
    numberLabel.frame = CGRectMake(Screen_Width - 20 *Scale_Width - 82 *Scale_Height - numberLabel.width, 0, numberLabel.width, backView.height);
    
    NSString *creditScoreString = [data.creditScore stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSInteger creditScore = [creditScoreString integerValue];
    NSInteger creditScoreX = creditScore / 10;
    NSInteger creditScoreY = creditScore % 10;
    NSMutableArray *imageViewArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *favoriteImageView    = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 15 *Scale_Width - 82 *Scale_Height + 17 *Scale_Height *i, 13 *Scale_Height, 14 *Scale_Height, 14 *Scale_Height)];
        favoriteImageView.image           = [UIImage imageNamed:@"favorite_off_hollow_blue"];
        favoriteImageView.contentMode     = UIViewContentModeScaleAspectFit;
        favoriteImageView.tag             = 300 + i;
        [backView addSubview:favoriteImageView];
        [imageViewArray addObject:favoriteImageView];
    }
    
    if (creditScoreX > 0) {
        
        for (int i = 0; i < creditScoreX; i++) {
            
            UIImageView *imageView = imageViewArray[i];
            imageView.image        = [UIImage imageNamed:@"favorite_off_full_blue"];
            
        }
        
        if (creditScoreY > 0) {
            
            UIImageView *imageView = imageViewArray[creditScoreX];
            imageView.image        = [UIImage imageNamed:@"favorite_off_hollow_full_blue"];
            
        }
        
    } else {
        
        if (creditScoreY > 0) {
            
            UIImageView *imageView = imageViewArray[0];
            imageView.image        = [UIImage imageNamed:@"favorite_off_hollow_full_blue"];
            
        }
        
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height - 0.5f, Screen_Width, 0.5f)];
    lineView.backgroundColor = LineColor;
    [backView addSubview:lineView];
    
    return backView;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40 *Scale_Height;
    
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
    
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        TableViewCellDataAdapter  *adapter  = self.adapters[indexPath.row];
        MyEvaluateListCommentList *newModel = adapter.data;
        
        NSString *type = self.params[@"commentType"];
        
        if ([type integerValue] == 1) {
            
            OADMYSkillDetailesViewController *viewController = [OADMYSkillDetailesViewController new];
            viewController.skillId                           = newModel.projectId;
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else {
            
            OADMyOrderDetailsViewController *viewController = [OADMyOrderDetailsViewController new];
            viewController.demandId                         = newModel.projectId;
            [self.navigationController pushViewController:viewController animated:YES];
            
        }

    }
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
}

#pragma mark - NormalTabsViewDelegate
- (void) clickTabsButtonWithType:(NSInteger)type; {

    [self.params setObject:[NSString stringWithFormat:@"%ld",type + 1] forKey:@"commentType"];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
