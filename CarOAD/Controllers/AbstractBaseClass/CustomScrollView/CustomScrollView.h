//
//  CustomScrollView.h
//  LinJiaMaMa
//
//  Created by qiantang on 16/9/13.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollView : UIView<UIScrollViewDelegate>

/**
 *  加载标题数组
 */
@property (nonatomic, strong) NSArray *titleArray;

/**
 *  加载内容子视图数组
 */
@property (nonatomic, strong) NSArray *viewArray;

/**
 *  titleView的高度
 */
@property (nonatomic, assign) CGFloat  titleView_H;

- (void) buildSubView;
- (void) loadData;

@end
