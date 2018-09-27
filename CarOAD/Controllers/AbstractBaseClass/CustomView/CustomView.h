//
//  CustomView.h
//  youIdea
//
//  Created by admin on 16/4/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

/**
 *  CustomView's data.
 */
@property (nonatomic, weak) id data;

/**
 *  Build subview, override by subclass.
 */
- (void)buildSubview;

/**
 *  Load content, override by subclass.
 */
- (void)loadContent;

@end
