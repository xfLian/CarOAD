//
//  MYSkillListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSkillListData : NSObject

@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *clickNum;
@property (nonatomic, strong) NSString *skillImg;
@property (nonatomic, strong) NSString *skillPrice;
@property (nonatomic, strong) NSString *skillTitle;
@property (nonatomic, strong) NSString *skillId;
@property (nonatomic, strong) NSString *makeOrder;
@property (nonatomic, strong) NSString *skillState;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
