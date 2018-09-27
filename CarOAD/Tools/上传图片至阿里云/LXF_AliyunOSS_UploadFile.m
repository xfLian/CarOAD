//
//  LXF_AliyunOSS_UploadFile.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "LXF_AliyunOSS_UploadFile.h"
#import <AliyunOSSiOS/OSSService.h>

@implementation LXF_AliyunOSS_UploadFile

static NSString *const BucketName = @"caroad";
static NSString *const AliYunHost = @"https://oss-cn-shanghai.aliyuncs.com";
static NSString *kTempFolder      = @"multipartUploadObject";

+ (void)asyncUploadFile:(NSData *)file complete:(void(^)(NSArray<NSString *> *names,UploadFileState state))complete;
{
    [self uploadFiles:@[file] isAsync:YES complete:complete];
}

+ (void)syncUploadFile:(NSData *)file complete:(void(^)(NSArray<NSString *> *names,UploadFileState state))complete;
{
    [self uploadFiles:@[file] isAsync:NO complete:complete];
}

+ (void)asyncUploadFiles:(NSArray<NSData *> *)files complete:(void(^)(NSArray<NSString *> *names, UploadFileState state))complete;
{
    [self uploadFiles:files isAsync:YES complete:complete];
}

+ (void)syncUploadFiles:(NSArray<NSData *> *)files complete:(void(^)(NSArray<NSString *> *names, UploadFileState state))complete;
{
    [self uploadFiles:files isAsync:NO complete:complete];
}

- (NSString*) stringWithUUID {

    CFUUIDRef    uuidObj    = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

+ (void)uploadFiles:(NSArray<NSData *> *)files isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadFileState state))complete
{

    NSString *urlString = @"oss/ossToken";
    HttpTool *httpTool  = [HttpTool sharedHttpTool];
    
    [httpTool lxfHttpPostWithURL:urlString params:nil success:^(id data) {
        
        NSArray      *arr = [data objectForKey:@"data"];
        NSDictionary *dic = [arr firstObject];
        
        id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
            
            //  您需要在这里实现获取一个FederationToken，并构造成OSSFederationToken对象返回
            //  如果因为某种原因获取失败，可直接返回nil
            OSSFederationToken *token       = [OSSFederationToken new];
            token.tToken                    = [dic objectForKey:@"SecurityToken"];
            token.tAccessKey                = [dic objectForKey:@"AccessKeyId"];
            token.tSecretKey                = [dic objectForKey:@"AccessKeySecret"];
            token.expirationTimeInGMTFormat = [dic objectForKey:@"Expiration"];
            return token;
            
        }];
        
        OSSClient *client = [[OSSClient alloc] initWithEndpoint:AliYunHost credentialProvider:credential];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = files.count;
        
        NSMutableArray *callBackNames = [NSMutableArray array];
        int i = 0;
        for (NSData *file in files) {
            if (file) {
                NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                    //任务执行
                    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
                    put.bucketName           = BucketName;

                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyMMdd"];
                    NSString *nowDate = [dateFormatter stringFromDate:[NSDate date]];

                    CFUUIDRef    uuidObj    = CFUUIDCreate(nil);//create a new UUID
                    //get the string representation of the UUID
                    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
                    CFRelease(uuidObj);

                    NSString *fileName = [NSString stringWithFormat:@"html/day_%@/%@.html",nowDate,uuidString];
                    put.objectKey = fileName;

                    [callBackNames addObject:[NSString stringWithFormat:@"https://caroad.oss-cn-shanghai.aliyuncs.com/%@",fileName]];
                    put.uploadingData = file;

                    OSSTask * putTask = [client putObject:put];
                    [putTask waitUntilFinished]; // 阻塞直到上传完成
                    if (!putTask.error) {
                        NSLog(@"upload object success!");
                    } else {
                        NSLog(@"upload object failed, error: %@" , putTask.error);
                    }
                    if (isAsync) {
                        if (file == files.lastObject) {
                            NSLog(@"upload object finished!");
                            if (complete) {
                                complete([NSArray arrayWithArray:callBackNames] ,UploadFileSuccess);
                            }
                        }
                    }
                }];
                if (queue.operations.count != 0) {
                    [operation addDependency:queue.operations.lastObject];
                }
                [queue addOperation:operation];
            }
            i++;
        }
        if (!isAsync) {
            [queue waitUntilAllOperationsAreFinished];
            NSLog(@"haha");
            if (complete) {
                if (complete) {
                    complete([NSArray arrayWithArray:callBackNames], UploadFileSuccess);
                }
            }
        }

    } failure:^(NSError *error) {

        CarOadLog(@"error --- %@",error);

    }];

}

@end
