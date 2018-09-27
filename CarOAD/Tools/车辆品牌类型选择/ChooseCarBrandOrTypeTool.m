//
//  ChooseCarBrandOrTypeTool.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseCarBrandOrTypeTool.h"

#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CarBrandOrTypeData.plist"]

@implementation ChooseCarBrandOrTypeTool

- (void) getCarBrandOrTypeDataWithType:(NSInteger)type
                               brandId:(NSString *)brandId
                               success:(void (^)(id info,NSInteger count))success
                                 error:(void (^) (NSString *errorMessage))error
                               failure:(void (^) (NSError *error))failure; {

    /**
     *
     *  获取本地保存的车辆数据
     *
     *  1.如果本地有保存，则返回本地数据
     *   a.继续请求服务器，获取到数据后与本地数据进行比较，看是否相同
     *  2.如果本地没保存，则请求服务器获取数据，成功之后保存到本地
     *
     */
    NSArray *result = [NSArray arrayWithContentsOfFile:filePath];

    if (type == 1) {

        if (result.count > 0) {

            success(result,0);

        } else {

            [self requestPost_getCarBrandOrTypeDataWithType:1 typeId:nil success:^(id data) {

                //  直接保存省份信息到本地
                NSArray *datasArray = data;
                [datasArray writeToFile:filePath atomically:YES];
                
                success(data,0);

            } failure:^(NSString *error) {

            }];

        }

    } else if (type == 2) {

        if (result.count > 0) {

            BOOL isHaveCarBrandData = NO;
            
            for (NSDictionary *carBrandData in result) {

                NSString *tmpBrandId = carBrandData[@"brandId"];
                
                if ([tmpBrandId isEqualToString:brandId]) {

                    NSArray *typesArray = carBrandData[@"typesData"];

                    if (typesArray.count > 0) {

                        success(typesArray,0);
                        isHaveCarBrandData = YES;

                    } else {

                        isHaveCarBrandData = NO;

                    }

                }

            }

            if (isHaveCarBrandData == NO) {

                [self requestPost_getCarBrandOrTypeDataWithType:2 typeId:brandId success:^(id data) {

                    success(data,0);

                    NSArray        *datasArray     = data;
                    NSMutableArray *brandsArray = [[NSMutableArray alloc] init];

                    for (NSDictionary *brandData in result) {

                        NSString            *tmpBrandId   = brandData[@"brandId"];
                        NSMutableDictionary *tmpBrandData = [[NSMutableDictionary alloc] init];
                        tmpBrandData                      = [brandData mutableCopy];

                        if ([tmpBrandId isEqualToString:brandId]) {

                            [tmpBrandData setObject:datasArray forKey:@"typesData"];
                            [brandsArray addObject:tmpBrandData];

                        } else {

                            [brandsArray addObject:tmpBrandData];

                        }

                    }

                    [brandsArray writeToFile:filePath atomically:YES];

                } failure:^(NSString *error) {

                }];

            }

        }

    }

}

- (void) requestPost_getCarBrandOrTypeDataWithType:(NSInteger)type
                                      typeId:(NSString *)typeId
                                     success:(void (^)(id data))success
                                     failure:(void (^) (NSString *error))failure;
{

    NSDictionary *params    = nil;
    NSString     *urlString = nil;

    if (type == 1) {

        urlString = MYPostClassUrl(CLASS_SHOPTECH, GET_CAR_BRAND);

    } else if (type == 2) {

        params = @{@"brandId" : typeId};
        urlString = MYPostClassUrl(CLASS_SHOPTECH, GET_CAR_TYPE);

    }

    HttpTool *httpTool = [HttpTool sharedHttpTool];
    [httpTool cancelAllOperations];
    [httpTool lxfHttpPostWithURL:urlString params:params success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            if (type == 1) {

                NSArray *dataArray = data[@"data"];

                if (dataArray.count > 0) {

                    dispatch_async(dispatch_get_main_queue(), ^{

                        success(dataArray);

                    });

                } else {

                    failure(@"数据为空");

                }

            } else if (type == 2) {

                NSArray *tmpSecondDatasArray = data[@"data"];

                if (tmpSecondDatasArray.count > 0) {

                    NSMutableArray *typesArray = [[NSMutableArray alloc] init];

                    for (NSDictionary *model in tmpSecondDatasArray) {

                        NSMutableDictionary *typeData = [[NSMutableDictionary alloc] init];

                        typeData = [model mutableCopy];
                        [typeData setObject:typeId forKey:@"brandId"];

                        [typesArray addObject:typeData];

                    }

                    dispatch_async(dispatch_get_main_queue(), ^{

                        success(tmpSecondDatasArray);

                    });

                } else {

                    failure(@"数据为空");

                }

            }

        } else {

            failure(@"数据为空");

        }

    } failure:^(NSError *error) {

        failure(@"数据为空");

    }];

}

@end
