//
//  CommentAnswerListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CommentAnswerListData.h"

@interface CommentAnswerListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <CommentAnswerListData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
