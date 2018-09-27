//
//  MyDeliverListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyDeliverListData.h"

@interface MyDeliverListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <MyDeliverListData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
