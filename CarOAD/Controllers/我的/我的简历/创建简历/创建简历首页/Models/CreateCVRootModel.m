//
//  CreateCVRootModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CreateCVRootModel.h"

@implementation CreateCVRootModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([value isKindOfClass:[NSNull class]]) {

        return;
    }

    if ([key isEqualToString:@"data"] && [value isKindOfClass:[NSArray class]]) {

        NSArray        *tmp      = value;
        NSMutableArray *dataList = [NSMutableArray array];

        for (NSDictionary *data in tmp) {

            CreateCVUserInfoData *service = [[CreateCVUserInfoData alloc] initWithDictionary:data];
            [dataList addObject:service];

        }

        value = dataList;
    }
    if ([key isEqualToString:@"workExp"] && [value isKindOfClass:[NSArray class]]) {

        NSArray        *tmp      = value;
        NSMutableArray *dataList = [NSMutableArray array];

        for (NSDictionary *data in tmp) {

            CreateCVJobexperiencesData *service = [[CreateCVJobexperiencesData alloc] initWithDictionary:data];
            [dataList addObject:service];

        }

        value = dataList;
    }
    if ([key isEqualToString:@"eduExp"] && [value isKindOfClass:[NSArray class]]) {

        NSArray        *tmp      = value;
        NSMutableArray *dataList = [NSMutableArray array];

        for (NSDictionary *data in tmp) {

            CreateCVEducationExperienceData *service = [[CreateCVEducationExperienceData alloc] initWithDictionary:data];
            [dataList addObject:service];

        }

        value = dataList;
    }
    if ([key isEqualToString:@"skillCert"] && [value isKindOfClass:[NSArray class]]) {

        NSArray        *tmp      = value;
        NSMutableArray *dataList = [NSMutableArray array];

        for (NSDictionary *data in tmp) {

            CreateCVSkillsCertificateData *service = [[CreateCVSkillsCertificateData alloc] initWithDictionary:data];
            [dataList addObject:service];

        }

        value = dataList;
    }

    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    if ([dictionary isKindOfClass:[NSDictionary class]]) {

        if (self = [super init]) {

            [self setValuesForKeysWithDictionary:dictionary];
        }
    }

    return self;
}

@end
