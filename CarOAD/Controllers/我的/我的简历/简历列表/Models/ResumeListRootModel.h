//
//  ResumeListRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResumeListData.h"

@interface ResumeListRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <ResumeListData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
