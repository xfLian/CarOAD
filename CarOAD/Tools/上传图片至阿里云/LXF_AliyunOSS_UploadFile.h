//
//  LXF_AliyunOSS_UploadFile.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UploadFileState) {
    UploadFileFailed   = 0,
    UploadFileSuccess  = 1
};

@interface LXF_AliyunOSS_UploadFile : NSObject

+ (void)asyncUploadFile:(NSData *)file complete:(void(^)(NSArray<NSString *> *names,UploadFileState state))complete;

+ (void)syncUploadFile:(NSData *)file complete:(void(^)(NSArray<NSString *> *names,UploadFileState state))complete;

+ (void)asyncUploadFiles:(NSArray<NSData *> *)files complete:(void(^)(NSArray<NSString *> *names, UploadFileState state))complete;

+ (void)syncUploadFiles:(NSArray<NSData *> *)files complete:(void(^)(NSArray<NSString *> *names, UploadFileState state))complete;

@end
