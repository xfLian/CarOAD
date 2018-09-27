//
//  QAListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QAListData : NSObject

@property (nonatomic, strong) NSString *QAId;
@property (nonatomic, strong) NSString *QAInfo;

@property (nonatomic, strong) NSString *createrName;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *createrImg;
@property (nonatomic, strong) NSString *carBrand;

@property (nonatomic, strong) NSString *answerNum;
@property (nonatomic, strong) NSString *QAImgURLList;

@property (nonatomic, strong) NSString *totalLikeNum;
@property (nonatomic, strong) NSString *isLike;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
