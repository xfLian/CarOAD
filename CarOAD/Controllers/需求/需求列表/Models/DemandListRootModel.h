//
//  DemandListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DemandListData.h"

@interface DemandListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <DemandListData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
