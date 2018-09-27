//
//  UserInfomationEdiSkillCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol UserInfomationEdiSkillCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

/**
 获取用户技能信息

 @param userSkill 用户技能内容
 */
- (void) getUserSkillString:(NSString *)userSkill;

- (void) showErrorMessage:(NSString *)message;

@end

@interface UserInfomationEdiSkillCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, UserInfomationEdiSkillCellDelegate> delegate;

@property (nonatomic, strong) id data;

- (void) loadContent;

@end
