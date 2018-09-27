//
//  PublishMySkillData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublishMySkillData : NSObject

@property (nonatomic, strong) UIImage  *headerImage;

@property (nonatomic, strong) NSString *skillId;
@property (nonatomic, strong) NSString *skillTitle;
@property (nonatomic, strong) NSString *skillInfo;
@property (nonatomic, strong) NSString *skillImg;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *skillType;

@property (nonatomic, strong) NSString *servereArea;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *areaId;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;

@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *catenaId;
@property (nonatomic, strong) NSString *categoryInfoId;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *catena;
@property (nonatomic, strong) NSString *categoryInfo;

+ (PublishMySkillData *) getMySkillDataWithData:(id)data;

@end
