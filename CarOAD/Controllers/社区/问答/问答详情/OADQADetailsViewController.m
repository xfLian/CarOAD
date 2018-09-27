//
//  OADQADetailsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADQADetailsViewController.h"

#import "OADCommentAnswerDetailsViewController.h"
#import "OADPublishCommentAnswerViewController.h"

#import "QuestionAndAnswerModel.h"
#import "AnswerListRootModel.h"
#import "DetailsCommunityViewModel.h"

#import "QADetailsMainView.h"

@interface OADQADetailsViewController ()<QADetailsMainViewDelegate>
{
    
    NSInteger PageNo;
    
}
@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;
@property (nonatomic, strong) NSMutableArray         *imageMutableArray;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) QADetailsMainView *subView;
@property (nonatomic, strong) NSMutableArray    *datasArray;

@end

@implementation OADQADetailsViewController

- (QTCheckImageScrollView *)checkImageScrollView {

    if (!_checkImageScrollView) {

        _checkImageScrollView = [QTCheckImageScrollView new];

    }

    return _checkImageScrollView;

}

- (NSMutableArray *)imageMutableArray {

    if (!_imageMutableArray) {

        _imageMutableArray = [NSMutableArray array];

    }

    return _imageMutableArray;

}

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    [self loadNewData];

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadNewData];

    [MBProgressHUD showMessage:nil toView:self.view];
    
}

- (void)setNavigationController {
    
    self.navTitle = @"问答详情";
    
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    QADetailsMainView *subView = [[QADetailsMainView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    subView.delegate           = self;
    subView.detailsData        = self.detailsData;
    [self.contentView addSubview:subView];
    
    self.subView = subView;
    [self.subView loadFirstSectionData];

}

#pragma mark - QADetailsMainViewDelegate
- (void)checkAnswerDetailsWithAnswerData:(id)answerData {

    QuestionAndAnswerModel *tmpModel = self.detailsData;

    DetailsCommunityViewModel *model = answerData;
    model.type                       = @"问答";
    model.typeId                     = tmpModel.qAId;
    
    OADCommentAnswerDetailsViewController *viewController = [OADCommentAnswerDetailsViewController new];
    viewController.answerDetailsData                      = answerData;
    [self presentViewController:viewController animated:YES completion:^{
        
    }];

}

- (void) clickGotoCommentViewWithQAId:(NSString *)qaId; {
    
    QuestionAndAnswerModel *model = self.detailsData;
    
    OADPublishCommentAnswerViewController *viewController = [OADPublishCommentAnswerViewController new];
    viewController.type     = @"问答";
    viewController.navTitle = @"回答问答";
    viewController.qaId     = model.qAId;
    viewController.content  = model.text;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

/**
 *  加载新数据
 */
- (void) loadNewData {
    
    PageNo = 1;
    
    QuestionAndAnswerModel *model = self.detailsData;
    
    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@"" forKey:@"userId"];
    [self.params setObject:model.qAId forKey:@"QAId"];
    
    [self startNetworking];
    
}

/**
 *  发送请求加载更多的微博数据
 */
- (void) loadMoreData {
    
    PageNo ++;
    
    QuestionAndAnswerModel *model = self.detailsData;
    
    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@"" forKey:@"userId"];
    [self.params setObject:model.qAId forKey:@"QAId"];
    
    [self startNetworking];
    
}

- (void) clickDetailsLikeButton; {

    QuestionAndAnswerModel *model = self.detailsData;

    [[PreserveLikeData initPreserveLikeData] addDetailsLikeWithType:@"1" detailsId:model.qAId];

    [self.subView loadFirstSectionData];

}

- (void) clickDetailsListLikeButtonForData:(id)data; {

    DetailsCommunityViewModel *model = data;

    [[PreserveLikeData initPreserveLikeData] addDetailsLikeWithType:@"1" detailsId:model.typeId communityId:model.answerId];

    [self.subView loadSecondSectionData];

}

- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag; {

    self.checkImageScrollView.imagesArray = [array copy];
    [self.checkImageScrollView showwithTag:tag - 2000];
    
}

#pragma mark -  获取服务器数据
- (void) startNetworking {
    
    [DetailsCommunityViewModel requestPost_getQAAnswerListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self requestSucessWithData:info];

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.subView hideMJ];
        
    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self requestFailedWithError:error];
        
    }];
    
}

- (void) requestSucessWithData:(id)data; {
    
    AnswerListRootModel *rootModel = [[AnswerListRootModel alloc] initWithDictionary:data];
    
    if ([rootModel.result integerValue] == 1) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            if (self.datasArray.count > 0) {
                
                for (DetailsCommunityViewModel *model in self.datasArray) {
                    
                    [dataArray addObject:model];
                    
                }
                
            }
            
            if (PageNo == 1) {
                
                [dataArray removeAllObjects];
                
            }
            
            if (rootModel.data.count > 0) {

                QuestionAndAnswerModel *model = self.detailsData;
                
                for (AnswerListData *tmpData in rootModel.data) {

                    tmpData.type   = @"问答";
                    tmpData.typeId = model.qAId;

                    DetailsCommunityViewModel *model = [DetailsCommunityViewModel getQACommunityListData:tmpData];

                    [dataArray addObject:model];
                    
                }
                
            }
            
            self.datasArray = [dataArray mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.subView.datasArray = self.datasArray;
                [self.subView hideMJ];
                [self.subView loadSecondSectionData];
                
            });
            
        });
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.subView hideMJ];
            
        });
        
    }
    
}

- (void) requestFailedWithError:(NSError *)error; {
    
    [self.subView hideMJ];
    [MBProgressHUD showMessageTitle:@"连接服务器失败！"];
    
}

@end
