//
//  CommunityMainViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityMainViewModel : NSObject

//  获取标签数据
+ (void)requestPost_getTagListNetWorkingDataWithParams:(NSDictionary *)params
                                               success:(void (^)(id info,NSInteger count))success
                                                 error:(void (^) (NSString *errorMessage))error
                                               failure:(void (^) (NSError *error))failure;

//  获取问答列表数据
+ (void)requestPost_questionAndAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure;

//  获取视频列表数据
+ (void)requestPost_getVideoListNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure;

//  获取文章列表数据
+ (void)requestPost_getArticleListNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure;

//  获取视频播放凭证
+ (void)requestPost_getVideoPlayAuthNetWorkingDataWithParams:(NSDictionary *)params
                                                   success:(void (^)(id info,NSInteger count))success
                                                     error:(void (^) (NSString *errorMessage))error
                                                   failure:(void (^) (NSError *error))failure;

//  获取我的发布问答列表数据
+ (void)requestPost_getMyPublishQuestionAndAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure;

//  获取我的发布视频列表数据
+ (void)requestPost_getMyPublishVideoListNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure;

//  获取我的发布文章列表数据
+ (void)requestPost_getMyPublishArticleListNetWorkingDataWithParams:(NSDictionary *)params
                                                   success:(void (^)(id info,NSInteger count))success
                                                     error:(void (^) (NSString *errorMessage))error
                                                   failure:(void (^) (NSError *error))failure;

@end
