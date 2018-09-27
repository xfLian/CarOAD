//
//  PreserveLikeData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreserveLikeData : NSObject
/**
 *  声明数据库全局变量
 *
 *  detailsTableName    详情数据库表名
 *  communotyTableName  评论数据库表名
 *
 */
{
    NSString *detailsTableName;
    NSString *communotyTableName;
}

@property (nonatomic, retain) NSString *detailsTableName;
@property (nonatomic, retain) NSString *communotyTableName;

@property (nonatomic, strong) FMDatabase  *sqlite;

+ (PreserveLikeData *) initPreserveLikeData;

/**
 创建数据库
 */
- (void) creatSqlite;


/**
 查询详情是否点过赞

 @param type 详情类型
 @param detailsId 详情ID
 @return 是否点赞
 */
- (BOOL) isLikeThisDetailsWithType:(NSString *)type detailsId:(NSString *)detailsId;


/**
 添加详情点赞

 @param type 详情类型
 @param detailsId 详情ID
 */
- (void) addDetailsLikeWithType:(NSString *)type detailsId:(NSString *)detailsId;


/**
 查询评论是否点过赞

 @param type 详情类型
 @param detailsId 详情ID
 @param communityId 评论ID
 @return 是否点赞
 */
- (BOOL) isLikeThisCommunityWithType:(NSString *)type detailsId:(NSString *)detailsId communityId:(NSString *)communityId;


/**
 添加评论点赞

 @param type 详情类型
 @param detailsId 详情ID
 @param communityId 评论ID
 */
- (void) addDetailsLikeWithType:(NSString *)type detailsId:(NSString *)detailsId communityId:(NSString *)communityId;

@end
