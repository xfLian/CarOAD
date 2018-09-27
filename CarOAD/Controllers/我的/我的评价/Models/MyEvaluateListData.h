//
//  MyEvaluateListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEvaluateListData : NSObject

@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *creditScore;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
