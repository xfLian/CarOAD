//
//  OrderMessageListViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OrderMessageListViewModel.h"

@implementation OrderMessageListViewModel

+ (void)requestPost_getSkillOrderListNetWorkingDataWithParams:(NSDictionary *)params
                                                     success:(void (^)(id info,NSInteger count))success
                                                       error:(void (^) (NSString *errorMessage))error
                                                     failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_USER, GET_SKILL_ORDER_LIST);
    
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

+ (void)requestPost_modifySkillOrderNetWorkingDataWithParams:(NSDictionary *)params
                                                     success:(void (^)(id info,NSInteger count))success
                                                       error:(void (^) (NSString *errorMessage))error
                                                     failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_USER, MODIFY_SKILL_ORDER);
    
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
