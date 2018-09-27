//
//  PreserveLikeData.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "PreserveLikeData.h"

static PreserveLikeData *initPreserveLikeData = nil;

@implementation PreserveLikeData

@synthesize detailsTableName;
@synthesize communotyTableName;

+ (PreserveLikeData *) initPreserveLikeData {
    
    if (initPreserveLikeData == nil) {
        
        initPreserveLikeData = [[self alloc] init];
        
    }
    
    return initPreserveLikeData;
}

#pragma mark - 点赞数据库相关
- (void) creatSqlite {

    //  创建并打开数据库
    self.sqlite = [[FMDBSQLite sqlite] createDataBaseWithDBName:DBName];

    //  添加数据库表
    NSDictionary *detailsKeyDic = @{@"userId"    : @"text",
                                    @"type"      : @"text",
                                    @"detailsId" : @"text",
                                    @"isLike"    : @"text"};
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    self.detailsTableName = [NSString stringWithFormat:@"Details_like_%@",accountInfo.user_id];

    [[FMDBSQLite sqlite] dataBase:self.sqlite
                      createTable:self.detailsTableName
                         keyTypes:detailsKeyDic];

    //  添加数据库表
    NSDictionary *communotyKeyDic = @{@"userId"      : @"text",
                                      @"type"        : @"text",
                                      @"detailsId"   : @"text",
                                      @"communotyId" : @"text",
                                      @"isLike"      : @"text"};

    self.communotyTableName = [NSString stringWithFormat:@"Communoty_like_%@",accountInfo.user_id];

    [[FMDBSQLite sqlite] dataBase:self.sqlite
                      createTable:self.communotyTableName
                         keyTypes:communotyKeyDic];

}

//  查询详情点赞是否存在
- (BOOL) isLikeThisDetailsWithType:(NSString *)type detailsId:(NSString *)detailsId; {
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    NSArray *array = [[FMDBSQLite sqlite] dataBase:self.sqlite
                                    selectKeyTypes:@{@"userId"      : @"text",
                                                     @"type"        : @"text",
                                                     @"detailsId"   : @"text",
                                                     @"isLike"      : @"text"
                                                     }
                                         fromTable:self.detailsTableName
                                    whereCondition:@{@"userId"    : accountInfo.user_id,
                                                     @"type"      : type,
                                                     @"detailsId" : detailsId,
                                                     @"isLike"    : @"1"
                                                     }];

    if (array.count > 0) {

        return YES;

    } else {

        return NO;

    }

}

//  保存详情点赞
- (void) addDetailsLikeWithType:(NSString *)type detailsId:(NSString *)detailsId; {

    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [[FMDBSQLite sqlite] dataBase:self.sqlite
                  insertKeyValues:@{@"userId"    : accountInfo.user_id,
                                    @"type"      : type,
                                    @"detailsId" : detailsId,
                                    @"isLike"    : @"1"
                                    }
                        intoTable:self.detailsTableName];

}

//  查询评论点赞是否存在
- (BOOL) isLikeThisCommunityWithType:(NSString *)type detailsId:(NSString *)detailsId communityId:(NSString *)communityId; {

    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    NSArray *array = [[FMDBSQLite sqlite] dataBase:self.sqlite
                                    selectKeyTypes:@{@"userId"      : @"text",
                                                     @"type"        : @"text",
                                                     @"detailsId"   : @"text",
                                                     @"communotyId" : @"text",
                                                     @"isLike"      : @"text"
                                                     }
                                         fromTable:self.communotyTableName
                                    whereCondition:@{@"userId"      : accountInfo.user_id,
                                                     @"type"        : type,
                                                     @"detailsId"   : detailsId,
                                                     @"communotyId" : communityId,
                                                     @"isLike"      : @"1"
                                                     }];

    if (array.count > 0) {

        return YES;

    } else {
        
        return NO;

    }

}

- (void) addDetailsLikeWithType:(NSString *)type detailsId:(NSString *)detailsId communityId:(NSString *)communityId; {
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [[FMDBSQLite sqlite] dataBase:self.sqlite
                  insertKeyValues:@{@"userId"      : accountInfo.user_id,
                                    @"type"        : type,
                                    @"detailsId"   : detailsId,
                                    @"communotyId" : communityId,
                                    @"isLike"      : @"1"
                                    }
                        intoTable:self.communotyTableName];

}

@end
