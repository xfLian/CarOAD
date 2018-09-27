//
//  PublishCommentViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublishCommentViewModel : NSObject


/**
 回答问答

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_publishQACommentQANetWorkingDataWithParams:(NSDictionary *)params
                                                       success:(void (^)(id info,NSInteger count))success
                                                         error:(void (^) (NSString *errorMessage))error
                                                       failure:(void (^) (NSError *error))failure;


/**
 发表文章评论 （评论视频、文章、新闻、资讯使用同一个评论接口、传入不同的source值）

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_publishQTCommentArtNetWorkingDataWithParams:(NSDictionary *)params
                                                        success:(void (^)(id info,NSInteger count))success
                                                          error:(void (^) (NSString *errorMessage))error
                                                        failure:(void (^) (NSError *error))failure;

@end
