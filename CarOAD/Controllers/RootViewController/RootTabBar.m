//
//  RootTabBar.m
//  youIdea
//
//  Created by admin on 16/4/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RootTabBar.h"

@implementation RootTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *backView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 49 + SafeAreaBottomHeight)];
        backView.backgroundColor = [UIColor whiteColor];
        self.opaque              = YES;
        [self insertSubview:backView atIndex:0];
        
        UIView *line_view         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        line_view.backgroundColor = [UIColor lightGrayColor];
        line_view.alpha           = 0.3f;
        [backView addSubview:line_view];
        
    }
    
    return self;
}

/**
 *  重新排布系统控件subview的布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, Screen_Height - (49 + SafeAreaBottomHeight), Screen_Width, 49 + SafeAreaBottomHeight);
    
}

@end
