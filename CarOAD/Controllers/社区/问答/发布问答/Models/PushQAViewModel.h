//
//  PushQAViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushQAViewModel : NSObject

//  发布问答
+ (void)requestPost_pushQuestionAndAnswerNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure;

@end
