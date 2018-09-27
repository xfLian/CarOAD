//
//  OADCommentAnswerDetailsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADCommentAnswerDetailsViewController.h"

#import "CommentAnswerDetailsMainView.h"
#import "CommunityAnswerListViewModel.h"

#import "CommentAnswerListRootModel.h"
#import "DetailsCommunityViewModel.h"

@interface OADCommentAnswerDetailsViewController ()<CommentAnswerDetailsMainViewDelegate>
{
    
    NSInteger PageNo;
    
}
@property (nonatomic, strong) QTCheckImageScrollView       *checkImageScrollView;
@property (nonatomic, strong) NSMutableDictionary          *params;
@property (nonatomic, strong) CommentAnswerDetailsMainView *subView;
@property (nonatomic, strong) NSMutableArray               *datasArray;

@end

@implementation OADCommentAnswerDetailsViewController

- (QTCheckImageScrollView *)checkImageScrollView {

    if (!_checkImageScrollView) {

        _checkImageScrollView = [QTCheckImageScrollView new];

    }

    return _checkImageScrollView;

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [self.subView showNavBackView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.subView hideNavBackView];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

#pragma mark - 通知方法
/**
 *
 *  键盘弹起时执行该方法
 *
 *  修改tmpSubView的位置到键盘之上
 *
 */
- (void) openKeyboard:(NSNotification *)notification {
    
    CGRect frameOfKeyboard        = \
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration       = \
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = \
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [self.subView showhideKeyboardWithKeyRect:frameOfKeyboard duration:duration delay:0 options:option];
    
}

- (void) hideKeyboard:(NSNotification *)notification {
    
    NSTimeInterval duration       = \
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = \
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [self.subView hidehideKeyboardWithDuration:duration delay:0 options:option];
}

- (void)viewDidAppear:(BOOL)animated {
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setData];

    [self loadNewData];
    
}

- (void)buildSubView {
    
    CommentAnswerDetailsMainView *subView = [[CommentAnswerDetailsMainView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    subView.delegate                      = self;
    subView.detailsData                   = self.answerDetailsData;
    [self.view addSubview:subView];
    
    self.subView = subView;
    
}

- (void) setData {

    DetailsCommunityViewModel *model = self.answerDetailsData;
    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@""   forKey:@"userId"];

    if ([model.type isEqualToString:@"问答"]) {

        [self.params setObject:model.answerId forKey:@"answerId"];
        [self.params setObject:model.typeId forKey:@"QAId"];

    } else {

        [self.params setObject:model.typeId forKey:@"artId"];
        [self.params setObject:model.answerId forKey:@"commentId"];

    }

}

#pragma mark - CommentAnswerDetailsMainViewDelegate
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

- (void) clickDetailsLikeButton; {

    DetailsCommunityViewModel *model = self.answerDetailsData;

    NSString *type = nil;

    if ([model.type isEqualToString:@"问答"]) {

        type = @"1";

    } else if ([model.type isEqualToString:@"视频"]) {

        type = @"2";

    } else if ([model.type isEqualToString:@"文章"]) {

        type = @"3";

    } else if ([model.type isEqualToString:@"资讯"]) {

        type = @"4";

    } else if ([model.type isEqualToString:@"新闻"]) {

        type = @"5";

    }

    [[PreserveLikeData initPreserveLikeData] addDetailsLikeWithType:type detailsId:model.typeId communityId:model.answerId];

    [self.subView loadFirstSectionData];

}

- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag; {

    self.checkImageScrollView.imagesArray = [array copy];
    [self.checkImageScrollView showwithTag:tag - 2000];

}

#pragma mark - 获取服务器数据
- (void) startNetworking {

    DetailsCommunityViewModel *model = self.answerDetailsData;

    if ([model.type isEqualToString:@"问答"]) {

        [CommunityAnswerListViewModel requestPost_getQACommentAnswerListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

            [self requestSucessWithData:info];

        } error:^(NSString *errorMessage) {

            [self.subView hideMJ];

        } failure:^(NSError *error) {

            [self requestFailedWithError:error];

        }];

    } else {

        [CommunityAnswerListViewModel requestPost_getQTAnswerCommunityListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

            [self requestSucessWithData:info];

        } error:^(NSString *errorMessage) {

            [self.subView hideMJ];

        } failure:^(NSError *error) {

            [self requestFailedWithError:error];

        }];

    }

}

