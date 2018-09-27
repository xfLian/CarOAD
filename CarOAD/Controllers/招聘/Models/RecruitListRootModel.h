//
//  RecruitListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RecruitListData.h"

@interface RecruitListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <RecruitListData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
