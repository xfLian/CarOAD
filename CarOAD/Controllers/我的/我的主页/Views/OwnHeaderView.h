//
//  OwnHeaderView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/5.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol OwnHeaderViewDelegate <NSObject>

//  点击编辑用户资料
- (void) gotoEdiUserInfomationWithData:(id)data;
- (void) clickTabBarButtonWithTag:(NSInteger)tag;

@end

@interface OwnHeaderView : CustomView

@property (nonatomic, weak) id<OwnHeaderViewDelegate> delegate;

@end
