//
//  MyEvaluateListRootModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyEvaluateListRootModel.h"

@implementation MyEvaluateListRootModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    if ([key isEqualToString:@"data"] && [value isKindOfClass:[NSArray class]]) {
        
        NSArray        *tmp      = value;
        NSMutableArray *dataList = [NSMutableArray array];
        
        for (NSDictionary *data in tmp) {
            
            MyEvaluateListData *service = [[MyEvaluateListData alloc] initWithDictionary:data];
            [dataList addObject:service];
            
        }
        
        value = dataList;
    }
    
    if ([key isEqualToString:@"commentList"] && [value isKindOfClass:[NSArray class]]) {
        
        NSArray        *tmp      = value;
        NSMutableArray *dataList = [NSMutableArray array];
        
        for (NSDictionary *data in tmp) {
            
            MyEvaluateListCommentList *service = [[MyEvaluateListCommentList alloc] initWithDictionary:data];
            [dataList addObject:service];
            
        }
        
        value = dataList;
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
