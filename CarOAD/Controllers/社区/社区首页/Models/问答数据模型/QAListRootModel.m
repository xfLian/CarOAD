//
//  QAListRootModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QAListRootModel.h"

@implementation QAListRootModel

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
            
            QAListData *service = [[QAListData alloc] initWithDictionary:data];
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
