//
//  CommunityAnswerListViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/28.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityAnswerListViewModel.h"

#import "CommentAnswerListData.h"

@implementation CommunityAnswerListViewModel

+ (CommunityAnswerListViewModel *) getQACommunityListData:(id)data; {

    CommentAnswerListData *model = data;

    CommunityAnswerListViewModel *newModel = [CommunityAnswerListViewModel new];

    newModel.replyId = model.replyId;
    newModel.userImg = model.userImg;
    newModel.userName = model.userName;
    newModel.createDate = model.createDate;
    newModel.ansContent = model.ansContent;

    return newModel;

}

//  转换其他评论列表数据
+ (CommunityAnswerListViewModel *) getQTCommunityListData:(id)data; {

    CommentAnswerListData *model = data;

    CommunityAnswerListViewModel *newModel = [CommunityAnswerListViewModel new];

    newModel.replyId = model.replyId;
    newModel.userImg = model.userImg;
    newModel.userName = model.userName;
    newModel.createDate = model.createDate;
    newModel.ansContent = model.content;

    return newModel;

}

#pragma mark -  回复列表
+ (void)requestPost_getQACommentAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                           success:(void (^)(id info,NSInteger count))success
                                                             error:(void (^) (NSString *errorMessage))error
                                                           failure:(void (^) (NSError *error))failure;
{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_ANSWER_REPLY_LIST);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error(@"数据为空");

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

#pragma mark -  评论回答
+ (void)requestPost_publishQACommentAnswerNetWorkingDataWithParams:(NSDictionary *)params
                                                           success:(void (^)(id info,NSInteger count))success
                                                             error:(void (^) (NSString *errorMessage))error
                                                           failure:(void (^) (NSError *error))failure;
{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, COMMENT_ANSWER);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error(@"数据为空");

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}


#pragma mark -  回复评论
+ (void)requestPost_publishQAReplyCommentNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, REPLY_COMMENT);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error(@"数据为空");

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

#pragma mark -  文章评论回复列表
+ (void)requestPost_getQTAnswerCommunityListNetWorkingDataWithParams:(NSDictionary *)params
                                                             success:(void (^)(id info,NSInteger count))success
                                                               error:(void (^) (NSString *errorMessage))error
                                                             failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_COMMENT_REPLY_LIST);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error(@"数据为空");

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

#pragma mark -  文章评论回复
+ (void)requestPost_publishQTReplyCommentArtNetWorkingDataWithParams:(NSDictionary *)params
                                                             success:(void (^)(id info,NSInteger count))success
                                                               error:(void (^) (NSString *errorMessage))error
                                                             failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, ADD_REPLY_COMMENT);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error(@"数据为空");

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];


}

@end
