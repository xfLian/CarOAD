//
//  OADAdvertiseViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAdvertiseViewController.h"

#import "AdvertiseMainSubView.h"
#import "AdvertiseChooseTypeView.h"
#import "SearchRecruitListView.h"

//  请求服务器方法类
#import "HomePageViewModel.h"
#import "HomePageAdvertiseInfomationCell.h"
#import "RecruitListRootModel.h"

#import "OADMyDeliverDetailsViewController.h"

@interface OADAdvertiseViewController ()<AdvertiseMainSubViewDelegate, AdvertiseChooseTypeViewDelegate, SearchRecruitListViewDelegate, UITableViewDelegate, UITableViewDataSource>
{

    NSInteger PageNo;
    NSDictionary *needDataDic;
    NSDictionary *selectedProvinceData;
    NSDictionary *selectedCityData;
    NSDictionary *selectedAreaData;

}
@property (nonatomic, strong) AdvertiseMainSubView    *chooseButtonView;
@property (nonatomic, strong) AdvertiseChooseTypeView *advertiseChooseTypeView;
@property (nonatomic, strong) SearchRecruitListView   *searchRecruitListView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *datasArray;

@end

@implementation OADAdvertiseViewController

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

- (SearchRecruitListView *)searchRecruitListView {

    if (!_searchRecruitListView) {

        _searchRecruitListView          = [[SearchRecruitListView alloc] init];
        _searchRecruitListView.delegate = self;

    }

    return _searchRecruitListView;

}

- (AdvertiseChooseTypeView *)advertiseChooseTypeView {

    if (!_advertiseChooseTypeView) {

        _advertiseChooseTypeView = [[AdvertiseChooseTypeView alloc] initWithFrame:CGRectMake(0, self.chooseButtonView.y + self.chooseButtonView.height, Screen_Width, self.contentView.height - (self.chooseButtonView.y + self.chooseButtonView.height))];
        _advertiseChooseTypeView.delegate = self;
        [self.contentView addSubview:_advertiseChooseTypeView];
        
    }

    return _advertiseChooseTypeView;

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    if (self.isHomePagePush == YES) {
        
        self.tabBarController.tabBar.hidden = YES;
        
        CGRect frame = self.tableView.frame;
       frame.size.height += (49 + SafeAreaBottomHeight);
        self.tableView.frame = frame;
        
    }

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];


}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialization];

    [self.tableView.mj_header beginRefreshing];

}

- (void) initialization {

    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@""   forKey:@"skillPost"];
    [self.params setObject:@"0"  forKey:@"provinceId"];
    [self.params setObject:@"0"  forKey:@"cityId"];
    [self.params setObject:@"0"  forKey:@"areaId"];
    [self.params setObject:@"1"  forKey:@"salaryRangeId"];
    [self.params setObject:@"1"  forKey:@"workExpId"];
    [self.params setObject:@"1"  forKey:@"workTypeId"];
    [self.params setObject:@"1"  forKey:@"workNatureId"];
    [self.params setObject:@"0"  forKey:@"sortDate"];

}

- (void)setNavigationController {
    
    if (self.isHomePagePush == YES) {
        
        self.leftItemText = @"返回";
        
    }

    [super setNavigationController];

    self.navigationItem.title = @"招聘信息";

    UIButton *rightNavButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavButton.frame           = CGRectMake(0, 0, 44, 44);
    UIImage *ima                   = [UIImage imageNamed:@"Search_white"];
    rightNavButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [rightNavButton setImage:ima forState:UIControlStateNormal];
    [rightNavButton addTarget:self
                       action:@selector(clickRightItem)
             forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightNavButton];
    self.navigationItem.rightBarButtonItem = item;

}

- (void) clickRightItem {

    [self.advertiseChooseTypeView hide];
    [self.chooseButtonView loadUI];
    [self.searchRecruitListView show];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaBottomHeight - SafeAreaTopHeight - 49);
    
    AdvertiseMainSubView *chooseButtonView = [[AdvertiseMainSubView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    chooseButtonView.buttonTitleArray      = @[@"区域",@"要求",@"时间"];
    [chooseButtonView buildsubview];
    chooseButtonView.delegate              = self;
    [self.contentView addSubview:chooseButtonView];
    self.chooseButtonView = chooseButtonView;

    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, chooseButtonView.y + chooseButtonView.height, Screen_Width, self.contentView.height - (chooseButtonView.y + chooseButtonView.height)) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.tag             = 100;
    [self.contentView addSubview:tableView];
    self.tableView = tableView;

    [tableView registerClass:[HomePageAdvertiseInfomationCell class] forCellReuseIdentifier:@"HomePageAdvertiseInfomationCell"];

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

/**
 *  加载新数据
 */
- (void) loadNewData {

    PageNo = 1;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];

    [self startNetworking];

}

/**
 *  发送请求加载更多的微博数据
 */
