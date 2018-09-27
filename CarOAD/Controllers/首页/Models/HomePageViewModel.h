//
//  HomePageViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageViewModel : NSObject

/**
 获取首页轮播图片

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getHomePageSwitchImagesNetWorkingDataWithParams:(NSDictionary *)params
                                               success:(void (^)(id info,NSInteger count))success
                                                 error:(void (^) (NSString *errorMessage))error
                                               failure:(void (^) (NSError *error))failure;

/**
 获取首页-技师快报

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getHomePageInformationNetWorkingDataWithParams:(NSDictionary *)params
                                                    success:(void (^)(id info,NSInteger count))success
                                                      error:(void (^) (NSString *errorMessage))error
                                                    failure:(void (^) (NSError *error))failure;

/**
 获取首页-实时动态

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getHomePageTimeNewsNetWorkingDataWithParams:(NSDictionary *)params
                                                           success:(void (^)(id info,NSInteger count))success
                                                             error:(void (^) (NSString *errorMessage))error
                                                           failure:(void (^) (NSError *error))failure;

/**
 获取首页-招聘列表

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getHomePageRecruitListNetWorkingDataWithParams:(NSDictionary *)params
                                                        success:(void (^)(id info,NSInteger count))success
                                                          error:(void (^) (NSString *errorMessage))error
                                                        failure:(void (^) (NSError *error))failure;

/**
 获取首页-需求列表

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getHomePageDemandListNetWorkingDataWithParams:(NSDictionary *)params
                                                           success:(void (^)(id info,NSInteger count))success
                                                             error:(void (^) (NSString *errorMessage))error
                                                           failure:(void (^) (NSError *error))failure;

@end
