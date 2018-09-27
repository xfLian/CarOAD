//
//  EducationExperienceViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EducationExperienceViewModel : NSObject

/**
 获取教育经历数据
 
 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getEduExpNetWorkingDataWithParams:(NSDictionary *)params
                                              success:(void (^)(id info,NSInteger count))success
                                                error:(void (^) (NSString *errorMessage))error
                                              failure:(void (^) (NSError *error))failure;

/**
 删除教育经历数据
 
 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_deleteEduExpNetWorkingDataWithParams:(NSDictionary *)params
                                                  success:(void (^)(id info,NSInteger count))success
                                                    error:(void (^) (NSString *errorMessage))error
                                                  failure:(void (^) (NSError *error))failure;

@end
