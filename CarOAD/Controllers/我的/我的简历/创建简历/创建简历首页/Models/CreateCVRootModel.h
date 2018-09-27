//
//  CreateCVRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CreateCVUserInfoData.h"
#import "CreateCVJobIntensionData.h"
#import "CreateCVJobexperiencesData.h"
#import "CreateCVEducationExperienceData.h"
#import "CreateCVSkillsCertificateData.h"

@interface CreateCVRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <CreateCVUserInfoData *> *data;
@property (nonatomic, strong) NSArray <CreateCVJobexperiencesData *> *workExp;
@property (nonatomic, strong) NSArray <CreateCVSkillsCertificateData *> *skillCert;
@property (nonatomic, strong) NSArray <CreateCVEducationExperienceData *> *eduExp;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