- (void) loadMoreData {

    PageNo ++;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];

    [self startNetworking];

}

- (void) startNetworking {

    [HomePageViewModel requestPost_getHomePageRecruitListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

        [self requestSucessWithData:info];

    } error:^(NSString *errorMessage) {
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        if (self.datasArray.count > 0) {
            
            for (RecruitListData *model in self.datasArray) {
                
                [dataArray addObject:model];
                
            }
            
        }
        
        if (PageNo == 1) {
            
            [dataArray removeAllObjects];
            
            self.datasArray = [dataArray mutableCopy];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];

            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
            if (self.datasArray.count < 15) {
                
                self.tableView.mj_footer.hidden = YES;
                
            } else {
                
                self.tableView.mj_footer.hidden = NO;
                
            }
            
        });
        
    } failure:^(NSError *error) {
        
        [self requestFailedWithError:error];
        
    }];
    
}

- (void) requestSucessWithData:(id)data; {
    
    RecruitListRootModel *rootModel = [[RecruitListRootModel alloc] initWithDictionary:data];
    
    if ([rootModel.result integerValue] == 1) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            if (self.datasArray.count > 0) {
                
                for (RecruitListData *model in self.datasArray) {
                    
                    [dataArray addObject:model];
                    
                }
                
            }
            
            if (PageNo == 1) {
                
                [dataArray removeAllObjects];
                
            }
            
            if (rootModel.data.count > 0) {
                
                for (RecruitListData *tmpData in rootModel.data) {
                    
                    tmpData.isShowPublicDate = YES;
                    [dataArray addObject:tmpData];
                    
                }
                
            }
            
            self.datasArray = [dataArray mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                if (self.datasArray.count > 0) {
                    
                    [self.tableView reloadData];
                    
                } else {
                    
                    if (PageNo == 1) {
                        
                        [MBProgressHUD showMessageTitle:@"数据为空" toView:self.view afterDelay:1.f];
                        
                        [self.tableView reloadData];
                        
                    }
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }
                
                if (self.datasArray.count < 15) {
                    
                    self.tableView.mj_footer.hidden = YES;
                    
                } else {
                    
                    self.tableView.mj_footer.hidden = NO;
                    
                }
                
                
            });
            
        });
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = YES;
            
        });
        
    }
    
}

- (void) requestFailedWithError:(NSError *)error; {
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    
    [MBProgressHUD showMessageTitle:@"连接服务器失败！"];
    
}

#pragma mark - UITableViewDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
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
    
    return 110 *Scale_Height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomePageAdvertiseInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageAdvertiseInfomationCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.datasArray.count > 0) {
        
        cell.data = self.datasArray[indexPath.section];
        [cell loadContent];
        
    }
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        RecruitListData *model = self.datasArray[indexPath.section];
        OADMyDeliverDetailsViewController *viewController = [OADMyDeliverDetailsViewController new];
        viewController.recruiId = model.recruitId;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

#pragma mark - AdvertiseMainSubViewDelegate
- (void) clickHideChooseTypeView; {
    
    [self.advertiseChooseTypeView hide];
    
}

- (void) clickchooseButtonWithType:(NSInteger)type; {
    
    [self.advertiseChooseTypeView show];
    
    if (type == 0) {
        
        NSMutableDictionary *contentDic = [NSMutableDictionary new];
        
        if (selectedProvinceData && selectedCityData && selectedAreaData) {
            
            [contentDic setObject:selectedProvinceData forKey:@"selectedProvince"];
            [contentDic setObject:selectedCityData     forKey:@"selectedCity"];
            [contentDic setObject:selectedAreaData     forKey:@"selectedArea"];
            
        }
        
        [self.advertiseChooseTypeView showContentViewWithType:area_view contentDic:contentDic];
        
    } else if (type == 1) {
        
        [self.advertiseChooseTypeView showContentViewWithType:need_infomation_view contentDic:needDataDic];
        
    } else if (type == 2) {
        
        [self.advertiseChooseTypeView showContentViewWithType:time_limit_view contentDic:nil];
        
    }
    
}

#pragma mark - AdvertiseChooseTypeViewDelegate
- (void) hideChooseTypeView; {
    
    [self.chooseButtonView loadUI];
    
}

