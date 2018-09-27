//
//  QTCustomViewController.h
//  LinJiaMaMa
//
//  Created by qiantang on 16/9/12.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTCustomViewController : UIViewController

/**
 *  控制器导航栏title
 */
@property (nonatomic, strong) NSString *navTitle;

/**
 *  控制器导航栏背景色
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  重置控制器导航栏
 */
- (void) setNavigationController;

@end
