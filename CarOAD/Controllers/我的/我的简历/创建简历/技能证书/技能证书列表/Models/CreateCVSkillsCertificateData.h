//
//  CreateCVSkillsCertificateData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

/**
 *  技能证书数据解析
 */
#import <Foundation/Foundation.h>

@interface CreateCVSkillsCertificateData : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *CVId;
@property (nonatomic, strong) NSString *certificateId;
@property (nonatomic, strong) NSString *workType;
@property (nonatomic, strong) NSString *certDate;
@property (nonatomic, strong) NSString *certImg;

@property (nonatomic, strong) NSString *skillCertId;
@property (nonatomic, strong) NSString *skillCertName;
@property (nonatomic, strong) NSString *certLevel;
@property (nonatomic, strong) NSString *skillLevel;
@property (nonatomic, strong) NSString *certLevelName;
@property (nonatomic, strong) NSString *skillLevelName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
