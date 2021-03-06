//
//  CertificationViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CertificationViewModel.h"

@implementation CertificationViewModel

+ (void)requestPost_realnameAuthNetWorkingDataWithParams:(NSDictionary *)params
                                                 success:(void (^)(id info,NSInteger count))success
                                                   error:(void (^) (NSString *errorMessage))error
                                                 failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, REALNAME_AUTH);

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
