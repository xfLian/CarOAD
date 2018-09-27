//
//  ThirdViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ThirdViewController.h"

#import "NewsInfomationDetailsViewController.h"
#import "ArticleListRootModel.h"
#import "CommunityArticleCell.h"
#import "CommunityChooseCardView.h"

#import "OADQADetailsViewController.h"

@interface ThirdViewController ()<CommunityChooseCardViewDelegate>
{

    NSInteger PageNo;
    NSString *typeId;
    NSArray  *typeArray;

}
@property (nonatomic, strong) CommunityChooseCardView *chooseCardView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray *articleDatasArray;

@end

@implementation ThirdViewController

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

- (void)loadData {
    
    [self.params setObject:@"15" forKey:@"pageStep"];
    if (self.isMyPublishVC == YES) {
        
        [self.params setObject:self.userId forKey:@"userId"];
        
    } else {
        
        [self.params setObject:@"" forKey:@"userId"];
        [self.params setObject:@"1" forKey:@"source"];
        
    }
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    if (self.isMyPublishVC == YES) {
        
        self.tableView.frame = CGRectMake(0 , 0, Screen_Width, Screen_Height - SafeAreaTopHeight - 50 *Scale_Height);
        
    } else {
        
        self.tableView.frame = CGRectMake(0 , 0, Screen_Width, Screen_Height - SafeAreaTopHeight - 49 - SafeAreaBottomHeight - 50 *Scale_Height);
        
    }
    
    CommunityChooseCardView *chooseCardView = [[CommunityChooseCardView alloc] init];
    chooseCardView.delegate           = self;
    [self.view addSubview:chooseCardView];
    
    self.chooseCardView = chooseCardView;
    
    [self.tableView registerClass:[CommunityArticleCell class] forCellReuseIdentifier:@"CommunityArticleCell"];
    
}

- (void) clickClassifiedButtonWithType:(NSInteger)type; {
    
    typeId = typeArray[type][@"tagId"];
    [self.params setObject:typeId forKey:@"tagId"];
    [self.tableView.mj_header beginRefreshing];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ArticleListData *model = self.articleDatasArray[indexPath.row];
    model.type             = @"文章";

    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        NewsInfomationDetailsViewController *viewController = [NewsInfomationDetailsViewController new];
        viewController.navTitle    = @"文章详情";
        viewController.detailsData = model;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }

}

- (void) getTagType {

    NSDictionary *params = @{@"tagType":@"2"};
    
    [MBProgressHUD showMessage:nil toView:self.view];

    [CommunityMainViewModel requestPost_getTagListNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

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
        
        if (self.isMyPublishVC == YES) {
            
            self.tableView.frame = CGRectMake(0 , self.chooseCardView.height, Screen_Width, Screen_Height - 64 - 50 *Scale_Height - self.chooseCardView.height);
            
        } else {
            
            self.tableView.frame = CGRectMake(0 , self.chooseCardView.height, Screen_Width, Screen_Height - 64 - 49 - 50 *Scale_Height - self.chooseCardView.height);
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [MBProgressHUD hideHUDForView:self.view];

            [self.chooseCardView buildsubview];
            [self.params setObject:typeId forKey:@"tagId"];
            [self.tableView.mj_header beginRefreshing];

        });



    } error:^(NSString *errorMessage) {

        dispatch_async(dispatch_get_main_queue(), ^{

            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessageTitle:@"暂无问答标签" toView:self.view afterDelay:1.f];


        });


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

    if (self.isMyPublishVC == YES) {
        
        [CommunityMainViewModel requestPost_getMyPublishArticleListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
            
            [self requestSucessWithData:info];
            
        } error:^(NSString *errorMessage) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        } failure:^(NSError *error) {
            
            [self requestFailedWithError:error];
            
        }];
        
    } else {
        
        [CommunityMainViewModel requestPost_getArticleListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
            
            [self requestSucessWithData:info];
            
        } error:^(NSString *errorMessage) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
            
        } failure:^(NSError *error) {
            
            [self requestFailedWithError:error];
            
        }];
        
    }

}

- (void) requestSucessWithData:(id)data; {

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

    ArticleListData *model = self.articleDatasArray[indexPath.row];

    CGFloat imageHeight = 0;
    CGFloat titleHeight = 0;
    CGFloat contentHeight = 0;

    if (model.artCoverImg.length > 0) {

        imageHeight = (Screen_Width - 24 *Scale_Width) *3 / 8 + 15 *Scale_Height;

    } else {

        imageHeight = 0;

    }

    if (model.title.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 10;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_20, NSParagraphStyleAttributeName:style};

        CGFloat labelHeight = [model.title heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];

        if (labelHeight > 66 *Scale_Height) {

            labelHeight = 66 *Scale_Height;

        }

        titleHeight = labelHeight + 15 *Scale_Height;

    } else {

        titleHeight = 0;

    }

    if (model.articleInfo.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 6;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_16, NSParagraphStyleAttributeName:style};

        CGFloat labelHeight = [model.articleInfo heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];

        if (labelHeight > 50 *Scale_Height) {

            labelHeight = 50 *Scale_Height;

        }

        contentHeight = labelHeight + 15 *Scale_Height;

    } else {

        contentHeight = 0;

    }

    return imageHeight + titleHeight + contentHeight + 95 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CommunityArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityArticleCell" forIndexPath:indexPath];
    cell.selectionStyle        = UITableViewCellSelectionStyleNone;
    if (self.articleDatasArray.count > 0) {
        
        ArticleListData *model = self.articleDatasArray[indexPath.row];
        model.cell_tag = indexPath.row;
        
        cell.data = model;
        [cell loadContent];
        
    }

    return cell;

}

@end
