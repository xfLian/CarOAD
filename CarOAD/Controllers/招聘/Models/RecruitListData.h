//
//  RecruitListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecruitListData : NSObject

@property (nonatomic, assign) NSInteger cell_tag;
@property (nonatomic, strong) NSString *recruitId;

@property (nonatomic, strong) NSString *skillPost;
@property (nonatomic, strong) NSString *ShopName;

@property (nonatomic, strong) NSString *salaryRange;
@property (nonatomic, strong) NSString *cityArea;
@property (nonatomic, strong) NSString *expDuty;
@property (nonatomic, strong) NSString *eduDuty;

@property (nonatomic, strong) NSString *workNature;
@property (nonatomic, strong) NSString *publicDate;
@property (nonatomic, assign) BOOL      isShowPublicDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
