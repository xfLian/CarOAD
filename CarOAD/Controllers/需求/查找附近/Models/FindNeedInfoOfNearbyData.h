//
//  FindNeedInfoOfNearbyData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/26.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindNeedInfoOfNearbyData : NSObject

@property (nonatomic, assign) NSInteger cell_tag;
@property (nonatomic, strong) NSString *demandId;

@property (nonatomic, strong) NSString *demandTitle;
@property (nonatomic, strong) NSString *demandImg;

@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *cityArea;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, strong) NSString *demandType;

@property (nonatomic, strong) NSString *endByTime;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *URGLevel;

@property (nonatomic, strong) NSString *distance;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSNumber  *countdownTime;

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
