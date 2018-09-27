//
//  UserInfomationEdiNameCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol UserInfomationEdiNameCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

/**
 获取用户真实姓名

 @param userName 用户真实姓名
 */
- (void) getUserNameString:(NSString *)userName;

@end

@interface UserInfomationEdiNameCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, UserInfomationEdiNameCellDelegate> delegate;

- (void) loadContent;

@end
