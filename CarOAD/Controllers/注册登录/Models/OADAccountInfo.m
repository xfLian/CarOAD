//
//  OADAccountInfo.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAccountInfo.h"

@implementation OADAccountInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"UserId"]) {

        self.user_id = value;
    }

    if ([key isEqualToString:@"UserPhone"]) {

        self.user_phone = value;
    }

    if ([key isEqualToString:@"UserName"]) {

        self.user_name = value;
    }

    if ([key isEqualToString:@"UserImg"]) {

        self.user_icon_image = value;
    }

    if ([key isEqualToString:@"userResumePhone"]) {

        self.user_resume_phone = value;
    }

    if ([key isEqualToString:@"userSex"]) {

        self.user_sex = value;
    }

    if ([key isEqualToString:@"userJobStatus"]) {

        self.user_applyStateData = value;
    }

    if ([key isEqualToString:@"userBirthday"]) {

        self.user_birthDateData = value;
    }

    if ([key isEqualToString:@"userEducation"]) {

        self.user_topEduData = value;
    }

    if ([key isEqualToString:@"userWorkExperience"]) {

        self.user_toYearData = value;
    }

    if ([key isEqualToString:@"userSkill"]) {

        self.user_adeptSkill = value;
    }

    if ([key isEqualToString:@"userAddress"]) {

        self.user_addressData = value;
    }

    if ([key isEqualToString:@"provinceData"]) {

        self.user_provinceData = value;
    }

    if ([key isEqualToString:@"cityData"]) {

        self.user_cityData = value;
    }

    if ([key isEqualToString:@"areaData"]) {

        self.user_areaData = value;
    }
    
    if ([key isEqualToString:@"ResumeId"]) {
        
        self.default_cv_id = value;
    }

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([value isKindOfClass:[NSNull class]]) {

        return;

    }

    [super setValue:value forKey:key];
}

+ (instancetype)accountInfoWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    if ([dictionary isKindOfClass:[NSDictionary class]]) {

        if (self = [super init]) {

            [self setValuesForKeysWithDictionary:dictionary];
        }
    }

    return self;
}

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {

        self.user_id                = [decoder decodeObjectForKey:@"user_id"];
        self.user_phone             = [decoder decodeObjectForKey:@"user_phone"];
        self.user_name              = [decoder decodeObjectForKey:@"user_name"];
        self.user_icon_image        = [decoder decodeObjectForKey:@"user_icon_image"];
        self.user_sex               = [decoder decodeObjectForKey:@"user_sex"];
        self.user_applyStateData    = [decoder decodeObjectForKey:@"user_applyStateData"];
        self.user_birthDateData     = [decoder decodeObjectForKey:@"user_birthDateData"];
        self.user_topEduData        = [decoder decodeObjectForKey:@"user_topEduData"];
        self.user_toYearData        = [decoder decodeObjectForKey:@"user_toYearData"];
        self.user_adeptSkill        = [decoder decodeObjectForKey:@"user_adeptSkill"];
        self.user_addressData       = [decoder decodeObjectForKey:@"user_addressData"];
        self.user_provinceData      = [decoder decodeObjectForKey:@"user_provinceData"];
        self.user_cityData          = [decoder decodeObjectForKey:@"user_cityData"];
        self.user_areaData          = [decoder decodeObjectForKey:@"user_areaData"];
        self.default_cv_id          = [decoder decodeObjectForKey:@"default_cv_id"];
        
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_user_id forKey:@"user_id"];
    [encoder encodeObject:_user_phone forKey:@"user_phone"];
    [encoder encodeObject:_user_name forKey:@"user_name"];
    [encoder encodeObject:_user_icon_image forKey:@"user_icon_image"];
    [encoder encodeObject:_user_sex forKey:@"user_sex"];
    [encoder encodeObject:_user_applyStateData forKey:@"user_applyStateData"];
    [encoder encodeObject:_user_birthDateData forKey:@"user_birthDateData"];
    [encoder encodeObject:_user_topEduData forKey:@"user_topEduData"];
    [encoder encodeObject:_user_toYearData forKey:@"user_toYearData"];
    [encoder encodeObject:_user_adeptSkill forKey:@"user_adeptSkill"];
    [encoder encodeObject:_user_addressData forKey:@"user_addressData"];
    [encoder encodeObject:_user_provinceData forKey:@"user_provinceData"];
    [encoder encodeObject:_user_cityData forKey:@"user_cityData"];
    [encoder encodeObject:_user_areaData forKey:@"user_areaData"];
    [encoder encodeObject:_default_cv_id forKey:@"default_cv_id"];
    
}

@end
