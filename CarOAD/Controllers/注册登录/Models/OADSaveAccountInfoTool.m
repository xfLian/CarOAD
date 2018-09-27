//
//  OADSaveAccountInfoTool.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADSaveAccountInfoTool.h"

@implementation OADSaveAccountInfoTool

+ (void)saveAccountInfo:(OADAccountInfo *)accountInfo; {

    [NSKeyedArchiver archiveRootObject:accountInfo toFile:OADAccountInfoFile];

}

/**
 *  返回存储的账号信息
 */
+ (OADAccountInfo *) accountInfo; {

    // 取出账号信息
    OADAccountInfo *account = [NSKeyedUnarchiver unarchiveObjectWithFile:OADAccountInfoFile];

    return account;

}

@end
