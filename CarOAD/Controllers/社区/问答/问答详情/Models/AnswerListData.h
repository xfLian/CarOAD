//
//  AnswerListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerListData : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *answerId;
@property (nonatomic, strong) NSString *ansCreaterImg;

@property (nonatomic, strong) NSString *ansCreaterName;
@property (nonatomic, strong) NSString *ansCreateDate;
@property (nonatomic, strong) NSString *ansLikeNum;
@property (nonatomic, strong) NSString *ansContent;

@property (nonatomic, strong) NSString *ansNum;
@property (nonatomic, strong) NSString *isLike;
@property (nonatomic, strong) NSString *reImgURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
