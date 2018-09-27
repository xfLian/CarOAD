//
//  ArtInfoData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtInfoData : NSObject

@property (nonatomic, assign) BOOL      isLoadData;
@property (nonatomic, assign) CGFloat   cell_height;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *artId;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *isLike;
@property (nonatomic, strong) NSString *artHtmlUrl;
@property (nonatomic, strong) NSString *commentNum;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
