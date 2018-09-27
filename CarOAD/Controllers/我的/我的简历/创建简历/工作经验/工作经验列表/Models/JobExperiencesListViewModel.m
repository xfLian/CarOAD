//
//  JobExperiencesListViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/17.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "JobExperiencesListViewModel.h"

@implementation JobExperiencesListViewModel

+ (void)requestPost_getWorkExpNetWorkingDataWithParams:(NSDictionary *)params
                                               success:(void (^)(id info,NSInteger count))success
                                                 error:(void (^) (NSString *errorMessage))error
                                               failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_USER, GET_WORK_EXP);
    
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

+ (void)requestPost_deleteWorkExpNetWorkingDataWithParams:(NSDictionary *)params
                                               success:(void (^)(id info,NSInteger count))success
                                                 error:(void (^) (NSString *errorMessage))error
                                               failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_USER, DELETE_WORK_EXP);
    
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
