//
//  UIButton+inits.m
//  BaseController
//
//  Created by YouXianMing on 15/7/17.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "UIButton+inits.h"
#import "UIButton+LXMImagePosition.h"

//定义16进制颜色宏
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIButton (inits)

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                    backgroundImage:(UIImage *)image
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector {

    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:15.f *Scale_Width];
    button.tag                = tag;
    
    [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
    [button setTitleColor:MainColor forState:UIControlStateSelected];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                         buttonType:(EButtonType)type
                              title:(NSString *)title
                              image:(UIImage *)image
                           higImage:(UIImage *)higImage
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector {

    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:15.f];
    button.tag                = tag;
    
    if (type == kButtonNormal) {
        
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setImage:image    forState:UIControlStateNormal];
        [button setImage:higImage forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:TextBlackColor forState:UIControlStateHighlighted];
        
    } else if (type == kButtonGreen) {
    
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setImage:image    forState:UIControlStateNormal];
        [button setImage:higImage forState:UIControlStateHighlighted];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x43c7da) forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:17.f];
        
    } else if (type == kTabBarButton){
        
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setImage:image    forState:UIControlStateNormal];
        [button setImage:higImage forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
    } else if (type == kButtonSize){
        
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setImage:image    forState:UIControlStateNormal];
        [button setImage:higImage forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
    } else if (type == kButtonBlack) {
        
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:15.f];
        [button setBackgroundImage:image forState:UIControlStateNormal];
    } else if (type == kButtonSel) {
        
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:15.f];
        [button setImage:image    forState:UIControlStateNormal];
        [button setImage:higImage forState:UIControlStateSelected];
        
    } else if (type == kButtonTitleImage) {
        
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:12.f];
        [button setImage:image    forState:UIControlStateNormal];
        [button setImage:higImage forState:UIControlStateSelected];
        
        //设置image和title的位置
        button.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 21, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, - button.titleLabel.bounds.size.width - 62, - 60, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    } else if (type == kButtonNaviTitleView) {
        
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:17.f];
        
    }
    
    [button setTitle:title    forState:UIControlStateNormal];
    [button addTarget:target  action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)createWithTopAndButtomButtonWithFrame:(CGRect)frame
                                              title:(NSString *)title
                                              image:(UIImage *)image
                                                tag:(NSInteger)tag
                                             target:(id)target
                                             action:(SEL)selector; {
    
    CGFloat spacing = 3;
    
    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:12.f];
    button.layer.borderWidth  = 1.f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;
    button.layer.borderColor  = [UIColor clearColor].CGColor;
    [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
    [button setTitleColor:TextBlackColor forState:UIControlStateSelected];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setImagePosition:LXMImagePositionTop spacing:spacing];
    
    return button;

}

+ (UIButton *)createWithTopAndButtomButtonForResumeListWithFrame:(CGRect)frame
                                              title:(NSString *)title
                                              image:(UIImage *)image
                                                tag:(NSInteger)tag
                                             target:(id)target
                                             action:(SEL)selector; {

    CGFloat spacing = 5;

    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = UIFont_14;
    button.layer.borderWidth  = 1.f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;
    button.layer.borderColor  = [UIColor clearColor].CGColor;
    [button setTitleColor:TextGrayColor forState:UIControlStateNormal];
    [button setTitleColor:TextBlackColor forState:UIControlStateSelected];

    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];

    [button setImagePosition:LXMImagePositionTop spacing:spacing];

    return button;

}

+ (UIButton *)createWithTopAndButtomButtonForOwnWithFrame:(CGRect)frame
                                                    title:(NSString *)title
                                                    image:(UIImage *)image
                                                      tag:(NSInteger)tag
                                                   target:(id)target
                                                   action:(SEL)selector; {

    CGFloat spacing = 5;

    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"STHeitiSC-Medium" size:13.f *Scale_Width];
    button.layer.borderWidth  = 1.f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;
    button.layer.borderColor  = [UIColor clearColor].CGColor;
    [button setTitleColor:TextBlackColor forState:UIControlStateNormal];

    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];

    [button setImagePosition:LXMImagePositionTop spacing:spacing];

    return button;

}

+ (UIButton *)createWithLeftTextAndRightImageButtonWithFrame:(CGRect)frame
                                                       title:(NSString *)title
                                                       image:(UIImage *)image
                                                         tag:(NSInteger)tag
                                                      target:(id)target
                                                      action:(SEL)selector; {
    
    CGFloat spacing = 10;
    
    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:14.f];
    button.layer.borderWidth  = 1.f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;
    button.layer.borderColor  = [UIColor clearColor].CGColor;
    [button setTitleColor:TextGrayColor forState:UIControlStateNormal];
    [button setTitleColor:TextBlackColor forState:UIControlStateSelected];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setImagePosition:LXMImagePositionRight spacing:spacing];
    
    return button;

}

+ (UIButton *)createWithLeftImageAndRightTextButtonWithFrame:(CGRect)frame
                                                       title:(NSString *)title
                                                       image:(UIImage *)image
                                                         tag:(NSInteger)tag
                                                      target:(id)target
                                                      action:(SEL)selector; {
    
    CGFloat spacing = 5;
    
    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:13.f];
    button.tag                = tag;
    button.layer.borderColor  = [UIColor clearColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:TextBlackColor forState:UIControlStateSelected];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setImagePosition:LXMImagePositionLeft spacing:spacing];
    
    return button;
    
}

//
+ (UIButton *)createWithLeftImageAndRightTextButtonForPushMessageWithFrame:(CGRect)frame
                                                                     title:(NSString *)title
                                                             selectedTitle:(NSString *)selectedTitle
                                                                     image:(UIImage *)image
                                                                       tag:(NSInteger)tag
                                                                    target:(id)target
                                                                    action:(SEL)selector; {
    
    CGFloat spacing = 10;
    
    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:14.f *Scale_Width];
    button.layer.borderWidth  = 0.5f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;
    button.layer.borderColor  = TextGrayColor.CGColor;
    [button setTitleColor:TextGrayColor forState:UIControlStateNormal];
    [button setTitleColor:TextBlackColor forState:UIControlStateSelected];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setImagePosition:LXMImagePositionLeft spacing:spacing];
    
    return button;
    
}

//
+ (UIButton *)createWithLeftImageAndRightTextButtonForMessageDetailWithFrame:(CGRect)frame
                                                                       title:(NSString *)title
                                                               selectedTitle:(NSString *)selectedTitle
                                                                       image:(UIImage *)image
                                                                         tag:(NSInteger)tag
                                                                      target:(id)target
                                                                      action:(SEL)selector; {
    
    CGFloat spacing = 10;
    
    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:14.f *Scale_Width];
    button.tag                = tag;
    button.layer.borderColor  = TextGrayColor.CGColor;
    [button setTitleColor:TextGrayColor forState:UIControlStateNormal];
    [button setTitleColor:TextBlackColor forState:UIControlStateSelected];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setImagePosition:LXMImagePositionLeft spacing:spacing];
    
    return button;
    
}

@end
