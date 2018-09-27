//
//  PublishArticleViewModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublishArticleViewModel : NSObject

/**
 *
 参数名            类型    必填    描述    默认值
 userId         string    是    用户Id     -
 tagId          string    是    问题标签    -
 title          string    是    文章标题    宝马故障风机锁
 articleInfo    string    是    文章概述    宝马故障风机锁死，什么原因，怎么解决？在线等在线等。
 creater        string    是    创建人Id    1
 artCoverImg    string    是    封面图     http://img.jpg,http:img1.jpg
 artHtmlUrl     string    是    htmlURL    http://gead.html
 source         string    是    数据类型    1 1-文章 2-咨询 3-新闻 4-视频
 */
/**
 发布文章

 @param params 上传字段
 @param success 返回成功
 @param error 上传失败
 @param failure 连接不到服务器
 */
+ (void)requestPost_publishArticleNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure;

@end
