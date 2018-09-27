//
//  MyEvaluateListCommentList.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEvaluateListCommentList : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *shopLinkman;
@property (nonatomic, strong) NSString *shopImg;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *commentInfo;
@property (nonatomic, strong) NSString *commentDate;
@property (nonatomic, strong) NSString *speed;
@property (nonatomic, strong) NSString *quality;
@property (nonatomic, strong) NSString *attitude;
@property (nonatomic, strong) NSString *holistic;
@property (nonatomic, strong) NSString *projectId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
