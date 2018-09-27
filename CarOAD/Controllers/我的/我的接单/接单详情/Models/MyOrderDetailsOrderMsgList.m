//
//  MyOrderDetailsOrderMsgList.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyOrderDetailsOrderMsgList.h"

@implementation MyOrderDetailsOrderMsgList

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

- (instancetype)timeModelWithData:(id)data; {
    
    MyOrderDetailsOrderMsgList *newModel = [[[self class] alloc] init];
    MyOrderDetailsOrderMsgList *model    = data;
    
    newModel.noDataStringHeight = model.noDataStringHeight;
    newModel.normalStringHeight = model.normalStringHeight;
    newModel.userName           = model.userName;
    newModel.userImg            = model.userImg;
    newModel.userShopName       = model.userShopName;
    newModel.orderMsg           = model.orderMsg;
    newModel.quote              = model.quote;
    newModel.oederMsgDate       = model.oederMsgDate;
    newModel.state              = model.state;
    
    if (newModel.oederMsgDate.length > 0) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate          *date      = [formatter dateFromString:newModel.oederMsgDate];
        NSTimeInterval  _date      = [date timeIntervalSince1970] *1;
        NSTimeInterval  nowDate    = [[NSDate date] timeIntervalSince1970] *1;
        
        NSInteger difftime = nowDate - _date;
        
        if (difftime < 60) {
            
            newModel.date = @"刚刚";
            
        } else {
            
            difftime = difftime / 60;
            
            if (difftime < 24) {
                
                newModel.date = [NSString stringWithFormat:@"%ld 分钟前",difftime];
                
            } else {
                
                difftime = difftime / (60 *24);
                newModel.date = [NSString stringWithFormat:@"%ld 天前",difftime];
                
            }
            
        }
        
    }
    
    return newModel;
    
}

@end
