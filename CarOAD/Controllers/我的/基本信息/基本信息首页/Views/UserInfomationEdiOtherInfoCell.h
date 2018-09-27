//
//  UserInfomationEdiOtherInfoCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol UserInfomationEdiOtherInfoCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

/**
 选择用户所在位置

 @param data 页面目前显示的数据
 */
- (void) chooseUserAddressWithData:(id)data;

/**
 选择用户生日

 @param data 页面目前显示的数据
 */
- (void) chooseUserBirthdayWithData:(id)data;

/**
 选择用户学历

 @param data 页面目前显示的数据
 */
- (void) chooseUserEducationWithData:(id)data;

/**
 选择用户工作年限

 @param data 页面目前显示的数据
 */
- (void) chooseUserWorkExperienceWithData:(id)data;

@end

@interface UserInfomationEdiOtherInfoCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, UserInfomationEdiOtherInfoCellDelegate> delegate;

@property (nonatomic, strong) id userAddress;
@property (nonatomic, strong) id userBirthday;
@property (nonatomic, strong) id userEducation;
@property (nonatomic, strong) id userWorkExperience;

- (void) loadContent;

@end
