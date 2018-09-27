//
//  AliyunOSS_UploadMovie.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AliyunOSS_UploadMovie.h"

static NSString * const endpoint   = @"https://oss-cn-shanghai.aliyuncs.com";
static NSString * const bucketName = @"caroad";

static VODUploadClient *uploader;

@implementation AliyunOSS_UploadMovie

- (NSString *) getDateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyMMdd"];
    NSString *nowDate = [dateFormatter stringFromDate:[NSDate date]];
    
    return nowDate;
    
}

- (NSString*) stringWithUUID {
    
    CFUUIDRef uuidObj    = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

- (void) addFileWithFilePath:(NSString *)filePath title:(NSString *)title desc:(NSString *)desc coverUrl:(NSString *)coverUrl tags:(NSString *)tags {

    NSString *imageName = [NSString stringWithFormat:@"https://caroad.oss-cn-shanghai.aliyuncs.com/image/day_%@/%@.png",[self getDateString],[self stringWithUUID]];
    
    VodInfo *vodInfo = [[VodInfo alloc] init];
    vodInfo.title    = title;
    vodInfo.desc     = desc;
    vodInfo.cateId   = @(19);
    vodInfo.coverUrl = imageName;
    vodInfo.tags     = tags;
    
    [uploader addFile:filePath vodInfo:vodInfo];
    
    NSLog(@"Add file: %@", filePath);
    
}

- (NSMutableArray<UploadFileInfo *> *)listFiles {
    return [uploader listFiles];
}

- (void) clearList {
    [uploader clearFiles];
}

- (void) start {
    [uploader start];
}

- (void) stop {
    [uploader stop];
}

- (void) pause {
    [uploader pause];
}

- (void) resume {
    [uploader resume];
}

#pragma mark - temp_file
- (id) initWithListener:listener {
    
    self = [super init];
    
    if (self) {
        
        uploader = [[VODUploadClient alloc] init];

        [uploader init:listener];
    }
    
    return self;
}

- (void) setUploadAuth:(NSString *)uploadAuth uploadAddress:(NSString *)uploadAddress uploadFileInfo:(UploadFileInfo *)uploadFileInfo {

    [uploader setUploadAuthAndAddress:uploadFileInfo uploadAuth:uploadAuth uploadAddress:uploadAddress];

}

@end
