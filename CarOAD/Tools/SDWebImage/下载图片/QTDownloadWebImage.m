//
//  QTDownloadWebImage.m
//  LinJiaMaMa
//
//  Created by qiantang on 16/12/26.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "QTDownloadWebImage.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@implementation QTDownloadWebImage

+ (void) downloadImageForImageView:(UIImageView *)imageView imageUrl:(NSURL *)url placeholderImage:(NSString *)placeholderImageString progress:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progress success:(void (^)(UIImage *finishImage))success; {

    if ([url.scheme isEqualToString:@"https"]) {

        [imageView sd_setImageWithURL:url
                     placeholderImage:[UIImage imageNamed:placeholderImageString]
                              options:SDWebImageRetryFailed|SDWebImageProgressiveDownload|SDWebImageAllowInvalidSSLCertificates
                             progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

                                 progress(receivedSize, expectedSize);

                             }
                            completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

                                success(image);

                            }];
        
    } else {

        [imageView sd_setImageWithURL:url
                     placeholderImage:[UIImage imageNamed:placeholderImageString]
                              options:SDWebImageRetryFailed|SDWebImageProgressiveDownload
                             progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

                                 progress(receivedSize, expectedSize);

                             }
                            completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

                                success(image);

                            }];
        
    }

}

+ (void) downloadImageForButton:(UIButton *)button imageUrl:(NSURL *)url placeholderImage:(NSString *)placeholderImageString success:(void (^)(UIImage *finishImage))success; {

    if ([url.scheme isEqualToString:@"https"]) {
        
        [button sd_setImageWithURL:url
                          forState:UIControlStateNormal
                  placeholderImage:[UIImage imageNamed:placeholderImageString]
                           options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageAllowInvalidSSLCertificates|SDWebImageCacheMemoryOnly
                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             
                             success(image);
                             
                         }];
        
    } else {
        
        [button sd_setImageWithURL:url
                          forState:UIControlStateNormal
                  placeholderImage:[UIImage imageNamed:placeholderImageString]
                           options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageCacheMemoryOnly
                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             
                             success(image);
                            
                         }];
        
    }


}

@end
