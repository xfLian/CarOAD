//
//  UserInfomationHeaderView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol UserInfomationHeaderViewDelegate <NSObject>

//  点击编辑用户资料
- (void) ediUserImage;

@end

@interface UserInfomationHeaderView : CustomView

@property (nonatomic, weak) id<UserInfomationHeaderViewDelegate> delegate;

@end
