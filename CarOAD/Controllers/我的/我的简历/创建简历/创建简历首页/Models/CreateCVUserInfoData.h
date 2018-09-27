//
//  CreateCVUserInfoData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateCVUserInfoData : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *integrity;
@property (nonatomic, strong) NSString *uodateDate;
@property (nonatomic, strong) NSString *isOpen;
@property (nonatomic, strong) NSString *intentionId;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userSex;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *applyState;
@property (nonatomic, strong) NSString *applyStateName;

@property (nonatomic, strong) NSString *topEdu;
@property (nonatomic, strong) NSString *topEduName;

@property (nonatomic, strong) NSString *workType;
@property (nonatomic, strong) NSString *workTypeName;

@property (nonatomic, strong) NSString *workLife;
@property (nonatomic, strong) NSString *workLifeName;

@property (nonatomic, strong) NSString *hopeSalary;
@property (nonatomic, strong) NSString *hopeSalaryName;

@property (nonatomic, strong) NSString *workNature;
@property (nonatomic, strong) NSString *workNatureName;

@property (nonatomic, strong) NSString *birthDate;

@property (nonatomic, strong) NSString *skillPost;
@property (nonatomic, strong) NSString *adeptSkill;

@property (nonatomic, strong) NSString *inCity;
@property (nonatomic, strong) NSString *workAddress;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *areaId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
