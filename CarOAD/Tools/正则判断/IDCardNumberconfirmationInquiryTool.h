//
//  IDCardNumberconfirmationInquiryTool.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDCardNumberconfirmationInquiryTool : NSObject

/**
 验证身份证号码

 @param userID 用户身份证号码
 @return 是否为18位身份证
 */
+(BOOL)checkUserID:(NSString *)userID;


/**
 验证手机号

 手机号码 13[0-9],14[5|7|9],15[0-3],15[5-9],17[0|1|3|5|6|8],18[0-9]
 移动：134[0-8],13[5-9],147,15[0-2],15[7-9],178,18[2-4],18[7-8]
 联通：13[0-2],145,15[5-6],17[5-6],18[5-6]
 电信：133,1349,149,153,173,177,180,181,189
 虚拟运营商: 170[0-2]电信  170[3|5|6]移动 170[4|7|8|9],171 联通
 上网卡又称数据卡，14号段为上网卡专属号段，中国联通上网卡号段为145，中国移动上网卡号段为147，中国电信上网卡号段为149

 @param phoneNum 待验证的手机号
 @return 是否是正确的手机号
 */
+ (BOOL)isMobilePhone:(NSString *)phoneNum;


/**
 判断输入的是否全是数字

 @param checkedNumString 输入的字符串
 @return 返回结果
 */
+ (BOOL)isNum:(NSString *)checkedNumString;

@end
