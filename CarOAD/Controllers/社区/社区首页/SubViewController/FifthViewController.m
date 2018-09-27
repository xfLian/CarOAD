//
//  FifthViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "FifthViewController.h"

#import "CommunityChooseCardView.h"
#import "ArticleListRootModel.h"
#import "CommunitySmallImageCell.h"

#import "OADQADetailsViewController.h"
#import "NewsInfomationDetailsViewController.h"

@interface FifthViewController ()<CommunityChooseCardViewDelegate>
{

    NSInteger PageNo;
    NSString *typeId;
    NSArray  *typeArray;

}
@property (nonatomic, strong) CommunityChooseCardView *chooseCardView;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray *articleDatasArray;

@end

@implementation FifthViewController

- (NSMutableArray *)articleDatasArray {

    if (!_articleDatasArray) {

        _articleDatasArray = [[NSMutableArray alloc] init];
    }

    return _articleDatasArray;

}

- (NSMutableDictionary *)params {

    if (!_params) {

        _params = [[NSMutableDictionary alloc] init];
    }

    return _params;

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];

}

- (void)buildSubView {

    [super buildSubView];

    CommunityChooseCardView *chooseCardView = [[CommunityChooseCardView alloc] init];
    chooseCardView.delegate           = self;
    [self.view addSubview:chooseCardView];
    self.chooseCardView = chooseCardView;

    [self.tableView registerClass:[CommunitySmallImageCell class] forCellReuseIdentifier:@"CommunitySmallImageCell"];

}

- (void) clickClassifiedButtonWithType:(NSInteger)type; {

    typeId = typeArray[type][@"tagId"];
    [self.tableView.mj_header beginRefreshing];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ArticleListData *model = self.articleDatasArray[indexPath.row];
    model.type             = @"新闻";
    
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        NewsInfomationDetailsViewController *viewController = [NewsInfomationDetailsViewController new];
        viewController.navTitle    = @"新闻详情";
        viewController.detailsData = model;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

- (void) getTagType {

    NSDictionary *params = @{@"tagType":@"4"};

    [MBProgressHUD showMessage:nil toView:self.view];

    [CommunityMainViewModel requestPost_getTagListNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view];

        typeArray = info[@"data"];

        NSMutableArray *buttonTitleArray = [[NSMutableArray alloc] init];

        for (NSDictionary *model in info[@"data"]) {

            [buttonTitleArray addObject:[model objectForKey:@"tag"]];

        }

        typeId = typeArray[0][@"tagId"];

        self.chooseCardView.buttonTitleArray = [buttonTitleArray copy];

        if (self.chooseCardView.buttonTitleArray.count > 4) {

            self.chooseCardView.frame = CGRectMake(0, 0, Screen_Width, 90 *Scale_Height);

        } else {

            self.chooseCardView.frame = CGRectMake(0, 0, Screen_Width, 50 *Scale_Height);

        }

        self.tableView.frame = CGRectMake(0 , self.chooseCardView.height, Screen_Width, Screen_Height - 64 - 49 - 50 *Scale_Height - self.chooseCardView.height);

        [self.chooseCardView buildsubview];

        [self.tableView.mj_header beginRefreshing];

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessageTitle:@"暂无问答标签"];

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view];

    }];

}

/**
 *  加载新数据
 */
- (void) loadNewData {

    PageNo = 1;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:typeId forKey:@"tagId"];


    [self startNetworking];

}

/**
 *  发送请求加载更多的微博数据
 */
- (void) loadMoreData {

    PageNo ++;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:typeId forKey:@"tagId"];

    [self startNetworking];

}

- (void) startNetworking {

    [CommunityMainViewModel requestPost_getArticleListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

        [self requestSucessWithData:info];

    } error:^(NSString *errorMessage) {

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];

    } failure:^(NSError *error) {

        [self requestFailedWithError:error];

    }];

}

- (void) requestSucessWithData:(id)data; {

    CarOadLog(@"data ---- %@",data);

    ArticleListRootModel *rootModel = [[ArticleListRootModel alloc] initWithDictionary:data];

    if ([rootModel.result integerValue] == 1) {

        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            NSMutableArray *dataArray = [[NSMutableArray alloc] init];

            if (self.articleDatasArray.count > 0) {

                for (ArticleListData *model in self.articleDatasArray) {

                    [dataArray addObject:model];

                }

            }

            if (PageNo == 1) {

                [dataArray removeAllObjects];

            }

            if (rootModel.data.count > 0) {

                for (ArticleListData *tmpData in rootModel.data) {

                    [dataArray addObject:tmpData];

                }

            }

            self.articleDatasArray = [dataArray mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{

                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                if (self.articleDatasArray.count > 0) {

                    [self.tableView reloadData];

                } else {

                    [MBProgressHUD showMessageTitle:@"数据为空" toView:self.view afterDelay:1.f];

                }

            });

        });

    } else {

        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
            self.tableView.mj_footer.hidden = NO;

        });

    }

}

- (void) requestFailedWithError:(NSError *)error; {

    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];

}

- (void)loadData {

    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@"3" forKey:@"source"];

}

#pragma mark -
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.articleDatasArray.count;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return (Screen_Width - 44 *Scale_Width) / 9 *2 + 40 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CommunitySmallImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunitySmallImageCell" forIndexPath:indexPath];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    if (self.articleDatasArray.count > 0) {

        ArticleListData *model = self.articleDatasArray[indexPath.row];
        model.cell_tag = indexPath.row;

        cell.data = model;
        [cell loadContent];

    }

    return cell;

}

@end
