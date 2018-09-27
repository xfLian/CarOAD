//
//  ProgressBarLineView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ProgressBarLineView.h"

#import "LXFEasing.h"

@interface ProgressBarLineView ()

@property (nonatomic, strong) CAShapeLayer *lineLayer;// 圆形layer

@end
@implementation ProgressBarLineView

/**
 *  初始化frame值
 *
 *  @param frame 尺寸值
 *
 *  @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {

        //  创建出layer
        [self createLineLayer];

    }

    return self;
}

/**
 *  创建出layer
 */
- (void) createLineLayer {

    self.lineLayer       = [CAShapeLayer layer];
    self.lineLayer.frame = self.bounds;
    [self.layer addSublayer:self.lineLayer];
}

/**
 *  初始化view
 */
- (void) buildView {

    //  初始化信息
    CGFloat  lineWidth = (self.lineWidth <= 0 ? self.height : self.lineWidth);
    UIColor *lineColor = (self.lineColor == nil ? MainColor : self.lineColor);

    //  创建出贝塞尔曲线
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.height / 2)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(self.width, self.height / 2)];

    //  获取path
    self.lineLayer.path = linePath.CGPath;

    //  设置颜色
    self.lineLayer.strokeColor = lineColor.CGColor;

    self.lineLayer.fillColor   = [[UIColor clearColor] CGColor];
    self.lineLayer.lineWidth   = lineWidth;
    self.lineLayer.strokeEnd   = 0.f;

}

/**
 *  做stroke动画
 *
 *  @param value    取值 [0, 1]
 *  @param animated 时候执行动画
 */
- (void)strokeEnd:(CGFloat)value animated:(BOOL)animated duration:(CGFloat)duration {

    //  过滤掉不合理的值
    if (value <= 0) {

        value = 0;

    } else if (value >= 1) {

        value = 1.f;
    }

    if (animated) {

        //  关键帧动画
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeEnd";
        keyAnimation.duration             = duration;
        keyAnimation.values               = \
        [LXFEasing calculateFrameFromValue:self.lineLayer.strokeEnd
                                   toValue:value
                                      func:CubicEaseInOut
                                frameCount:duration * 30];

        self.lineLayer.fillColor = [MainColor CGColor];

        //  执行动画
        self.lineLayer.strokeEnd = value;
        [self.lineLayer addAnimation:keyAnimation forKey:nil];

    } else {

        //  关闭动画
        [CATransaction setDisableActions:YES];
        self.lineLayer.strokeEnd = value;
        [CATransaction setDisableActions:NO];

    }

}

- (void)strokeStart:(CGFloat)value animated:(BOOL)animated duration:(CGFloat)duration {

    //  过滤掉不合理的值
    if (value <= 0) {

        value = 0;

    } else if (value >= 1) {

        value = 1.f;

    }

    if (animated) {

        //  关键帧动画
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeStart";
        keyAnimation.duration             = duration;
        keyAnimation.values               = \
        [LXFEasing calculateFrameFromValue:self.lineLayer.strokeStart
                                   toValue:value
                                      func:CubicEaseInOut
                                frameCount:duration * 30];

        //  执行动画
        self.lineLayer.strokeStart = value;
        self.lineLayer.fillColor   = [[UIColor clearColor] CGColor];
        [self.lineLayer addAnimation:keyAnimation forKey:nil];

    } else {

        //  关闭动画
        [CATransaction setDisableActions:YES];
        self.lineLayer.strokeStart = value;
        [CATransaction setDisableActions:NO];

    }

}

/**
 *  创建出默认配置的view
 *
 *  @param frame 设置用的frame值
 *
 *  @return 实例对象
 */
+ (instancetype) createDefaultViewWithFrame:(CGRect)frame {

    ProgressBarLineView *lineView = [[ProgressBarLineView alloc] initWithFrame:frame];
    lineView.lineWidth            = lineView.height;
    lineView.lineColor            = MainColor;
    lineView.startValue           = 0;

    return lineView;
}

@end
