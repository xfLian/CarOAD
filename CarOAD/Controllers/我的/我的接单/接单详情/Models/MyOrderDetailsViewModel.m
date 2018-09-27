//
//  MyOrderDetailsViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyOrderDetailsViewModel.h"

@implementation MyOrderDetailsViewModel

+ (void)requestPost_getDemandInfoNetWorkingDataWithParams:(NSDictionary *)params
                                                       success:(void (^)(id info,NSInteger count))success
                                                         error:(void (^) (NSString *errorMessage))error
                                                       failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_SHOPTECH, GET_DEMAND_INFO);
    
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
