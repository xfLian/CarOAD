//
//  FindNeedInfoOfNearbyRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/26.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FindNeedInfoOfNearbyData.h"

@interface FindNeedInfoOfNearbyRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <FindNeedInfoOfNearbyData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