- (void) choosedProvinceData:(NSDictionary *)provinceData
                    cityData:(NSDictionary *)cityData
                    areaData:(NSDictionary *)areaData; {
    
    selectedProvinceData = provinceData;
    selectedCityData     = cityData;
    selectedAreaData     = areaData;
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.datasArray           = [dataArray mutableCopy];
    
    NSMutableArray *buttonTitleArray = [NSMutableArray new];
    buttonTitleArray                 = [self.chooseButtonView.buttonTitleArray mutableCopy];
    NSString *areaString = areaData[@"area"];
    
    [buttonTitleArray replaceObjectAtIndex:0 withObject:areaString];
    
    self.chooseButtonView.buttonTitleArray = [buttonTitleArray copy];
    [self.chooseButtonView loadUI];
    
    NSString *provinceId = provinceData[@"provinceid"];
    NSString *cityId     = cityData[@"cityid"];
    NSString *areaId     = areaData[@"areaId"];
    
    if (provinceId.length > 0 && cityId.length > 0 && areaId.length > 0) {
        
        [self.params setObject:@""         forKey:@"skillPost"];
        [self.params setObject:provinceId  forKey:@"provinceId"];
        [self.params setObject:cityId      forKey:@"cityId"];
        [self.params setObject:areaId      forKey:@"areaId"];
        
        [self.tableView.mj_header beginRefreshing];
        
    }
    
}

- (void) selectedSalaryData:(NSArray *)salaryDataArray
              timeLimitData:(NSArray *)timeLimitDataArray
             occupationData:(NSArray *)occupationDataArray
                jobTypeData:(NSArray *)jobTypeDataArray;  {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.datasArray           = [dataArray mutableCopy];
    [self.chooseButtonView loadUI];
    
    needDataDic = @{@"salary":salaryDataArray,
                    @"timeLimit":timeLimitDataArray,
                    @"occupation":occupationDataArray,
                    @"jobType":jobTypeDataArray};
    
    NSString *salaryRangeIdString = nil;
    NSString *workExpIdString     = nil;
    NSString *workTypeIdString    = nil;
    NSString *workNatureIdString  = nil;
    
    if (salaryDataArray.count > 0) {
        
        for (int i = 0; i < salaryDataArray.count; i++) {
            
            NSDictionary *model = salaryDataArray[i];
            
            if (i == 0) {
                
                salaryRangeIdString = model[@"titleId"];
                
            } else {
                
                salaryRangeIdString = [NSString stringWithFormat:@"%@,%@",salaryRangeIdString,model[@"titleId"]];
                
            }
            
        }
        
    }
    
    if (timeLimitDataArray.count > 0) {
        
        for (int i = 0; i < timeLimitDataArray.count; i++) {
            
            NSDictionary *model = timeLimitDataArray[i];
            
            if (i == 0) {
                
                workExpIdString = model[@"titleId"];
                
            } else {
                
                workExpIdString = [NSString stringWithFormat:@"%@,%@",workExpIdString,model[@"titleId"]];
                
            }
            
        }
        
    }
    
    if (occupationDataArray.count > 0) {
        
        for (int i = 0; i < occupationDataArray.count; i++) {
            
            NSDictionary *model = occupationDataArray[i];
            
            if (i == 0) {
                
                workTypeIdString = model[@"titleId"];
                
            } else {
                
                workTypeIdString = [NSString stringWithFormat:@"%@,%@",workTypeIdString,model[@"titleId"]];
                
            }
            
        }
        
    }
    
    if (jobTypeDataArray.count > 0) {
        
        for (int i = 0; i < jobTypeDataArray.count; i++) {
            
            NSDictionary *model = jobTypeDataArray[i];
            
            if (i == 0) {
                
                workNatureIdString = model[@"titleId"];
                
            } else {
                
                workNatureIdString = [NSString stringWithFormat:@"%@,%@",workNatureIdString,model[@"titleId"]];
                
            }
            
        }
        
    }
    
    if (salaryRangeIdString.length > 0 && workExpIdString.length > 0 && workTypeIdString.length > 0 && workNatureIdString.length > 0) {
        
        [self.params setObject:@""                  forKey:@"skillPost"];
        [self.params setObject:salaryRangeIdString  forKey:@"salaryRangeId"];
        [self.params setObject:workExpIdString      forKey:@"workExpId"];
        [self.params setObject:workTypeIdString     forKey:@"workTypeId"];
        [self.params setObject:workNatureIdString   forKey:@"workNatureId"];
        
        [self.tableView.mj_header beginRefreshing];
        
    }
    
}

- (void) selectedTimeLimitData:(NSDictionary *)timeLimitData; {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.datasArray           = [dataArray mutableCopy];
    NSString *titleId = timeLimitData[@"titleId"];
    
    if (titleId.length > 0) {
        
        [self.chooseButtonView loadUI];
        
        [self.params setObject:@""     forKey:@"skillPost"];
        [self.params setObject:titleId forKey:@"sortDate"];
        [self.tableView.mj_header beginRefreshing];
        
    }
    
}

#pragma mark - SearchRecruitListViewDelegate
- (void) searchRecruitListWithText:(NSString *)text; {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    self.datasArray           = [dataArray mutableCopy];
    if (text.length > 0) {
        
        self.chooseButtonView.buttonTitleArray = @[@"区域",@"要求",@"时间"];
        [self.chooseButtonView loadUI];
        [self initialization];
        [self.params setObject:text forKey:@"skillPost"];
        
        [self.tableView.mj_header beginRefreshing];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
