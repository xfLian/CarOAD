//
//  CreateCVSkillsCertificateRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateCVSkillsCertificateData.h"

@interface CreateCVSkillsCertificateRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <CreateCVSkillsCertificateData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
