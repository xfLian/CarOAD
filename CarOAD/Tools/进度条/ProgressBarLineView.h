//
//  ProgressBarLineView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@interface ProgressBarLineView : CustomView

/**
 *  线条宽度
 */
@property (nonatomic)         CGFloat   lineWidth;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor  *lineColor;

/**
 *  开始角度
 */
@property (nonatomic)         CGFloat   startValue;

/**
 *  初始化view
 */
- (void)buildView;

/**
 *  做stroke动画
 *
 *  @param value    取值 [0, 1]
 *  @param animated 时候执行动画
 */
- (void)strokeEnd:(CGFloat)value animated:(BOOL)animated duration:(CGFloat)duration;

- (void)strokeStart:(CGFloat)value animated:(BOOL)animated duration:(CGFloat)duration;

/**
 *  创建出默认配置的view
 *
 *  @param frame 设置用的frame值
 *
 *  @return 实例对象
 */
+ (instancetype)createDefaultViewWithFrame:(CGRect)frame;

@end
