//
//  QTDownloadWebImage.h
//  LinJiaMaMa
//
//  Created by qiantang on 16/12/26.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTDownloadWebImage : NSObject

/**
 *
 *  为imageView下载图片
 *
 *  @pream  imageView   需要下载图片的imageView
 *
 *  @pream  imageUrl   图片的URL
 *
 *  @pream  placeholderImageString   默认图片名
 *
 */
+ (void) downloadImageForImageView:(UIImageView *)imageView
                          imageUrl:(NSURL *)url
                  placeholderImage:(NSString *)placeholderImageString
                          progress:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progress
                           success:(void (^)(UIImage *finishImage))success;

/**
 *
 *  为button下载图片
 *
 *  @pream  button   需要下载图片的button
 *
 *  @pream  imageUrl   图片的URL
 *
 *  @pream  placeholderImageString   默认图片名
 *
 */
+ (void) downloadImageForButton:(UIButton *)button
                       imageUrl:(NSURL *)url
               placeholderImage:(NSString *)placeholderImageString
                        success:(void (^)(UIImage *finishImage))success;

@end
