//
//  MessageListViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/5.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageListViewModel : NSObject

/**
 获取消息通知列表
 
 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getNoticeListNetWorkingDataWithParams:(NSDictionary *)params
                                                            success:(void (^)(id info,NSInteger count))success
                                                              error:(void (^) (NSString *errorMessage))error
                                                            failure:(void (^) (NSError *error))failure;

@end
