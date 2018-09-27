//
//  MyOrderDetailsData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderDetailsData : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *demandId;
@property (nonatomic, strong) NSString *demandTitle;
@property (nonatomic, strong) NSString *demandInfo;
@property (nonatomic, strong) NSString *demandImgName;
@property (nonatomic, strong) NSString *URGLevel;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *clickNum;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, strong) NSString *demandType;
@property (nonatomic, strong) NSString *publicDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSString *endByTime;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopLinkman;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *shopLinkmanImg;
@property (nonatomic, strong) NSString *shopAuth;
@property (nonatomic, strong) NSString *demandState;
@property (nonatomic, strong) NSString *msgCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) CLLocation  *userLocation;
@property (nonatomic, strong) NSString    *distance;

@property (nonatomic, strong) NSNumber  *countdownTime;

/**
 *  计算距离（km为单位）
 */
- (void)calculateDistanceWithLocation:(CLLocation *)userLocation;

/**
 *  获取距离（km为单位）
 */
- (NSString *) getDistance;

/**
 *  便利构造器
 *
 *  @param data 服务器数据
 *
 *  @return 实例对象
 */
- (instancetype)timeModelWithData:(id)data;

/**
 *  计数减1(countdownTime - 1)
 */
- (void)countDown;

/**
 *  将当前的countdownTime信息转换成字符串
 */
- (NSString *)currentTimeString;

@end
