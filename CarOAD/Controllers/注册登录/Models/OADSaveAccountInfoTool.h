//
//  OADSaveAccountInfoTool.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OADAccountInfo;

@interface OADSaveAccountInfoTool : NSObject

/**
 *  存储账号信息
 *
 *  @param accountInfo 需要存储的账号
 */
+ (void)saveAccountInfo:(OADAccountInfo *)accountInfo;

/**
 *  返回存储的账号信息
 */
+ (OADAccountInfo *)accountInfo;

@end
