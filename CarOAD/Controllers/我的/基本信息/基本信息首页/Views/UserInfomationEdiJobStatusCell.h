//
//  UserInfomationEdiJobStatusCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol UserInfomationEdiJobStatusCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

/**
 选择用户求职状态
 */
- (void) chooseUserJobStatus;

@end

@interface UserInfomationEdiJobStatusCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, UserInfomationEdiJobStatusCellDelegate> delegate;

@property (nonatomic, strong) id data;

- (void) loadContent;

@end
