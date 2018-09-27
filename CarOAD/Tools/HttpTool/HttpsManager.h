//
//  HttpsManager.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpsManager : NSObject

/**
 *  创建单向https证书验证
 *
 *  name    API名称
 *
 */
+ (AFHTTPSessionManager *) creatOneWayAuthenticationHttpsManager;

/**
 *  创建双向https证书验证
 *
 *  name    API名称
 *
 */
+ (AFHTTPSessionManager *) creatTwoWayAuthenticationHttpsManager;

@end
