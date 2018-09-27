//
//  PublishCommentViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "PublishCommentViewModel.h"

@implementation PublishCommentViewModel

#pragma mark -  回答问答
+ (void)requestPost_publishQACommentQANetWorkingDataWithParams:(NSDictionary *)params
                                                       success:(void (^)(id info,NSInteger count))success
                                                         error:(void (^) (NSString *errorMessage))error
                                                       failure:(void (^) (NSError *error))failure;{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, ADD_ANSWER);

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

#pragma mark - 评论文章
+ (void)requestPost_publishQTCommentArtNetWorkingDataWithParams:(NSDictionary *)params
                                                        success:(void (^)(id info,NSInteger count))success
                                                          error:(void (^) (NSString *errorMessage))error
                                                        failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, ADD_COMMENT);

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
