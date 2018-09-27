//
//  UserInfomationData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/10.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfomationData : NSObject

@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userSex;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *applyState;
@property (nonatomic, strong) NSString *applyStateId;

@property (nonatomic, strong) NSString *toYear;
@property (nonatomic, strong) NSString *toYearId;

@property (nonatomic, strong) NSString *topEdu;
@property (nonatomic, strong) NSString *topEduId;

@property (nonatomic, strong) NSString *birthDate;

@property (nonatomic, strong) NSString *creditScore;
@property (nonatomic, strong) NSString *isRealnameAuth;
@property (nonatomic, strong) NSString *phoneIdenti;
@property (nonatomic, strong) NSString *selfMemo;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *areaId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
