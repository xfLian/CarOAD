//
//  OADLogInViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADLogInViewModel.h"

@implementation OADLogInViewModel

+ (void)requestPost_getVerificationCodeNetWorkingDataWithParams:(NSDictionary *)params
                                                        success:(void (^)(id info,NSInteger count))success
                                                          error:(void (^) (NSString *errorMessage))error
                                                        failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, GET_VERIFICATION_CODE);

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

+ (void)requestPost_logInNetWorkingDataWithParams:(NSDictionary *)params
                                          success:(void (^)(id info,NSInteger count))success
                                            error:(void (^) (NSString *errorMessage))error
                                          failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, USER_LOGIN);

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

+ (void)requestPost_registerNetWorkingDataWithParams:(NSDictionary *)params
                                             success:(void (^)(id info,NSInteger count))success
                                               error:(void (^) (NSString *errorMessage))error
                                             failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, USER_SIGN_IN);

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


+ (void)requestPost_findPasswordNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, MODIFY_NEW_PWD);

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

+ (void)requestPost_changePwdNetWorkingDataWithParams:(NSDictionary *)params
                                              success:(void (^)(id info,NSInteger count))success
                                                error:(void (^) (NSString *errorMessage))error
                                              failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, CHANGE_PWD);

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
