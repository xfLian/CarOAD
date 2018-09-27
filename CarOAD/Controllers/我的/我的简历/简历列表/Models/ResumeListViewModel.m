//
//  ResumeListViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ResumeListViewModel.h"

@implementation ResumeListViewModel

+ (void)requestPost_getResumeListNetWorkingDataWithParams:(NSDictionary *)params
                                                  success:(void (^)(id info,NSInteger count))success
                                                    error:(void (^) (NSString *errorMessage))error
                                                  failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_JOB, GET_CV_LIST);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error([data valueForKey:@"msg"]);

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

+ (void)requestPost_refreshCVNetWorkingDataWithParams:(NSDictionary *)params
                                              success:(void (^)(id info,NSInteger count))success
                                                error:(void (^) (NSString *errorMessage))error
                                              failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, REFRESH_CV);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error([data valueForKey:@"msg"]);

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

+ (void)requestPost_deleteCVNetWorkingDataWithParams:(NSDictionary *)params
                                             success:(void (^)(id info,NSInteger count))success
                                               error:(void (^) (NSString *errorMessage))error
                                             failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, DEL_CV);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error([data valueForKey:@"msg"]);

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];

}

+ (void)requestPost_createCVNetWorkingDataWithParams:(NSDictionary *)params
                                             success:(void (^)(id info,NSInteger count))success
                                               error:(void (^) (NSString *errorMessage))error
                                             failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, ADD_RESUME);

    HttpTool *httpTool = [HttpTool sharedHttpTool];

    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (success) {

                success(data,0);

            }

        } else {

            if (error) {

                error([data valueForKey:@"msg"]);

            }

        }

    } failure:^(NSError *error) {

        if (failure) {

            failure(error);

        }

    }];


}

@end
