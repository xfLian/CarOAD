//
//  OwnMainViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/5.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OwnMainViewModel.h"

@implementation OwnMainViewModel

+ (NSArray *) getListDatasArrayWithData:(id)data; {

    NSMutableArray *datasArray = [[NSMutableArray alloc] init];
    NSArray *dataArray = @[@{@"datas":@[@{@"title":@"我的评价",
                                          @"iconImage":@"comment_gray",
                                          @"type":@"",
                                          @"isShowLine":@"1"}
                                        ,@{@"title":@"我的发布",
                                           @"iconImage":@"publish_gray",
                                           @"type":@"",
                                           @"isShowLine":@"0"}]}
                           ,@{@"datas":@[@{@"title":@"实名认证",
                                           @"iconImage":@"id_gray",
                                           @"type":@"",
                                           @"isShowLine":@"1"}
                                         ,@{@"title":@"修改密码",
                                            @"iconImage":@"password_gray",
                                            @"type":@"",
                                            @"isShowLine":@"1"}
                                         ,@{@"title":@"设置",
                                            @"iconImage":@"set_gray_eight",
                                            @"type":@"",
                                            @"isShowLine":@"0"}]}];

    if (data) {

        NSDictionary *networkingData           = data;
        NSMutableArray *tmpDatasArray          = [[NSMutableArray alloc] init];
        tmpDatasArray                          = [dataArray mutableCopy];

        NSMutableDictionary *secondSectionData = [[NSMutableDictionary alloc] init];
        secondSectionData                      = [tmpDatasArray[1] mutableCopy];

        NSMutableArray *secondSectionDataArray = [NSMutableArray arrayWithArray:secondSectionData[@"datas"]];

        NSMutableDictionary *firstRowData = [[NSMutableDictionary alloc] init];
        firstRowData                      = [secondSectionDataArray[0] mutableCopy];

        NSString *isRealnameAuth = networkingData[@"isRealnameAuth"];

        if ([isRealnameAuth integerValue] == 0) {

            [firstRowData setObject:@"未认证" forKey:@"type"];

        } else if ([isRealnameAuth integerValue] == 1) {

            [firstRowData setObject:@"已认证" forKey:@"type"];

        } else if ([isRealnameAuth integerValue] == 2) {

            [firstRowData setObject:@"认证中" forKey:@"type"];

        } else if ([isRealnameAuth integerValue] == 2) {

            [firstRowData setObject:@"认证失败" forKey:@"type"];

        }

        [secondSectionDataArray replaceObjectAtIndex:0 withObject:firstRowData];
        [secondSectionData setObject:[secondSectionDataArray copy] forKey:@"datas"];
        [tmpDatasArray replaceObjectAtIndex:1 withObject:secondSectionData];
        dataArray = [tmpDatasArray copy];

    }
    datasArray = [dataArray mutableCopy];

    return datasArray;

}

+ (void)requestPost_getMyInfoNetWorkingDataWithParams:(NSDictionary *)params
                                              success:(void (^)(id info,NSInteger count))success
                                                error:(void (^) (NSString *errorMessage))error
                                              failure:(void (^) (NSError *error))failure; {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *urlString = MYPostClassUrl(CLASS_USER, MY_INFO);

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
