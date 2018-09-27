//
//  QTShareMessage.m
//  LinJiaMaMa
//
//  Created by qiantang on 16/12/20.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "QTShareMessage.h"
#import "WXApi.h"

@implementation QTShareMessage

+ (void) shareToWXSceneSessionWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image shareUrl:(NSString *)shareUrl;{

    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = title;
    message.description     = description;
    
    //设置缩略图
    [message setThumbImage:image];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl       = shareUrl;
    message.mediaObject            = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText               = NO;
    req.message             = message;
    
    //分享到微信朋友圈
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];

}


+ (void) shareToWXSceneTimelineWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image shareUrl:(NSString *)shareUrl {
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = title;
    message.description     = description;
    
    //设置缩略图
    [message setThumbImage:image];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl       = shareUrl;
    message.mediaObject            = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText               = NO;
    req.message             = message;

    //分享到微信朋友圈
    req.scene = WXSceneTimeline;

    [WXApi sendReq:req];
    
}

+ (void) shareToWXSceneFavoriteWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image shareUrl:(NSString *)shareUrl; {

    WXMediaMessage *message = [WXMediaMessage message];
    message.title           = title;
    message.description     = description;

    //设置缩略图
    [message setThumbImage:image];

    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl       = shareUrl;
    message.mediaObject            = webpageObject;

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText               = NO;
    req.message             = message;

    //分享到微信收藏
    req.scene = WXSceneFavorite;

    [WXApi sendReq:req];

}

@end
