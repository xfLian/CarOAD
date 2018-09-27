//
//  UserInfomationEdiPhoneCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol UserInfomationEdiPhoneCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

/**
 修改用户手机号码

 @param phoneString 用户手机号码
 */
- (void) chooseUserPhoneWithPhoneString:(NSString *)phoneString;

@end

@interface UserInfomationEdiPhoneCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, UserInfomationEdiPhoneCellDelegate> delegate;

@property (nonatomic, strong) id phoneIdenti;

- (void) loadContent;

@end
