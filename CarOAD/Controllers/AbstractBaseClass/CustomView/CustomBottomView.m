//
//  CustomBottomView.m
//  CarOAD
//
//  Created by xf_Lian on 2018/2/7.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "CustomBottomView.h"

@implementation CustomBottomView

+ (instancetype) createDefaultViewWithFrame:(CGRect)frame {
    
    CustomBottomView *bottomView = [[CustomBottomView alloc] initWithFrame:frame];
    bottomView.backgroundColor   = [UIColor whiteColor];
    
    UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomView.width, 0.5f)];
    lineView.backgroundColor = LineColor;
    [bottomView addSubview:lineView];
    
    return bottomView;
    
}

@end
