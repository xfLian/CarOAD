//
//  MySkillCommentListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySkillCommentListData : NSObject

@property (nonatomic, strong) NSString *Areaid;
@property (nonatomic, strong) NSString *creditScore;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
