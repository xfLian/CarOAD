//
//  OrderMessageListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMessageListData : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *skillOrderId;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *skillOrderState;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopImg;
@property (nonatomic, strong) NSString *shopMsg;
@property (nonatomic, strong) NSString *shopPhone;
@property (nonatomic, strong) NSString *skillId;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *createName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
