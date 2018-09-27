//
//  AliyunOSS_UploadMovie.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoFileInfo : UploadFileInfo
@property NSInteger percent;
@end

@interface AliyunOSS_UploadMovie : NSObject

- (id) initWithListener:listener;

//  添加上传文件
- (void) addFileWithFilePath:(NSString *)filePath title:(NSString *)title desc:(NSString *)desc coverUrl:(NSString *)coverUrl tags:(NSString *)tags;
//  获取上传文件列表
- (NSMutableArray<UploadFileInfo *> *)listFiles;
//  清空上传文件
- (void) clearList;

//  开始上传
- (void) start;
//  停止
- (void) stop;
//  添暂停
- (void) pause;
//  恢复
- (void) resume;

- (void) setUploadAuth:(NSString *)uploadAuth uploadAddress:(NSString *)uploadAddress uploadFileInfo:(UploadFileInfo *)uploadFileInfo;

@end
