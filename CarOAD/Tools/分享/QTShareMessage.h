//
//  QTShareMessage.h
//  LinJiaMaMa
//
//  Created by qiantang on 16/12/20.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTShareMessage : NSObject

/**
 *  分享到微信好友
 *
 *  @param title 分享标题
 *
 *  @param description 分享描述
 *  
 *  @param image 分享的头像
 *
 *  @param shareUrl 分享链接
 *
 *
 */
+ (void) shareToWXSceneSessionWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image shareUrl:(NSString *)shareUrl;

/**
 *  分享到微信朋友圈
 *
 *  @param title 分享标题
 *
 *  @param description 分享描述
 *
 *  @param image 分享的头像
 *
 *  @param shareUrl 分享链接
 *
 *
 */
+ (void) shareToWXSceneTimelineWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image shareUrl:(NSString *)shareUrl;



/**
 *  分享到微信收藏
 *
 *  @param title 分享标题
 *
 *  @param description 分享描述
 *
 *  @param image 分享的头像
 *
 *  @param shareUrl 分享链接
 *
 *
 */
+ (void) shareToWXSceneFavoriteWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image shareUrl:(NSString *)shareUrl;

@end
