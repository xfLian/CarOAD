//
//  MYSkillDetailesRootModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MYSkillDetailesRootModel.h"

@implementation MYSkillDetailesRootModel

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
            
            MYSkillDetailesData *service = [[MYSkillDetailesData alloc] initWithDictionary:data];
            [dataList addObject:service];
            
        }
        
        value = dataList;
    }
    
    if ([key isEqualToString:@"orderMsgList"] && [value isKindOfClass:[NSArray class]]) {
        
        NSArray        *tmp      = value;
        NSMutableArray *dataList = [NSMutableArray array];
        
        for (NSDictionary *data in tmp) {
            
            MYSkillDetailesOrderMsgList *service = [[MYSkillDetailesOrderMsgList alloc] initWithDictionary:data];
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
