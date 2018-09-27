//
//  MYSkillListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYSkillListData.h"

@interface MYSkillListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <MYSkillListData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
