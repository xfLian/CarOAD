//
//  CommentAnswerListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentAnswerListData : NSObject

@property (nonatomic, strong) NSString *replyId;

@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *createDate;

//  问答回复内容
@property (nonatomic, strong) NSString *ansContent;

//  其他回复内容
@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) BOOL     isClickChackButton;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
