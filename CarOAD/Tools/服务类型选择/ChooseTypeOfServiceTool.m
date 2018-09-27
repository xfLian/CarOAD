//
//  ChooseTypeOfServiceTool.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/23.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseTypeOfServiceTool.h"

#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TypeOfServiceData.plist"]

@implementation ChooseTypeOfServiceTool

- (void) getTypeOfServiceDataWithType:(NSInteger)type
                           categoryId:(NSString *)categoryId
                             catenaId:(NSString *)catenaId
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
            
            [self requestPost_getTypeOfServiceDataWithType:1 typeId:nil success:^(id data) {
                
                //  直接保存省份信息到本地
                NSArray *datasArray = data;
                [datasArray writeToFile:filePath atomically:YES];
                
                success(data,0);
                
            } failure:^(NSString *error) {
                
            }];
            
        }
        
    } else if (type == 2) {
        
        if (result.count > 0) {
            
            BOOL isHaveTypeOfServiceData = NO;
            
            for (NSDictionary *categoryData in result) {
                
                NSString *tmpCategoryId = categoryData[@"categoryId"];
                
                if ([tmpCategoryId isEqualToString:categoryId]) {
                    
                    NSArray *catenasArray = categoryData[@"catenasArray"];
                    
                    if (catenasArray.count > 0) {
                        
                        success(catenasArray,0);
                        isHaveTypeOfServiceData = YES;
                        
                    } else {
                        
                        isHaveTypeOfServiceData = NO;
                        
                    }
                    
                }
                
            }
            
            if (isHaveTypeOfServiceData == NO) {
                
                [self requestPost_getTypeOfServiceDataWithType:2 typeId:categoryId success:^(id data) {
                    
                    success(data,0);
                    
                    NSArray        *datasArray     = data;
                    NSMutableArray *categorysArray = [[NSMutableArray alloc] init];
                    
                    for (NSDictionary *categoryData in result) {
                        
                        NSString            *tmpCategoryId   = categoryData[@"categoryId"];
                        NSMutableDictionary *tmpCategoryData = [[NSMutableDictionary alloc] init];
                        tmpCategoryData                      = [categoryData mutableCopy];
                        
                        if ([tmpCategoryId isEqualToString:categoryId]) {
                            
                            [tmpCategoryData setObject:datasArray forKey:@"catenasArray"];
                            [categorysArray addObject:tmpCategoryData];
                            
                        } else {
                            
                            [categorysArray addObject:tmpCategoryData];
                            
                        }
                        
                    }
                    
                    [categorysArray writeToFile:filePath atomically:YES];
                    
                } failure:^(NSString *error) {
                    
                }];
                
            }
            
        }
        
    } else if (type == 3) {
        
        if (result.count > 0) {
            
            BOOL isHaveCatenaData = NO;
            
            for (NSDictionary *categoryData in result) {
                
                NSString *tmpCategoryId = categoryData[@"categoryId"];
                
                if ([tmpCategoryId isEqualToString:categoryId]) {
                    
                    NSArray *catenasArray = categoryData[@"catenasArray"];
                    
                    if (catenasArray.count > 0) {
                        
                        for (NSDictionary *catenaData in catenasArray) {
                            
                            NSString *tmpCatenaId = catenaData[@"catenaId"];
                            
                            if ([tmpCatenaId isEqualToString:catenaId]) {
                                
                                NSArray *categoryInfoArray = catenaData[@"categoryInfoArray"];
                                
                                if (categoryInfoArray.count > 0) {
                                    
                                    success(categoryInfoArray,0);
                                    isHaveCatenaData = YES;
                                    
                                } else {
                                    
                                    isHaveCatenaData = NO;
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if (isHaveCatenaData == NO) {
                
                [self requestPost_getTypeOfServiceDataWithType:3 typeId:catenaId success:^(id data) {
                                        
                    success(data,0);
                    
                    NSArray *datasArray = data;
                    
                    NSMutableArray *categorysArray = [[NSMutableArray alloc] init];
                    
                    for (NSDictionary *categoryData in result) {
                        
                        NSString *tmpCategoryId = categoryData[@"categoryId"];
                        NSMutableDictionary *tmpCategoryData = [[NSMutableDictionary alloc] init];
                        tmpCategoryData                      = [categoryData mutableCopy];
                        
                        if ([tmpCategoryId isEqualToString:categoryId]) {
                            
                            NSArray *catenasArray = categoryData[@"catenasArray"];
                            
                            if (catenasArray.count > 0) {
                                
                                NSMutableArray *tmpCatenasArray = [[NSMutableArray alloc] init];
                                
                                for (NSDictionary *catenaData in catenasArray) {
                                    
                                    NSString *tmpCatenaId = catenaData[@"catenaId"];
                                    
                                    NSMutableDictionary *tmpCatenaData = [[NSMutableDictionary alloc] init];
                                    tmpCatenaData                      = [catenaData mutableCopy];
                                    
                                    if ([tmpCatenaId isEqualToString:catenaId]) {
                                        
                                        [tmpCatenaData setObject:datasArray forKey:@"categoryInfoArray"];
                                        [tmpCatenasArray addObject:tmpCatenaData];
                                        
                                    } else {
                                        
                                        [tmpCatenasArray addObject:tmpCatenaData];
                                        
                                    }
                                    
                                }
                                
                                [tmpCategoryData setObject:tmpCatenasArray forKey:@"catenasArray"];
                                
                            }
                            
                            [categorysArray addObject:tmpCategoryData];
                            
                        } else {
                            
                            [categorysArray addObject:tmpCategoryData];
                            
                        }
                        
                    }
                    
                    [categorysArray writeToFile:filePath atomically:YES];
                    
                } failure:^(NSString *error) {
                    
                }];
                
            }
            
        }
        
    }
    
}

- (void) requestPost_getTypeOfServiceDataWithType:(NSInteger)type
                                      typeId:(NSString *)typeId
                                     success:(void (^)(id data))success
                                     failure:(void (^) (NSString *error))failure;
{
    
    NSDictionary *params    = nil;
    NSString     *urlString = nil;
    
    if (type == 1) {
        
        urlString = MYPostClassUrl(CLASS_USER, GET_GATEGORY);
        
    } else if (type == 2) {
        
        params = @{@"categoryId" : typeId};
        urlString = MYPostClassUrl(CLASS_USER, GET_CATENA);
        
    } else if (type == 3) {
        
        params = @{@"catenaId" : typeId};
        urlString = MYPostClassUrl(CLASS_USER, GET_GATEGORY_INFO);
        
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
                    NSString     *categoryId = model[@"categoryId"];
                    
                    if (categoryId.length > 0) {
                        
                        if ([typeId isEqualToString:categoryId]) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                success(tmpSecondDatasArray);
                                
                            });
                            
                        }
                        
                    }
                    
                } else if (tmpSecondDatasArray.count == 1) {
                    
                    NSDictionary *model      = tmpSecondDatasArray[0];
                    NSString     *categoryId = model[@"categoryId"];
                    
                    if (categoryId.length > 0) {
                        
                        if ([typeId isEqualToString:categoryId]) {
                            
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
                    
                    NSDictionary *model    = tmpThirdDatasArray[1];
                    NSString     *catenaId = model[@"catenaId"];
                    
                    if ([typeId isEqualToString:catenaId]) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            success(tmpThirdDatasArray);
                            
                        });
                        
                    }
                    
                } else if (tmpThirdDatasArray.count == 1) {
                    
                    NSDictionary *model    = tmpThirdDatasArray[0];
                    NSString     *catenaId = model[@"catenaId"];
                    
                    if ([typeId isEqualToString:catenaId]) {
                        
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
