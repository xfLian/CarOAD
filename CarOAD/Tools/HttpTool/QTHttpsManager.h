//
//  QTHttpsManager.h
//  LinJiaMaMa
//
//  Created by qiantang on 16/12/23.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTHttpsManager : NSObject

/**
 *  创建单向https证书验证
 *
 *  name    API名称
 *
 */
+ (AFHTTPSessionManager *) creatOneWayAuthenticationHttpsManagerWithApiName:(NSString *)name;

/**
 *  创建双向https证书验证
 *
 *  name    API名称
 *
 */
+ (AFHTTPSessionManager *) creatTwoWayAuthenticationHttpsManagerWithApiName:(NSString *)name;

@end
