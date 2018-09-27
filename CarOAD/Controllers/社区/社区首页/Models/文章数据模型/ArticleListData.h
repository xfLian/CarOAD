//
//  ArticleListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleListData : NSObject

@property (nonatomic, assign) NSInteger cell_tag;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *artId;
@property (nonatomic, strong) NSString *tag;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *articleInfo;
@property (nonatomic, strong) NSString *createrImg;
@property (nonatomic, strong) NSString *createrName;

@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *commentNum;

@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *artCoverImg;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
