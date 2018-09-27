//
//  UserInfomationEdiSexCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol UserInfomationEdiSexCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

/**
 获取用户性别

 @param userSex 用户性别
 */
- (void) getUserSexString:(NSString *)userSex;

@end

@interface UserInfomationEdiSexCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, UserInfomationEdiSexCellDelegate> delegate;

- (void) loadContent;

@end
