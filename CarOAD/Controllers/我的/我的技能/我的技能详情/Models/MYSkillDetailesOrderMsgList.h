//
//  MYSkillDetailesOrderMsgList.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSkillDetailesOrderMsgList : NSObject

@property (nonatomic)         CGFloat   noDataStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *commentDate;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *shopImg;
@property (nonatomic, strong) NSString *CompCode;
@property (nonatomic, strong) NSString *commentInfo;
@property (nonatomic, strong) NSString *shopLinkman;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
