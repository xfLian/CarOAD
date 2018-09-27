//
//  ChooseTypeOfServiceTool.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/23.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseTypeOfServiceTool : NSObject

/**
 获取服务类型数据
 
 @param type 需要的服务类型类型（第一级--1、第二级--2、第三极--3）
 @param categoryId 第一级类型ID
 @param catenaId 第二级类型ID
 @param success 返回数据成功
 @param error 返回错误
 @param failure 返回失败
 */
- (void) getTypeOfServiceDataWithType:(NSInteger)type
                      categoryId:(NSString *)categoryId
                        catenaId:(NSString *)catenaId
                         success:(void (^)(id info,NSInteger count))success
                           error:(void (^) (NSString *errorMessage))error
                         failure:(void (^) (NSError *error))failure;

@end
