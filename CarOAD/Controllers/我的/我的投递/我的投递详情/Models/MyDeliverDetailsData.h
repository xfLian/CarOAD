//
//  MyDeliverDetailsData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDeliverDetailsData : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *recruiId;
@property (nonatomic, strong) NSString *skillPost;
@property (nonatomic, strong) NSString *salaryRange;
@property (nonatomic, strong) NSString *cityArea;
@property (nonatomic, strong) NSString *expDuty;
@property (nonatomic, strong) NSString *eduDuty;
@property (nonatomic, strong) NSString *workNature;
@property (nonatomic, strong) NSString *postInfo;
@property (nonatomic, strong) NSString *shopImg;
@property (nonatomic, strong) NSString *ShopName;
@property (nonatomic, strong) NSString *shopLinkman;
@property (nonatomic, strong) NSString *shopLinkRole;
@property (nonatomic, strong) NSString *shopInfo;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *status;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) CLLocation  *userLocation;
@property (nonatomic, strong) NSString    *distance;

/**
 *  计算距离（km为单位）
 */
- (void)calculateDistanceWithLocation:(CLLocation *)userLocation;

/**
 *  获取距离（km为单位）
 */
- (NSString *) getDistance;

@end
