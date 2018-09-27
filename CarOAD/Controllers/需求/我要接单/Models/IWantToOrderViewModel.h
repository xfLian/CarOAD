//
//  IWantToOrderViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWantToOrderViewModel : NSObject

/**
 我要接单上传接单留言
 
 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_addOrderMsgNetWorkingDataWithParams:(NSDictionary *)params
                                                    success:(void (^)(id info,NSInteger count))success
                                                      error:(void (^) (NSString *errorMessage))error
                                                    failure:(void (^) (NSError *error))failure;

@end
