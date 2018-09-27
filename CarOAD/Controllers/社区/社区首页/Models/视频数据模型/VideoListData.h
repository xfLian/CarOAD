//
//  VideoListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoListData : NSObject

@property (nonatomic, assign) NSInteger cell_tag;

@property (nonatomic, strong) NSString *videoAuth;
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *tag;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *carBrand;
@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, strong) NSString *createrImg;

@property (nonatomic, strong) NSString *createrName;
@property (nonatomic, strong) NSString *createDate;

@property (nonatomic, strong) NSString *commentNum;
@property (nonatomic, strong) NSString *likeNum;

@property (nonatomic, strong) NSString *isLike;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
