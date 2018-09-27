//
//  MYSkillDetailesRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MYSkillDetailesData.h"
#import "MYSkillDetailesOrderMsgList.h"

@interface MYSkillDetailesRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <MYSkillDetailesData *> *data;
@property (nonatomic, strong) NSArray <MYSkillDetailesOrderMsgList *> *orderMsgList;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
