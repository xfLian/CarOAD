//
//  FirstViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "FirstViewController.h"

#import "NewsInfomationDetailsViewController.h"
#import "QAListRootModel.h"
#import "QuestionAndAnswerModel.h"

#import "OADQADetailsViewController.h"

#import "CommunityBigImageCell.h"
#import "CommunitySmallImageCell.h"
#import "CommunityMoreImageCell.h"
#import "CommunityNotImageCell.h"

@interface FirstViewController ()
{
    
    NSInteger PageNo;
    
}
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray *datasArray;

@end

@implementation FirstViewController

- (NSMutableArray *)datasArray {

    if (!_datasArray) {

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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
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
    
    if (self.isMyPublishVC == YES) {

        self.tableView.frame = CGRectMake(0 , 0, Screen_Width, Screen_Height - SafeAreaTopHeight - 50 *Scale_Height);

    } else {

        self.tableView.frame = CGRectMake(0 , 0, Screen_Width, Screen_Height - SafeAreaTopHeight - 49 - SafeAreaBottomHeight - 50 *Scale_Height);

    }

    [self.tableView registerClass:[CommunityBigImageCell   class] forCellReuseIdentifier:@"CommunityBigImageCell"];
    [self.tableView registerClass:[CommunitySmallImageCell class] forCellReuseIdentifier:@"CommunitySmallImageCell"];
    [self.tableView registerClass:[CommunityMoreImageCell  class] forCellReuseIdentifier:@"CommunityMoreImageCell"];
    [self.tableView registerClass:[CommunityNotImageCell   class] forCellReuseIdentifier:@"CommunityNotImageCell"];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuestionAndAnswerModel *model = self.datasArray[indexPath.row];
    
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        OADQADetailsViewController *viewController = [OADQADetailsViewController new];
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
        
        [CommunityMainViewModel requestPost_getMyPublishQuestionAndAnswerListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
            
            CarOadLog(@"info --- %@",info);
            
            [self requestSucessWithData:info];
            
        } error:^(NSString *errorMessage) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        } failure:^(NSError *error) {
            
            [self requestFailedWithError:error];
            
        }];
        
    } else {
        
        [CommunityMainViewModel requestPost_questionAndAnswerListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
            
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
    
    QAListRootModel *rootModel = [[QAListRootModel alloc] initWithDictionary:data];
    
    if ([rootModel.result integerValue] == 1) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            if (self.datasArray.count > 0) {
                
                for (QuestionAndAnswerModel *model in self.datasArray) {
                    
                    [dataArray addObject:model];
                    
                }
                
            }
            
            if (PageNo == 1) {
                
                [dataArray removeAllObjects];
                
            }
            
            if (rootModel.data.count > 0) {
                
                for (QAListData *tmpData in rootModel.data) {
                    
                    QuestionAndAnswerModel *model = [QuestionAndAnswerModel initQuestionAndAnswerData:tmpData];
                    
                    [dataArray addObject:model];
                    
                }
                
            }
            
            self.datasArray = [dataArray mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                if (self.datasArray.count > 0) {

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
    
    [MBProgressHUD showMessageTitle:@"连接服务器失败！"];
    
}

- (void)loadData {

    
}

#pragma mark -
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datasArray.count;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    QuestionAndAnswerModel *model = self.datasArray[indexPath.row];

    if (model.text.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};

        CGFloat labelHeight = [model.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];

        if (labelHeight > 66 *Scale_Height) {

            labelHeight = 66 *Scale_Height;

        }

        return model.cell_height + labelHeight + 10 *Scale_Height;

    } else {

        return model.cell_height;

    }

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    QuestionAndAnswerModel *model = self.datasArray[indexPath.row];

    if ([model.cell_type integerValue] == 0) {

        CommunityBigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityBigImageCell" forIndexPath:indexPath];
        cell.selectionStyle         = UITableViewCellSelectionStyleNone;

        if (self.datasArray.count > 0) {

            cell.data = model;
            [cell loadContent];

        }

        return cell;

    } else if ([model.cell_type integerValue] == 1) {

        CommunitySmallImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunitySmallImageCell" forIndexPath:indexPath];
        cell.selectionStyle         = UITableViewCellSelectionStyleNone;

        if (self.datasArray.count > 0) {
            
            cell.data = model;
            [cell loadContent];
            
        }

        return cell;

    } else if ([model.cell_type integerValue] == 2) {

        CommunityMoreImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityMoreImageCell" forIndexPath:indexPath];
        cell.selectionStyle          = UITableViewCellSelectionStyleNone;

        if (self.datasArray.count > 0) {

            cell.data = model;
            [cell loadContent];

        }

        return cell;

    } else {

        CommunityNotImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityNotImageCell" forIndexPath:indexPath];
        cell.selectionStyle         = UITableViewCellSelectionStyleNone;

        if (self.datasArray.count > 0) {

            cell.data = model;
            [cell loadContent];

        }

        return cell;

    }

}

@end
