//
//  OrderMessageListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrderMessageListData.h"

@interface OrderMessageListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <OrderMessageListData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
