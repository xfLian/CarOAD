//
//  UIButton+inits.h
//  BaseController
//
//  Created by YouXianMing on 15/7/17.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    kButtonNormal,
    kButtonGreen,
    kButtonBlack,
    kTabBarButton,
    kButtonSize,
    kButtonSel,
    kButtonTitleImage,
    kButtonNaviTitleView,
    
} EButtonType;

@interface UIButton (inits)

/**
 *  创建button
 *
 *  @param frame    frame值
 *  @param title    标题
 *  @param image    图片
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                    backgroundImage:(UIImage *)image
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector;

/**
 *  创建button
 *
 *  @param frame    frame值
 *  @param type     类型
 *  @param title    标题
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                         buttonType:(EButtonType)type
                              title:(NSString *)title
                              image:(UIImage *)image
                           higImage:(UIImage *)higImage
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector;

/**
 *  创建带图片文字上下分布的button
 *
 *  @param frame    frame值
 *  @param title    标题
 *  @param image    图片
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createWithTopAndButtomButtonWithFrame:(CGRect)frame
                                              title:(NSString *)title
                                              image:(UIImage *)image
                                                tag:(NSInteger)tag
                                             target:(id)target
                                             action:(SEL)selector;

+ (UIButton *)createWithTopAndButtomButtonForResumeListWithFrame:(CGRect)frame
                                                           title:(NSString *)title
                                                           image:(UIImage *)image
                                                             tag:(NSInteger)tag
                                                          target:(id)target
                                                          action:(SEL)selector;

+ (UIButton *)createWithTopAndButtomButtonForOwnWithFrame:(CGRect)frame
                                              title:(NSString *)title
                                              image:(UIImage *)image
                                                tag:(NSInteger)tag
                                             target:(id)target
                                             action:(SEL)selector;

/**
 *  创建带图片文字左字右图分布的button
 *
 *  @param frame    frame值
 *  @param title    标题
 *  @param image    图片
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createWithLeftTextAndRightImageButtonWithFrame:(CGRect)frame
                                                       title:(NSString *)title
                                                       image:(UIImage *)image
                                                         tag:(NSInteger)tag
                                                      target:(id)target
                                                      action:(SEL)selector;

/**
 *  创建带图片文字左图右字分布的button
 *
 *  @param frame    frame值
 *  @param title    标题
 *  @param image    图片
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createWithLeftImageAndRightTextButtonWithFrame:(CGRect)frame
                                                       title:(NSString *)title
                                                       image:(UIImage *)image
                                                         tag:(NSInteger)tag
                                                      target:(id)target
                                                      action:(SEL)selector;

/**
 *  创建带图片文字左图右字分布的button用于发布帖子上边的按钮
 *
 *  @param frame    frame值
 *  @param title    标题
 *  @param image    图片
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createWithLeftImageAndRightTextButtonForPushMessageWithFrame:(CGRect)frame
                                                                     title:(NSString *)title
                                                             selectedTitle:(NSString *)selectedTitle
                                                                     image:(UIImage *)image
                                                                       tag:(NSInteger)tag
                                                                    target:(id)target
                                                                    action:(SEL)selector;

/**
 *  创建带图片文字左图右字分布的button用于帖子详情底部按钮
 *
 *  @param frame    frame值
 *  @param title    标题
 *  @param image    图片
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createWithLeftImageAndRightTextButtonForMessageDetailWithFrame:(CGRect)frame
                                                                       title:(NSString *)title
                                                               selectedTitle:(NSString *)selectedTitle
                                                                       image:(UIImage *)image
                                                                         tag:(NSInteger)tag
                                                                      target:(id)target
                                                                      action:(SEL)selector;


@end
