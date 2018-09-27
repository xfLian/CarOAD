//
//  IWantToOrderViewModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "IWantToOrderViewModel.h"

@implementation IWantToOrderViewModel

+ (void)requestPost_addOrderMsgNetWorkingDataWithParams:(NSDictionary *)params
                                                    success:(void (^)(id info,NSInteger count))success
                                                      error:(void (^) (NSString *errorMessage))error
                                                    failure:(void (^) (NSError *error))failure; {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *urlString = MYPostClassUrl(CLASS_SHOPTECH, ADD_ORDER_MSG);
    
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    [httpTool lxfHttpPostWithURL:urlString params:paramsDic success:^(id data) {
        CarOadLog(@"info --- %@",data);
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
