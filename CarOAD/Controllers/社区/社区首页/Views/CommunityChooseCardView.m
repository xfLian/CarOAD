//
//  CommunityChooseCardView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityChooseCardView.h"

#define Button_Width (self.width - 69 *Scale_Width) / 4

@interface CommunityChooseCardView()

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation CommunityChooseCardView

- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        
        _buttonArray = [[NSMutableArray alloc] init];
    }
    
    return _buttonArray;
}

- (void)buildsubview {
    
    self.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i < self.buttonTitleArray.count; i++) {

        NSInteger x = i % 4;
        NSInteger y = i / 4;

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(12 *Scale_Width + (Button_Width + 15 *Scale_Width) *x, 11 *Scale_Height + 39 *Scale_Height *y, Button_Width, 28 *Scale_Height)
                                                     title:self.buttonTitleArray[i]
                                           backgroundImage:nil
                                                       tag:1000 + i
                                                    target:self
                                                    action:@selector(buttonEvent:)];

        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13.f *Scale_Width];

        [self addSubview:button];

        [self.buttonArray addObject:button];

        [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];

        button.backgroundColor     = [UIColor whiteColor];
        button.layer.masksToBounds = YES;
        button.layer.borderWidth   = 0.7f;
        button.layer.cornerRadius  = 5 *Scale_Width;
        button.layer.borderColor   = TextGrayColor.CGColor;

        if (i == 0) {

            button.selected = YES;
            button.layer.borderColor = MainColor.CGColor;

        }

    }

    UIView *h_lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5f, self.width, 0.5f)];
    h_lineView.backgroundColor = LineColor;
    [self addSubview:h_lineView];

}

- (void) buttonEvent:(UIButton *)sender {

    for (UIButton *button in self.buttonArray) {
        
        button.selected = NO;
        button.layer.borderColor = TextBlackColor.CGColor;
    }
    
    sender.selected = YES;
    sender.layer.borderColor = MainColor.CGColor;
    
    [_delegate clickClassifiedButtonWithType:sender.tag - 1000];
    
}

@end
