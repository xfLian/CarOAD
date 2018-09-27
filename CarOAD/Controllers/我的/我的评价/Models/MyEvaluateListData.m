//
//  MyEvaluateListData.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyEvaluateListData.h"

@implementation MyEvaluateListData

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
        
    }
    
    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        if (self = [super init]) {
            
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    
    return self;
}

@end
