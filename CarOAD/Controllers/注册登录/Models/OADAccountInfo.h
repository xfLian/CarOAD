//
//  OADAccountInfo.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OADAccountInfo : NSObject

/**
 用户id
 */
@property (nonatomic, copy) NSString *user_id;
/**
 登录手机号码
 */
@property (nonatomic, copy) NSString *user_phone;
/**
 用户姓名
 */
@property (nonatomic, copy) NSString *user_name;
/**
 用户头像
 */
@property (nonatomic, copy) NSString *user_icon_image;
/**
 简历手机号码
 */
@property (nonatomic, copy) NSString *user_resume_phone;
/**
 用户性别
 */
@property (nonatomic, copy) NSString *user_sex;
/**
 求职状态
 */
@property (nonatomic, copy) NSDictionary *user_applyStateData;
/**
 生日
 */
@property (nonatomic, copy) NSDictionary *user_birthDateData;
/**
 最高学历
 */
@property (nonatomic, copy) NSDictionary *user_topEduData;
/**
 工作年限
 */
@property (nonatomic, copy) NSDictionary *user_toYearData;
/**
 擅长技能
 */
@property (nonatomic, copy) NSString *user_adeptSkill;
/**
 所在地址数据
 */
@property (nonatomic, copy) NSDictionary *user_addressData;
/**
 所在省份数据
 */
@property (nonatomic, copy) NSDictionary *user_provinceData;
/**
 所在城市数据
 */
@property (nonatomic, copy) NSDictionary *user_cityData;
/**
 所在区数据
 */
@property (nonatomic, copy) NSDictionary *user_areaData;
/**
 默认简历ID
 */
@property (nonatomic, copy) NSString *default_cv_id;

+ (instancetype)accountInfoWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
