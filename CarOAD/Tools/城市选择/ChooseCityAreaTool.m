//
//  ChooseCityAreaTool.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseCityAreaTool.h"

#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CityData.plist"]

@implementation ChooseCityAreaTool

- (void) getCityAreaDataWithType:(NSInteger)type
                      provinceId:(NSString *)provinceId
                          cityId:(NSString *)cityId
                         success:(void (^)(id info,NSInteger count))success
                           error:(void (^) (NSString *errorMessage))error
                         failure:(void (^) (NSError *error))failure; {

    /**
     *
     *  获取本地保存的城市数据
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

            [self requestPost_getCityAreaDataWithType:1 typeId:nil success:^(id data) {

                //  直接保存省份信息到本地
                NSArray *datasArray = data;
                [datasArray writeToFile:filePath atomically:YES];
                
                success(data,0);

            } failure:^(NSString *error) {

            }];
            
        }

    } else if (type == 2) {

        if (result.count > 0) {

            BOOL isHaveCityData = NO;

            for (NSDictionary *provinceData in result) {

                NSString *tmpProvinceId = provinceData[@"provinceid"];

                if ([tmpProvinceId isEqualToString:provinceId]) {

                    NSArray *citysArray = provinceData[@"citysArray"];
                    
                    if (citysArray.count > 0) {

                        success(citysArray,0);
                        isHaveCityData = YES;

                    } else {

                        isHaveCityData = NO;

                    }

                }

            }

            if (isHaveCityData == NO) {
                
                [self requestPost_getCityAreaDataWithType:2 typeId:provinceId success:^(id data) {

                    success(data,0);

                    NSArray        *datasArray     = data;
                    NSMutableArray *provincesArray = [[NSMutableArray alloc] init];

                    for (NSDictionary *provinceData in result) {

                        NSString            *tmpProvinceId   = provinceData[@"provinceid"];
                        NSMutableDictionary *tmpProvinceData = [[NSMutableDictionary alloc] init];
                        tmpProvinceData                      = [provinceData mutableCopy];

                        if ([tmpProvinceId isEqualToString:provinceId]) {
                            
                            [tmpProvinceData setObject:datasArray forKey:@"citysArray"];
                            [provincesArray addObject:tmpProvinceData];

                        } else {

                            [provincesArray addObject:tmpProvinceData];

                        }

                    }

                    [provincesArray writeToFile:filePath atomically:YES];

                } failure:^(NSString *error) {

                }];

            }

        }

    } else if (type == 3) {

        if (result.count > 0) {

            BOOL isHaveAreaData = NO;

            for (NSDictionary *provinceData in result) {

                NSString *tmpProvinceId = provinceData[@"provinceid"];

                if ([tmpProvinceId isEqualToString:provinceId]) {

                    NSArray *citysArray = provinceData[@"citysArray"];

                    if (citysArray.count > 0) {

                        for (NSDictionary *cityData in citysArray) {

                            NSString *tmpCityId = cityData[@"cityid"];

                            if ([tmpCityId isEqualToString:cityId]) {

                                NSArray *areasArray = cityData[@"areasArray"];

                                if (areasArray.count > 0) {

                                    success(areasArray,0);
                                    isHaveAreaData = YES;

                                } else {

                                    isHaveAreaData = NO;

                                }

                            }

                        }

                    }

                }

            }

            if (isHaveAreaData == NO) {

                [self requestPost_getCityAreaDataWithType:3 typeId:cityId success:^(id data) {

                    success(data,0);

                    NSArray *datasArray = data;

                    NSMutableArray *provincesArray = [[NSMutableArray alloc] init];

                    for (NSDictionary *provinceData in result) {

                        NSString *tmpProvinceId = provinceData[@"provinceid"];
                        NSMutableDictionary *tmpProvinceData = [[NSMutableDictionary alloc] init];
                        tmpProvinceData                      = [provinceData mutableCopy];

                        if ([tmpProvinceId isEqualToString:provinceId]) {

                            NSArray *citysArray = provinceData[@"citysArray"];

                            if (citysArray.count > 0) {

                                NSMutableArray *tmpCitysArray = [[NSMutableArray alloc] init];

                                for (NSDictionary *cityData in citysArray) {

                                    NSString *tmpCityId = cityData[@"cityid"];

                                    NSMutableDictionary *tmpCityData = [[NSMutableDictionary alloc] init];
                                    tmpCityData                      = [cityData mutableCopy];

                                    if ([tmpCityId isEqualToString:cityId]) {

                                        [tmpCityData setObject:datasArray forKey:@"areasArray"];
                                        [tmpCitysArray addObject:tmpCityData];

                                    } else {

                                        [tmpCitysArray addObject:tmpCityData];

                                    }

                                }

                                [tmpProvinceData setObject:tmpCitysArray forKey:@"citysArray"];

                            }

                            [provincesArray addObject:tmpProvinceData];

                        } else {

                            [provincesArray addObject:tmpProvinceData];

                        }

                    }

                    [provincesArray writeToFile:filePath atomically:YES];

                } failure:^(NSString *error) {

                }];

            }

        }

    }

}

- (void) requestPost_getCityAreaDataWithType:(NSInteger)type
                                      typeId:(NSString *)typeId
                                     success:(void (^)(id data))success
                                     failure:(void (^) (NSString *error))failure;
{

    NSDictionary *params    = nil;
    NSString     *urlString = nil;

    if (type == 1) {

        urlString = MYPostClassUrl(CLASS_SHOPTECH, GET_PROVINCES_LIST);

    } else if (type == 2) {

        params = @{@"provinceId" : typeId};
        urlString = MYPostClassUrl(CLASS_SHOPTECH, GET_CITY_BY_PROCINCES_ID);

    } else if (type == 3) {

        params = @{@"cityid" : typeId};
        urlString = MYPostClassUrl(CLASS_SHOPTECH, GET_AREAS_BY_CITY_ID);

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

                if (tmpSecondDatasArray.count > 1) {

                    NSDictionary *model      = tmpSecondDatasArray[1];
                    NSString     *provinceId = model[@"provinceid"];

                    if (provinceId.length > 0) {

                        if ([typeId isEqualToString:provinceId]) {

                            dispatch_async(dispatch_get_main_queue(), ^{

                                success(tmpSecondDatasArray);

                            });

                        }

                    }

                } else if (tmpSecondDatasArray.count == 1) {

                    NSDictionary *model      = tmpSecondDatasArray[0];
                    NSString     *provinceId = model[@"provinceid"];

                    if (provinceId.length > 0) {

                        if ([typeId isEqualToString:provinceId]) {

                            dispatch_async(dispatch_get_main_queue(), ^{

                                success(tmpSecondDatasArray);

                            });

                        }

                    }

                } else {

                    failure(@"数据为空");

                }

            } else if (type == 3) {

                NSArray *tmpThirdDatasArray = data[@"data"];

                if (tmpThirdDatasArray.count > 1) {

                    NSDictionary *model  = tmpThirdDatasArray[1];
                    NSString     *cityid = model[@"cityid"];

                    if ([typeId isEqualToString:cityid]) {

                        dispatch_async(dispatch_get_main_queue(), ^{

                            success(tmpThirdDatasArray);

                        });

                    }

                } else if (tmpThirdDatasArray.count == 1) {

                    NSDictionary *model  = tmpThirdDatasArray[0];
                    NSString     *cityid = model[@"cityid"];

                    if ([typeId isEqualToString:cityid]) {

                        dispatch_async(dispatch_get_main_queue(), ^{

                            success(tmpThirdDatasArray);

                        });

                    }

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
