//
//  MyEvaluateListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyEvaluateListData.h"
#import "MyEvaluateListCommentList.h"

@interface MyEvaluateListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <MyEvaluateListData *> *data;
@property (nonatomic, strong) NSArray <MyEvaluateListCommentList *> *commentList;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
