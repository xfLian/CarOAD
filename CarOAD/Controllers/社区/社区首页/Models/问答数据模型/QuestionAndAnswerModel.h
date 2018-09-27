//
//  QuestionAndAnswerModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionAndAnswerModel : NSObject

@property (nonatomic, strong) NSString *qAId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray  *imageArray;
@property (nonatomic, strong) NSString *iconImageString;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *totalLikeNum;
@property (nonatomic, strong) NSString *isLike;

@property (nonatomic, assign) CGFloat   cell_height;
@property (nonatomic, strong) NSString *cell_type;

+ (QuestionAndAnswerModel *) initQuestionAndAnswerData:(id)data;;

@end
