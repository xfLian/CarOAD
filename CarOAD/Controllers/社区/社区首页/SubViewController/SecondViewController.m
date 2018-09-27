//
//  SecondViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "SecondViewController.h"

#import "VideoListRootModel.h"

#import "CommunityVideoCell.h"

#import "OADVideoDetailsViewController.h"

@interface SecondViewController ()
{

    NSInteger PageNo;

}
@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, strong) NSMutableArray *videoDatasArray;

@end

@implementation SecondViewController

- (NSMutableArray *)videoDatasArray {

    if (!_videoDatasArray) {

        _videoDatasArray = [[NSMutableArray alloc] init];
    }

    return _videoDatasArray;

}

- (NSMutableDictionary *)params {

    if (!_params) {

        _params = [[NSMutableDictionary alloc] init];
    }

    return _params;

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSLog(@"2");

}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
}

- (void)buildSubView {

    if (self.isMyPublishVC == YES) {

        [self.params setObject:self.userId forKey:@"userId"];

    } else {

        [self.params setObject:@"" forKey:@"userId"];

    }
    
    [super buildSubView];

    self.tableView.backgroundColor = BackGrayColor;
    
    if (self.isMyPublishVC == YES) {

        self.tableView.frame = CGRectMake(0 , 0, Screen_Width, Screen_Height - SafeAreaTopHeight - 50 *Scale_Height);

    } else {

        self.tableView.frame = CGRectMake(0 , 0, Screen_Width, Screen_Height - SafeAreaTopHeight - 49 - SafeAreaBottomHeight - 50 *Scale_Height);

    }

    [self.tableView registerClass:[CommunityVideoCell class] forCellReuseIdentifier:@"CommunityVideoCell"];
    
}

- (void)loadData {

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    VideoListData *model = self.videoDatasArray[indexPath.row];

    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        OADVideoDetailsViewController *viewController = [OADVideoDetailsViewController new];
        viewController.detailsData = model;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    

}

/**
 *  加载新数据
 */
- (void) loadNewData {

    PageNo = 1;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:@"15" forKey:@"pageStep"];

    [self startNetworking];

}

/**
 *  发送请求加载更多的微博数据
 */
- (void) loadMoreData {

    PageNo ++;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:@"15" forKey:@"pageStep"];

    [self startNetworking];

}

- (void) startNetworking {

    if (self.isMyPublishVC == YES) {
        
        [CommunityMainViewModel requestPost_getMyPublishVideoListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
            
            [self requestSucessWithData:info];
            
        } error:^(NSString *errorMessage) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        } failure:^(NSError *error) {
            
            [self requestFailedWithError:error];
            
        }];
        
    } else {
        
        [CommunityMainViewModel requestPost_getVideoListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
            
            CarOadLog(@"info --- %@",info);
            
            [self requestSucessWithData:info];
            
        } error:^(NSString *errorMessage) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        } failure:^(NSError *error) {
            
            [self requestFailedWithError:error];
            
        }];
        
    }

}

- (void) requestSucessWithData:(id)data; {
    
    VideoListRootModel *rootModel = [[VideoListRootModel alloc] initWithDictionary:data];

    if ([rootModel.result integerValue] == 1) {

        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            NSMutableArray *dataArray = [[NSMutableArray alloc] init];

            if (self.videoDatasArray.count > 0) {

                for (VideoListData *model in self.videoDatasArray) {

                    [dataArray addObject:model];

                }

            }

            if (PageNo == 1) {

                [dataArray removeAllObjects];

            }

            if (rootModel.data.count > 0) {

                for (VideoListData *tmpData in rootModel.data) {

                    [dataArray addObject:tmpData];

                }

            }

            self.videoDatasArray = [dataArray mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{

                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                if (self.videoDatasArray.count > 0) {

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

    return self.videoDatasArray.count;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 104 *Scale_Height + Screen_Width *9 / 16;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CommunityVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityVideoCell" forIndexPath:indexPath];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    if (self.videoDatasArray.count > 0) {

        VideoListData *model = self.videoDatasArray[indexPath.row];
        model.cell_tag = indexPath.row;

        cell.data = model;
        [cell loadContent];

    }

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}

@end
