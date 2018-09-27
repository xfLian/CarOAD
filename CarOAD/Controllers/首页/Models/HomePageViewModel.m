//
//  HomePageViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "HomePageViewModel.h"

@implementation HomePageViewModel

+ (void)requestPost_getHomePageSwitchImagesNetWorkingDataWithParams:(NSDictionary *)params
                                                    success:(void (^)(id info,NSInteger count))success
                                                      error:(void (^) (NSString *errorMessage))error
                                                    failure:(void (^) (NSError *error))failure;
{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_INDEX, SWITCH);
    
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

+ (void)requestPost_getHomePageInformationNetWorkingDataWithParams:(NSDictionary *)params
                                                           success:(void (^)(id info,NSInteger count))success
                                                             error:(void (^) (NSString *errorMessage))error
                                                           failure:(void (^) (NSError *error))failure;
{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_INDEX, INFORMATION);

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

+ (void)requestPost_getHomePageTimeNewsNetWorkingDataWithParams:(NSDictionary *)params
                                                        success:(void (^)(id info,NSInteger count))success
                                                          error:(void (^) (NSString *errorMessage))error
                                                        failure:(void (^) (NSError *error))failure;
{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_INDEX, TIMENEWS);

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

+ (void)requestPost_getHomePageRecruitListNetWorkingDataWithParams:(NSDictionary *)params
                                                           success:(void (^)(id info,NSInteger count))success
                                                             error:(void (^) (NSString *errorMessage))error
                                                           failure:(void (^) (NSError *error))failure;
{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_JOB, GET_RECRUIT_LIST);

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

+ (void)requestPost_getHomePageDemandListNetWorkingDataWithParams:(NSDictionary *)params
                                                          success:(void (^)(id info,NSInteger count))success
                                                            error:(void (^) (NSString *errorMessage))error
                                                          failure:(void (^) (NSError *error))failure;
{

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_SHOPTECH, GET_DEMAND_LIST);

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
