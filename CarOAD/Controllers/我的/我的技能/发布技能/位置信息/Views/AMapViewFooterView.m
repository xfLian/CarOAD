//
//  AMapViewFooterView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/26.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AMapViewFooterView.h"

@implementation AMapViewFooterView

- (void)buildSubview {
    
    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, self.height)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, footerView.width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"上传"
                                           backgroundImage:nil
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = MainColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_16;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [footerView addSubview:button];
        
    }
    [self addSubview:footerView];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    [_delegate startPublishUserLocation];
    
}

@end
