//
//  CommunityMainViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityMainViewModel.h"

@implementation CommunityMainViewModel

+ (void)requestPost_getTagListNetWorkingDataWithParams:(NSDictionary *)params
                                               success:(void (^)(id info,NSInteger count))success
                                                 error:(void (^) (NSString *errorMessage))error
                                               failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_TAG_LIST);
    
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {
        
        NSString *result = [data valueForKey:@"result"];
        
        if ([result integerValue] == 1) {
            
            if (success) {
                
                success(data,0);
                
            }
            
        } else {
            
            if (error) {
                
                error(@"数据为空");
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
}

+ (void)requestPost_questionAndAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_QA_LIST);
    
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {
                
        NSString *result = [data valueForKey:@"result"];
        
        if ([result integerValue] == 1) {
            
            if (success) {
                
                success(data,0);
                
            }
            
        } else {
            
            if (error) {
                
                error(@"数据为空");
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
}

+ (void)requestPost_getVideoListNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_VIDEO_LIST);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error(@"数据为空");

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

+ (void)requestPost_getArticleListNetWorkingDataWithParams:(NSDictionary *)params
                                                   success:(void (^)(id info,NSInteger count))success
                                                     error:(void (^) (NSString *errorMessage))error
                                                   failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_ARTICLE_LIST);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error(@"数据为空");

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

//  获取视频播放凭证
+ (void)requestPost_getVideoPlayAuthNetWorkingDataWithParams:(NSDictionary *)params
                                                     success:(void (^)(id info,NSInteger count))success
                                                       error:(void (^) (NSString *errorMessage))error
                                                     failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_INDEX, GET_VIDEO_PLAY_PATH);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error(@"数据为空");

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

+ (void)requestPost_getMyPublishQuestionAndAnswerListNetWorkingDataWithParams:(NSDictionary *)params
                                                                      success:(void (^)(id info,NSInteger count))success
                                                                        error:(void (^) (NSString *errorMessage))error
                                                                      failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_MY_SELF_QA_LIST);
    
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {
        
        NSString *result = [data valueForKey:@"result"];
        
        if ([result integerValue] == 1) {
            
            if (success) {
                
                success(data,0);
                
            }
            
        } else {
            
            if (error) {
                
                error(@"数据为空");
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
}

+ (void)requestPost_getMyPublishVideoListNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_MY_SELF_VIDEO_LIST);
    
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {
        
        NSString *result = [data valueForKey:@"result"];
        
        if ([result integerValue] == 1) {
            
            if (success) {
                
                success(data,0);
                
            }
            
        } else {
            
            if (error) {
                
                error(@"数据为空");
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
}

+ (void)requestPost_getMyPublishArticleListNetWorkingDataWithParams:(NSDictionary *)params
                                                            success:(void (^)(id info,NSInteger count))success
                                                              error:(void (^) (NSString *errorMessage))error
                                                            failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_COMMUNITY, GET_MY_SELF_ARTICLE_LIST);
    
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {
        
        NSString *result = [data valueForKey:@"result"];
        
        if ([result integerValue] == 1) {
            
            if (success) {
                
                success(data,0);
                
            }
            
        } else {
            
            if (error) {
                
                error(@"数据为空");
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
}

@end
