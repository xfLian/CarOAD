//
//  HttpTool.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

//  创建单例
+ (instancetype)sharedHttpTool;

/**
 *  发送一个GET请求
 *
 *  @param url             请求路径
 *  @param params          请求参数
 *  @param success         请求成功后的回调
 *  @param failure         请求失败后的回调
 *
 */
- (void) lxfGetWithURL:(NSString *)url
                params:(NSDictionary *)params
               success:(void (^)(id data))success
               failure:(void (^)(NSError *error))failure;

/**
 *  发送一个https POST请求
 *
 *  @param url             请求路径
 *  @param params          请求参数
 *  @param success         请求成功后的回调
 *  @param failure         请求失败后的回调
 *
 */
- (void) lxfPostWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id data))success
                failure:(void (^)(NSError *error))failure;

/**
 *  发送一个http POST请求
 *
 *  @param url             请求路径
 *  @param params          请求参数
 *  @param success         请求成功后的回调
 *  @param failure         请求失败后的回调
 *
 */
- (void) lxfHttpPostWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id data))success
                failure:(void (^)(NSError *error))failure;

/**
 *  发送一个http GET请求
 *
 *  @param url             请求路径
 *  @param params          请求参数
 *  @param success         请求成功后的回调
 *  @param failure         请求失败后的回调
 *
 */
- (void) lxfHttpGetWithURL:(NSString *)url
                     params:(NSDictionary *)params
                    success:(void (^)(id data))success
                    failure:(void (^)(NSError *error))failure;

//  取消单个网络请求
- (void) cancelSingleOperations;

//  取消所有的网络请求
- (void) cancelAllOperations;

@end
