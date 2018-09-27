//
//  CreateCVEducationExperienceData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

/**
 *  教育经历数据解析
 */
#import <Foundation/Foundation.h>

@interface CreateCVEducationExperienceData : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *CVId;
@property (nonatomic, strong) NSString *eduExpId;
@property (nonatomic, strong) NSString *entryEduDate;
@property (nonatomic, strong) NSString *endEduDate;
@property (nonatomic, strong) NSString *university;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *educationName;
@property (nonatomic, strong) NSString *eduMajor;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
