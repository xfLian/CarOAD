//
//  MyOrderDetailsOrderMsgList.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderDetailsOrderMsgList : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *userShopName;
@property (nonatomic, strong) NSString *orderMsg;
@property (nonatomic, strong) NSString *quote;
@property (nonatomic, strong) NSString *oederMsgDate;
@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *date;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  便利构造器
 *
 *  @param data 服务器数据
 *
 *  @return 实例对象
 */
- (instancetype)timeModelWithData:(id)data;

@end
