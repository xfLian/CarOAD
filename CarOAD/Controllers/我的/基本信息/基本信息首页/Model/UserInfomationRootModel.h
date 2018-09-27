//
//  UserInfomationRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/10.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfomationData.h"

@interface UserInfomationRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <UserInfomationData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
