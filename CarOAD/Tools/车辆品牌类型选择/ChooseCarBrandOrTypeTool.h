//
//  ChooseCarBrandOrTypeTool.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseCarBrandOrTypeTool : NSObject

/**
 获取车辆品牌或型号

 @param type 需要获取的数据类型（品牌--1、型号--2）
 @param brandId 传入的车辆品牌ID
 @param success 返回数据成功
 @param error 返回错误
 @param failure 返回失败
 */
- (void) getCarBrandOrTypeDataWithType:(NSInteger)type
                               brandId:(NSString *)brandId
                               success:(void (^)(id info,NSInteger count))success
                                 error:(void (^) (NSString *errorMessage))error
                               failure:(void (^) (NSError *error))failure;

@end
