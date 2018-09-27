//
//  UIScrollView+UITouch.m
//  LinJiaMaMa
//
//  Created by qiantang on 16/9/23.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)

+ (UIScrollView *)createScrollViewWithFrame:(CGRect)frame; {

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    return scrollView;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 选其一即可
    [super touchesBegan:touches withEvent:event];
}

@end
