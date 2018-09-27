//
//  NormalTabsView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "NormalTabsView.h"

@interface NormalTabsView()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *lineArray;

@end

@implementation NormalTabsView

- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        
        _buttonArray = [[NSMutableArray alloc] init];
    }
    
    return _buttonArray;
}

- (NSMutableArray *)lineArray {
    
    if (!_lineArray) {
        
        _lineArray = [[NSMutableArray alloc] init];
    }
    
    return _lineArray;
}

- (void)buildsubview {
    
    self.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < self.buttonTitleArray.count; i++) {
        
        NSInteger width = self.width / self.buttonTitleArray.count;
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(width *i, 0, width, self.height)
                                                     title:self.buttonTitleArray[i]
                                           backgroundImage:nil
                                                       tag:1000 + i
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:14.f *Scale_Width];
        
        [self addSubview:button];
        
        [self.buttonArray addObject:button];
        
        [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        
        UIView *h_lineView         = [[UIView alloc] initWithFrame:CGRectMake(width *i, self.height - 1.f, width, 1.f)];
        h_lineView.backgroundColor = LineColor;
        [self addSubview:h_lineView];
        [self.lineArray addObject:h_lineView];
        
        if (i == 0) {
            
            button.selected = YES;
            button.layer.borderColor   = MainColor.CGColor;
            h_lineView.backgroundColor = MainColor;
            h_lineView.frame = CGRectMake(0, self.height - 1.5f, width, 1.5f);
            
        } else {
            
            UIView *v_lineView         = [[UIView alloc] initWithFrame:CGRectMake(width *i - 0.5f, 8 *Scale_Height, 0.5f, self.height - 16 *Scale_Height)];
            v_lineView.backgroundColor = LineColor;
            [self addSubview:v_lineView];
            
        }
        
    }
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    for (UIButton *button in self.buttonArray) {
        
        button.selected = NO;
        button.layer.borderColor = TextBlackColor.CGColor;
    }
    
    for (UIView *h_lineView in self.lineArray) {
        
        h_lineView.backgroundColor = LineColor;
        CGRect frame      = h_lineView.frame;
        frame.origin.y    = self.height - 1.f;
        frame.size.height = 1.f;
        h_lineView.frame  = frame;
        
    }
    
    UIView *h_lineView = self.lineArray[sender.tag - 1000];
    h_lineView.backgroundColor = MainColor;
    CGRect frame      = h_lineView.frame;
    frame.origin.y    = self.height - 1.5f;
    frame.size.height = 1.5f;
    h_lineView.frame  = frame;
    
    sender.selected = YES;
    sender.layer.borderColor = MainColor.CGColor;
    
    [_delegate clickTabsButtonWithType:sender.tag - 1000];
    
}

@end
