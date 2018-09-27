//
//  CommunityAnswerListViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/28.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

/**
 *  转换问答、视频、文章等评论详情页面回复列表数据
 */

#import <Foundation/Foundation.h>

@interface CommunityAnswerListViewModel : NSObject

@property (nonatomic, assign) NSInteger cell_row;

/**
 回复ID
 */
@property (nonatomic, strong) NSString *replyId;

/**
 用户头像
 */
@property (nonatomic, strong) NSString *userImg;

/**
 用户名称
 */
@property (nonatomic, strong) NSString *userName;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *createDate;

/**
 评论内容
 */
@property (nonatomic, strong) NSString *ansContent;

/**
 是否点击查看按钮
 */
@property (nonatomic, assign) BOOL     isClickChackButton;

//  转换问答评论列表数据
+ (CommunityAnswerListViewModel *) getQACommunityListData:(id)data;

//  转换其他评论列表数据
+ (CommunityAnswerListViewModel *) getQTCommunityListData:(id)data;

/**
 获取问答评论回复列表

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getQACommentAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                           success:(void (^)(id info,NSInteger count))success
                                                             error:(void (^) (NSString *errorMessage))error
                                                           failure:(void (^) (NSError *error))failure;

/**
 回复问答评论

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_publishQACommentAnswerNetWorkingDataWithParams:(NSDictionary *)params
                                                           success:(void (^)(id info,NSInteger count))success
                                                             error:(void (^) (NSString *errorMessage))error
                                                           failure:(void (^) (NSError *error))failure;

/**
 问答评论回复的回复

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_publishQAReplyCommentNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure;

/**
 文章评论回复列表数据 （视频、文章、新闻、资讯使用同一个详情评论回复列表接口、根据传入的tag值不同获取相应的数据）

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_getQTAnswerCommunityListNetWorkingDataWithParams:(NSDictionary *)params
                                                             success:(void (^)(id info,NSInteger count))success
                                                               error:(void (^) (NSString *errorMessage))error
                                                             failure:(void (^) (NSError *error))failure;

/**
 发表评论回复 （回复视频、文章、新闻、资讯评论使用同一个回复接口、传入不同的source值）

 @param params 上传参数
 @param success 成功回调
 @param error 错误回调
 @param failure 接口失败回调
 */
+ (void)requestPost_publishQTReplyCommentArtNetWorkingDataWithParams:(NSDictionary *)params
                                                             success:(void (^)(id info,NSInteger count))success
                                                               error:(void (^) (NSString *errorMessage))error
                                                             failure:(void (^) (NSError *error))failure;

@end
