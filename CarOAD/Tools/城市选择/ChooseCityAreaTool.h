//
//  ChooseCityAreaTool.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseCityAreaTool : NSObject

/**
 获取城市数据

 @param type 需要的城市类型（省--1、市--2、区--3）
 @param provinceId 省份ID
 @param cityId 城市ID
 @param success 返回数据成功
 @param error 返回错误
 @param failure 返回失败
 */
- (void) getCityAreaDataWithType:(NSInteger)type
                      provinceId:(NSString *)provinceId
                          cityId:(NSString *)cityId
                       success:(void (^)(id info,NSInteger count))success
                         error:(void (^) (NSString *errorMessage))error
                       failure:(void (^) (NSError *error))failure;

@end
