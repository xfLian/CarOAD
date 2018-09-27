//
//  MySkillCommentListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MySkillCommentListData.h"
#import "MYSkillDetailesOrderMsgList.h"

@interface MySkillCommentListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <MySkillCommentListData *> *data;
@property (nonatomic, strong) NSArray <MYSkillDetailesOrderMsgList *> *orderMsgList;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
