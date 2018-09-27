//
//  MessageDetailsRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/5.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MessageDetailsData.h"

@interface MessageDetailsRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <MessageDetailsData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
