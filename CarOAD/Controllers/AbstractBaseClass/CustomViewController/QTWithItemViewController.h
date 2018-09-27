//
//  QTWithItemViewController.h
//  LinJiaMaMa
//
//  Created by qiantang on 16/9/12.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "QTCustomViewController.h"

#import "CustomBottomView.h"

@interface QTWithItemViewController : QTCustomViewController

/**
 *  控制器导航栏左侧按钮text
 */
@property (nonatomic, strong) NSString *leftItemText;

/**
 *  控制器导航栏右侧按钮text
 */
@property (nonatomic, strong) NSString *rightItemText;
@property (nonatomic, strong) UIButton *rightItem;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) CustomBottomView *bottomView;

//  点击导航栏左侧按钮
- (void) clickLeftItem;

//  点击导航栏右侧按钮
- (void) clickRightItem;


- (void) buildSubView;

- (void) KeyboardHide;

- (void) addTop;

- (void) removeTap;

@end
