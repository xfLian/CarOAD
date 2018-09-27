//
//  DetailsCommunityViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "DetailsCommunityViewModel.h"

#import "AnswerListData.h"
#import "ArtCommunityListData.h"

@implementation DetailsCommunityViewModel

+ (DetailsCommunityViewModel *) getQACommunityListData:(id)data; {

    AnswerListData *model = data;
    
    DetailsCommunityViewModel *newModel = [DetailsCommunityViewModel new];

    newModel.type   = model.type;
    newModel.typeId = model.typeId;
    
    newModel.answerId = model.answerId;
    newModel.ansCreaterImg = model.ansCreaterImg;
    newModel.ansCreaterName = model.ansCreaterName;
    newModel.ansCreateDate = model.ansCreateDate;
    newModel.ansLikeNum = model.ansLikeNum;
    newModel.ansContent = model.ansContent;
    newModel.ansNum = model.ansNum;
    newModel.isLike = model.isLike;
    newModel.reImgURL = model.reImgURL;

    return newModel;

}

+ (DetailsCommunityViewModel *) getQTCommunityListData:(id)data; {

    ArtCommunityListData *model = data;

    DetailsCommunityViewModel *newModel = [DetailsCommunityViewModel new];

    newModel.type   = model.type;
    newModel.typeId = model.typeId;

    newModel.answerId = model.commentId;
    newModel.ansCreaterImg = model.createrImg;
    newModel.ansCreaterName = model.createrName;
    newModel.ansCreateDate = model.createDate;
    newModel.ansLikeNum = model.likeNum;
    newModel.ansContent = model.content;
    newModel.ansNum = model.commentNum;
    newModel.isLike = model.isLike;

    return newModel;

}

#pragma mark -  回答列表
+ (void)requestPost_getQAAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                    success:(void (^)(id info,NSInteger count))success
                                                      error:(void (^) (NSString *errorMessage))error
                                                    failure:(void (^) (NSError *error))failure;{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_ANSWER_LIST);

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

#pragma mark -  文章详情
+ (void)requestPost_getQTDetailsNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_ARTICLE_INFO);

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

#pragma mark -  评论列表
+ (void)requestPost_getQTAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                    success:(void (^)(id info,NSInteger count))success
                                                      error:(void (^) (NSString *errorMessage))error
                                                    failure:(void (^) (NSError *error))failure;{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_COMMENT_LIST);

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
