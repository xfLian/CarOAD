//
//  ArtCommunityListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtCommunityListData : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *createrImg;
@property (nonatomic, strong) NSString *createrName;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *commentNum;
@property (nonatomic, strong) NSString *isLike;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
