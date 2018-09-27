//
//  FMDBSQLite.m
//  youIdea
//
//  Created by admin on 16/5/31.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "FMDBSQLite.h"

static FMDBSQLite *sqlite = nil;

@implementation FMDBSQLite

+ (FMDBSQLite *) sqlite {

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (sqlite == nil) {
            
            sqlite = [[self alloc] init];
            
        }
        
    });
    
    return sqlite;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone

{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (sqlite == nil) {
            
            sqlite = [super allocWithZone:zone];
        }
    });
    
    return sqlite;
}

- (FMDatabase *) createDataBaseWithDBName:(NSString *)dbName {
    
    // 1 获取数据库对象
    NSArray    *library    = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString   *dbFilePath = [library[0] stringByAppendingPathComponent:dbName];
    FMDatabase *db         = [FMDatabase databaseWithPath:dbFilePath];
    
    NSLog(@"dbFilePath --- %@",dbFilePath);
    
    // 2 打开数据库，如果不存在则创建并且打开
    BOOL open = [db open];
    if (!open) {
        
        NSLog(@"open error:%@",[db lastErrorMessage]);//最近一次错误
        
    }
    
    return db;
}

-(void) dataBase:(FMDatabase *)db
     createTable:(NSString *)tableName
        keyTypes:(NSDictionary *)keyTypes; {

    if ([self isOpenDatabese:db]) {
        
        NSMutableString *sql = \
            [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (",tableName]];
        
        int count = 0;
        
        for (NSString *key in keyTypes) {
            
            count++;
            
            [sql appendString:key];
            [sql appendString:@" "];
            [sql appendString:[keyTypes valueForKey:key]];
            
            if (count != [keyTypes count]) {
                
                [sql appendString:@", "];
            }
        }
        
        [sql appendString:@")"];
        
        //NSLog(@"%@", sql);
        
        [db executeUpdate:sql];
        
    }
}

-(void) dataBase:(FMDatabase *)db
 insertKeyValues:(NSDictionary *)keyValues
       intoTable:(NSString *)tableName;{

    if ([self isOpenDatabese:db]) {
        
        NSArray         *keys   = [keyValues allKeys];
        NSArray         *values = [keyValues allValues];
        NSMutableString *sql    = \
            [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@ (", tableName]];
        NSInteger        count  = 0;
        
        for (NSString *key in keys) {
            
            [sql appendString:key];
            
            count ++;
            
            if (count < [keys count]) {

                [sql appendString:@", "];
            }
        }

        [sql appendString:@") VALUES ("];

        for (int i = 0; i < [values count]; i++) {

            [sql appendString:@"?"];
 
            if (i < [values count] - 1) {

                [sql appendString:@","];
                
            }
        }

        [sql appendString:@")"];

        [db executeUpdate:sql withArgumentsInArray:values];
        
    }
}

- (void) dataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues;{

    if ([self isOpenDatabese:db]) {
        
        for (NSString *key in keyValues) {
            
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ?", tableName, key]];
            
            [db executeUpdate:sql,[keyValues valueForKey:key]];
            
        }
    }
}

- (void) dataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues whereCondition:(NSDictionary *)condition;{
    
    if ([self isOpenDatabese:db]) {
        
        for (NSString *key in keyValues) {
            
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE %@ = ?", tableName, key, [condition allKeys][0]]];
            
            [db executeUpdate:sql,[keyValues valueForKey:key],[condition valueForKey:[condition allKeys][0]]];
            
        }
    }
}

- (void) dataBase:(FMDatabase *)db
      updateTable:(NSString *)tableName
     setKeyValues:(NSDictionary *)keyValues
            where:(NSString *)where; {


    
}

- (NSArray *) dataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName;{

    FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ LIMIT 100",tableName]];
    
    return [self getArrWithFMResultSet:result keyTypes:keyTypes];
}

- (NSArray *) dataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereCondition:(NSDictionary *)condition;{

    if ([self isOpenDatabese:db]) {

        NSArray *keyArray = [condition allKeys];

        NSMutableString *conditionString = [[NSMutableString alloc] initWithString:@""];

        if (keyArray.count == 1) {

            [conditionString appendString:[NSString stringWithFormat:@"%@ = '%@'",[condition allKeys][0],[condition valueForKey:[condition allKeys][0]]]];

        } else if (keyArray.count == 2) {

            [conditionString appendString:[NSString stringWithFormat:@"%@ = '%@'",[condition allKeys][0],[condition valueForKey:[condition allKeys][0]]]];

            [conditionString appendString:@" and "];

            [conditionString appendString:[NSString stringWithFormat:@"%@ = '%@'",[condition allKeys][1],[condition valueForKey:[condition allKeys][1]]]];
            
        } else {

            for (int i = 0; i < keyArray.count - 1; i++) {

                [conditionString appendString:[NSString stringWithFormat:@"%@ = '%@'",[condition allKeys][i],[condition valueForKey:[condition allKeys][i]]]];

                [conditionString appendString:@" and "];

            }

            [conditionString appendString:[NSString stringWithFormat:@"%@ = '%@'",[condition allKeys][keyArray.count - 1],[condition valueForKey:[condition allKeys][keyArray.count - 1]]]];

        }

        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIMIT 100",tableName, conditionString]];

        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
        
    }else
        
        return nil;
}

- (NSArray *) dataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key beginWithStr:(NSString *)str;{

    if ([self isOpenDatabese:db]) {
        
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %@%% LIMIT 100",tableName, key, str]];
        
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
        
    }else
        
        return nil;
}

- (NSArray *) dataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key containStr:(NSString *)str;{

    if ([self isOpenDatabese:db]) {
        
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %%%@%% LIMIT 100",tableName, key, str]];
        
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
        
    }else
        
        return nil;
}

- (NSArray *) dataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key endWithStr:(NSString *)str;{

    if ([self isOpenDatabese:db]) {
        
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %%%@ LIMIT 100",tableName, key, str]];

        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
        
    }else
        
        return nil;
}

#pragma mark --CommonMethod
- (NSArray *) getArrWithFMResultSet:(FMResultSet *)result keyTypes:(NSDictionary *)keyTypes {
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    while ([result next]) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < keyTypes.count; i++) {
            
            NSString *key = [keyTypes allKeys][i];
            
            NSString *value = [keyTypes valueForKey:key];
            
            if ([value isEqualToString:@"text"]) {
                
                //  字符串
                [tempDic setValue:[result stringForColumn:key] forKey:key];
                
            } else if ([value isEqualToString:@"blob"]) {
                
                //  二进制对象
                [tempDic setValue:[result dataForColumn:key] forKey:key];
                
            } else if ([value isEqualToString:@"integer"]) {
                
                //  带符号整数类型
                [tempDic setValue:[NSNumber numberWithInt:[result intForColumn:key]]forKey:key];
                
            } else if ([value isEqualToString:@"boolean"]) {
                
                //  BOOL型
                [tempDic setValue:[NSNumber numberWithBool:[result boolForColumn:key]] forKey:key];

            } else if ([value isEqualToString:@"date"]) {
                
                //  date
                [tempDic setValue:[result dateForColumn:key] forKey:key];
                
            }

        }
        
        [tempArr addObject:tempDic];
        
    }
    
    return tempArr;

}

- (void) clearDatabase:(FMDatabase *)db from:(NSString *)tableName {

    if ([self isOpenDatabese:db]) {
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
    }
}

- (void) clearDatabase:(FMDatabase *)db from:(NSString *)tableName whereCondition:(NSDictionary *)condition {
    
    if ([self isOpenDatabese:db]) {
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName, [condition allKeys][0]], [condition valueForKey:[condition allKeys][0]]];
    }
}

- (BOOL) isOpenDatabese:(FMDatabase *)db {
    
    if (![db open]) {
        
        [db open];
        
    }
    return YES;
}

@end