- (void) requestSucessWithData:(id)data; {
    
    CommentAnswerListRootModel *rootModel = [[CommentAnswerListRootModel alloc] initWithDictionary:data];
    
    if ([rootModel.result integerValue] == 1) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            if (self.datasArray.count > 0) {
                
                for (CommunityAnswerListViewModel *model in self.datasArray) {
                    
                    [dataArray addObject:model];
                    
                }
                
            }
            
            if (PageNo == 1) {
                
                [dataArray removeAllObjects];
                
            }
            
            if (rootModel.data.count > 0) {

                DetailsCommunityViewModel *model = self.answerDetailsData;

                for (CommentAnswerListData *tmpData in rootModel.data) {

                    if ([model.type isEqualToString:@"问答"]) {

                        CommunityAnswerListViewModel *newModel = [CommunityAnswerListViewModel getQACommunityListData:tmpData];
                        [dataArray addObject:newModel];

                    } else {

                        CommunityAnswerListViewModel *newModel = [CommunityAnswerListViewModel getQTCommunityListData:tmpData];
                        [dataArray addObject:newModel];

                    }

                }
                
            }
            
            self.datasArray = [dataArray mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.subView.datasArray = [self.datasArray mutableCopy];
                [self.subView hideMJ];
                [self.subView loadContent];
                
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

- (void) clickCloseButton; {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void) publishCommentWithData:(id)data isComment:(BOOL)isComment; {
    
    NSDictionary *modelDic = data;
    
    DetailsCommunityViewModel *model = self.answerDetailsData;

    if ([model.type isEqualToString:@"问答"]) {

        [self publishCommentForQA:modelDic];

    } else {

        [self publishCommentForArt:modelDic];

    }
    
}

/**
 *
 *  评论回答
 *
userId         string    是    用户Id     1
QAId           string    是    主问题编号  1
ansewerId      string    是    回答编号    1
commentInfo    string    是    评论内容    昨天没有下雨
 *
 */

/**
 *
 *  回复评论
 *
 userId       string    是    用户Id     1
 QAId         string    是    主问题编号  1
 ansewerId    string    是    回答编号    1
 commentId    string    是    评论编号    1
 replyInfo    string    是    评论内容    yeserterday
 *
 */
- (void) publishCommentForQA:(NSDictionary *)publishData {

    DetailsCommunityViewModel *model = self.answerDetailsData;

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    [params setObject:model.typeId forKey:@"QAId"];
    [params setObject:[publishData objectForKey:@"answerId"] forKey:@"ansewerId"];

    NSString *commentId = [publishData objectForKey:@"commentId"];

    if (commentId.length > 0) {

        //  回复评论

        [params setObject:[publishData objectForKey:@"commentId"] forKey:@"commentId"];
        [params setObject:[publishData objectForKey:@"replyInfo"] forKey:@"replyInfo"];
        [CommunityAnswerListViewModel requestPost_publishQAReplyCommentNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

            [MBProgressHUD showSuccess:@"回复成功"];

            [self loadNewData];

        } error:^(NSString *errorMessage) {


        } failure:^(NSError *error) {

            [self requestFailedWithError:error];

        }];

    } else {

        //  评论回答

        [params setObject:[publishData objectForKey:@"replyInfo"] forKey:@"commentInfo"];
        [CommunityAnswerListViewModel requestPost_publishQACommentAnswerNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

            [MBProgressHUD showSuccess:@"回复成功"];

            [self loadNewData];

        } error:^(NSString *errorMessage) {


        } failure:^(NSError *error) {

            [self requestFailedWithError:error];

        }];
        
    }

    CarOadLog(@"params --- %@",params);

}

/**
 *
 dataId      string    是    文章、视频Id
 content     string    是    评论内容
 parentId    string    是    父Id
 baseId      string    是    基础Id
 userId      string    是    创建人
 source      string    是    来源           1-文章 2-咨询 3-新闻 4-视频
 dataType    string    是    类型           1-评论 2-回复
 *
 */

- (void) publishCommentForArt:(NSDictionary *)publishData {

    DetailsCommunityViewModel *model = self.answerDetailsData;

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    [params setObject:model.typeId forKey:@"dataId"];
    [params setObject:[publishData objectForKey:@"replyInfo"] forKey:@"content"];
    [params setObject:[publishData objectForKey:@"answerId"] forKey:@"parentId"];

    if ([model.type isEqualToString:@"文章"]) {

        [params setObject:@"1" forKey:@"source"];

    } else if ([model.type isEqualToString:@"咨询"]) {

        [params setObject:@"2" forKey:@"source"];

    } else if ([model.type isEqualToString:@"新闻"]) {

        [params setObject:@"3" forKey:@"source"];

    } else if ([model.type isEqualToString:@"视频"]) {

        [params setObject:@"4" forKey:@"source"];

    }

    NSString *commentId = [publishData objectForKey:@"commentId"];

    if (commentId.length > 0) {

        //  回复评论
        [params setObject:@"2" forKey:@"dataType"];
        [params setObject:commentId forKey:@"baseId"];

    } else {

        //  评论回答
        [params setObject:@"1" forKey:@"dataType"];

    }

    [CommunityAnswerListViewModel requestPost_publishQTReplyCommentArtNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        dispatch_async(dispatch_get_main_queue(), ^{

            [MBProgressHUD showSuccess:@"回复成功"];

            [self loadNewData];

        });


    } error:^(NSString *errorMessage) {


    } failure:^(NSError *error) {

        [self requestFailedWithError:error];

    }];

    CarOadLog(@"params --- %@",params);

}

@end
