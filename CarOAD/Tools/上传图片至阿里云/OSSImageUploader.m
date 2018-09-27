//
//  OSSImageUploader.m
//  OSSImsgeUpload
//
//  Created by cysu on 5/31/16.
//  Copyright © 2016 cysu. All rights reserved.
//

#import "OSSImageUploader.h"

@implementation OSSImageUploader

static NSString *const BucketName = @"caroad";
static NSString *const AliYunHost = @"https://oss-cn-shanghai.aliyuncs.com";
static NSString *kTempFolder      = @"multipartUploadObject";

+ (void)asyncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:YES complete:complete];
}

+ (void)syncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:NO complete:complete];
}

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    [self uploadImages:images isAsync:YES complete:complete];
}

+ (void)syncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
    [self uploadImages:images isAsync:NO complete:complete];
}

- (NSString*) stringWithUUID {
    
    CFUUIDRef    uuidObj    = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
    
}

+ (void)uploadImages:(NSArray<UIImage *> *)images isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
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
        queue.maxConcurrentOperationCount = images.count;
        
        NSMutableArray *callBackNames = [NSMutableArray array];
        int i = 0;
        for (UIImage *image in images) {
            if (image) {
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
                    
                    NSString *imageName = [NSString stringWithFormat:@"image/day_%@/%@.png",nowDate,uuidString];
                    put.objectKey = imageName;
                    [callBackNames addObject:[NSString stringWithFormat:@"https://caroad.oss-cn-shanghai.aliyuncs.com/%@",imageName]];
                    NSData *data = UIImageJPEGRepresentation(image, 0.8);
                    put.uploadingData = data;
                    
                    OSSTask * putTask = [client putObject:put];
                    [putTask waitUntilFinished]; // 阻塞直到上传完成
                    if (!putTask.error) {
                        NSLog(@"upload object success!");
                    } else {
                        NSLog(@"upload object failed, error: %@" , putTask.error);
                    }
                    if (isAsync) {
                        if (image == images.lastObject) {
                            NSLog(@"upload object finished!");
                            if (complete) {
                                complete([NSArray arrayWithArray:callBackNames] ,UploadImageSuccess);
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
                    complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
                }
            }
        }
        
    } failure:^(NSError *error) {
        
        CarOadLog(@"error --- %@",error);
        
    }];
    
}


@end
