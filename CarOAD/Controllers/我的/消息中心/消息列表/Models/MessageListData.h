//
//  MessageListData.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/5.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageListData : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *noticeTypeId;
@property (nonatomic, strong) NSString *noticeType;
@property (nonatomic, strong) NSString *lastNoticeDate;
@property (nonatomic, strong) NSString *unreadCounnt;

@property (nonatomic, assign) BOOL      isShowLineView;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
