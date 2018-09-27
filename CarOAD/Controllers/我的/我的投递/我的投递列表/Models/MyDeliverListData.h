//
//  MyDeliverListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDeliverListData : NSObject

@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *sendId;
@property (nonatomic, strong) NSString *salaryRange;
@property (nonatomic, strong) NSString *cityArea;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *skillPost;
@property (nonatomic, strong) NSString *recruitId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
