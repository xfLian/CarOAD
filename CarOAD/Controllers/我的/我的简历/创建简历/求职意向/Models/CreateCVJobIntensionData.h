//
//  CreateCVJobIntensionData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

/**
 *  求职意向数据解析
 */

#import <Foundation/Foundation.h>

@interface CreateCVJobIntensionData : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *CVId;

@property (nonatomic, strong) NSString *integrity;
@property (nonatomic, strong) NSString *skillPost;
@property (nonatomic, strong) NSString *hopeSalaryName;
@property (nonatomic, strong) NSString *workTypeName;
@property (nonatomic, strong) NSString *workNatureName;
@property (nonatomic, strong) NSString *workAddress;

@property (nonatomic, strong) NSString *intentionId;
@property (nonatomic, strong) NSString *hopePost;
@property (nonatomic, strong) NSString *hopeSalary;
@property (nonatomic, strong) NSString *workType;
@property (nonatomic, strong) NSString *workNature;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *areaId;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
