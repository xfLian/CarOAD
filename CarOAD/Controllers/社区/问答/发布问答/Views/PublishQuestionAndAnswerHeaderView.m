//
//  PublishQuestionAndAnswerHeaderView.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/6.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "PublishQuestionAndAnswerHeaderView.h"

#define Button_Width (self.width - 69 *Scale_Width) / 4
#define Button_Height 30 *Scale_Height

@interface PublishQuestionAndAnswerHeaderView()<UIScrollViewDelegate, UITextViewDelegate>
{
    
    NSInteger  view_tag;
    NSArray   *imagesArray;
    
}

@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;
@property (nonatomic, strong) NSMutableArray         *imageMutableArray;

@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSDictionary   *attributes;
@property (nonatomic, strong) UITextView     *textView;
@property (nonatomic, strong) UILabel        *firstPlaceholderLabel;
@property (nonatomic, strong) UILabel        *secondPlaceholderLabel;
@property (nonatomic, strong) UIView         *contentBackView;
@property (nonatomic, strong) UIButton       *addButton;
@property (nonatomic, strong) UILabel        *numberLabel;

@property (nonatomic, strong) UIView         *imageBackView;

@end

@implementation PublishQuestionAndAnswerHeaderView

- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        
        _buttonArray = [[NSMutableArray alloc] init];
    }
    
    return _buttonArray;
}

- (void)buildsubview {
    
    self.backgroundColor = BackGrayColor;
    
    UIView *buttonBackView         = [[UIView alloc] initWithFrame:CGRectZero];
    buttonBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:buttonBackView];
    
    if (self.buttonTitleArray.count > 4) {
        
        buttonBackView.frame = CGRectMake(0, 0, self.width, 90 *Scale_Height);
        
    } else {
        
        buttonBackView.frame = CGRectMake(0, 0, self.width, 50 *Scale_Height);
        
    }
    
    for (int i = 0; i < self.buttonTitleArray.count; i++) {
        
        NSInteger x = i % 4;
        NSInteger y = i / 4;
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(12 *Scale_Width + (Button_Width + 15 *Scale_Width) *x, 11 *Scale_Height + 39 *Scale_Height *y, Button_Width, 28 *Scale_Height)
                                                     title:self.buttonTitleArray[i]
                                           backgroundImage:nil
                                                       tag:1000 + i
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        
        [buttonBackView addSubview:button];
        
        [self.buttonArray addObject:button];
        
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13.f *Scale_Width];
        
        [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        button.layer.masksToBounds = YES;
        button.layer.borderWidth   = 0.7f;
        button.layer.cornerRadius  = 5 *Scale_Width;
        button.layer.borderColor   = TextGrayColor.CGColor;
        
        if (i == 0) {
            
            button.selected = YES;
            button.layer.borderColor = MainColor.CGColor;
            
        }
        
    }
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    //  选项卡按钮点击方法
    for (UIButton *button in self.buttonArray) {
        
        button.selected = NO;
        button.layer.borderColor = TextGrayColor.CGColor;
        
    }
    
    sender.selected = YES;
    sender.layer.borderColor = MainColor.CGColor;
    
    [_delegate chooseQATagWithTag:sender.tag - 1000];
    
}

@end
