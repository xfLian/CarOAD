//
//  OADLogInViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OADLogInViewModel : NSObject

/**
 获取验证码

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getVerificationCodeNetWorkingDataWithParams:(NSDictionary *)params
                                                        success:(void (^)(id info,NSInteger count))success
                                                          error:(void (^) (NSString *errorMessage))error
                                                        failure:(void (^) (NSError *error))failure;

/**
 登录

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_logInNetWorkingDataWithParams:(NSDictionary *)params
                                          success:(void (^)(id info,NSInteger count))success
                                            error:(void (^) (NSString *errorMessage))error
                                          failure:(void (^) (NSError *error))failure;

/**
 注册

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_registerNetWorkingDataWithParams:(NSDictionary *)params
                                          success:(void (^)(id info,NSInteger count))success
                                            error:(void (^) (NSString *errorMessage))error
                                          failure:(void (^) (NSError *error))failure;

/**
 找回密码

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_findPasswordNetWorkingDataWithParams:(NSDictionary *)params
                                          success:(void (^)(id info,NSInteger count))success
                                            error:(void (^) (NSString *errorMessage))error
                                          failure:(void (^) (NSError *error))failure;

/**
 修改密码

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_changePwdNetWorkingDataWithParams:(NSDictionary *)params
                                              success:(void (^)(id info,NSInteger count))success
                                                error:(void (^) (NSString *errorMessage))error
                                              failure:(void (^) (NSError *error))failure;

@end
