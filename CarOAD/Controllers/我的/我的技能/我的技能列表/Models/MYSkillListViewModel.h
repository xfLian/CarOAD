//
//  MYSkillListViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSkillListViewModel : NSObject

/**
 获取我的技能列表数据
 
 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getSkillListNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure;

/**
 删除我的技能列表数据
 
 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_deleteSkillNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure;

/**
 修改技能状态
 
 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_modifySkillStateNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure;

@end
