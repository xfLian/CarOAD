//
//  MYSkillDetailesData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSkillDetailesData : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *skillTitle;
@property (nonatomic, strong) NSString *viewTime;
@property (nonatomic, strong) NSString *skillId;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *isRealNameAuth;
@property (nonatomic, strong) NSString *servereArea;
@property (nonatomic, strong) NSString *publicDate;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *skillImgName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *skillType;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *creditScore;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *skillState;
@property (nonatomic, strong) NSString *SkillTypeId;
@property (nonatomic, strong) NSString *skillInfo;
@property (nonatomic, strong) NSString *Provinceid;
@property (nonatomic, strong) NSString *Cityid;
@property (nonatomic, strong) NSString *Areaid;

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
