//
//  DetailsCommunityViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

/**
 *  转换问答、视频、文章等详情页面评论列表数据
 */

#import <Foundation/Foundation.h>

@interface DetailsCommunityViewModel : NSObject

/**
 *
 *  详情类型
 *
 *  问答、视频、文章、资讯、新闻
 *
 */
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *answerId;
@property (nonatomic, strong) NSString *ansCreaterImg;

@property (nonatomic, strong) NSString *ansCreaterName;
@property (nonatomic, strong) NSString *ansCreateDate;
@property (nonatomic, strong) NSString *ansLikeNum;
@property (nonatomic, strong) NSString *ansContent;

@property (nonatomic, strong) NSString *ansNum;
@property (nonatomic, strong) NSString *isLike;
@property (nonatomic, strong) NSString *reImgURL;

//  转换问答评论列表数据
+ (DetailsCommunityViewModel *) getQACommunityListData:(id)data;

//  转换其他评论列表数据
+ (DetailsCommunityViewModel *) getQTCommunityListData:(id)data;

/**
 获取问答回答列表数据

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getQAAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                    success:(void (^)(id info,NSInteger count))success
                                                      error:(void (^) (NSString *errorMessage))error
                                                    failure:(void (^) (NSError *error))failure;


/**
 文章详情数据 （文章、新闻、资讯使用同一个详情接口、根据传入的tag值不同获取相应的数据）

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getQTDetailsNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure;

/**
 文章评论列表数据 （视频、文章、新闻、资讯使用同一个详情接口、根据传入的tag值不同获取相应的数据）

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getQTAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                    success:(void (^)(id info,NSInteger count))success
                                                      error:(void (^) (NSString *errorMessage))error
                                                    failure:(void (^) (NSError *error))failure;

@end
