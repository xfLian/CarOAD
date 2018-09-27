//
//  CustomScrollView.m
//  LinJiaMaMa
//
//  Created by qiantang on 16/9/13.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "CustomScrollView.h"

#define butWidth Screen_Width / 4

@interface CustomScrollView()

@property (nonatomic, strong) UIScrollView   *subViewScrollView;
@property (nonatomic, strong) UIButton       *tmpButton;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView         *lineView;

@end

@implementation CustomScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        
    }
    
    return self;

}

- (void) buildSubView {

    //  创建表头视图
    {
    
        CGRect frame      = CGRectZero;
        frame.origin.x    = 0;
        frame.origin.y    = 0;
        frame.size.width  = Screen_Width;
        
        if (self.titleView_H && self.titleView_H != 0) {
            
            frame.size.height = self.titleView_H;
            
        } else {
        
            frame.size.height = 44.f;
            
        }
        
        CGFloat titleLabel_W = 0;
        
        if (self.titleArray.count <= 4) {
            
            titleLabel_W = Screen_Width / self.titleArray.count;
            
        } else {
            
            titleLabel_W = Screen_Width / 4;
            
        }
        
        UIView *backView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:backView];
        
        self.buttonArray = [NSMutableArray array];
        
        //创建button
        {
            
            for (int i = 0; i < self.titleArray.count; i++) {
                
                CGFloat   butX   = i *butWidth;
                CGRect    frame  = CGRectMake(butX, 0, butWidth, backView.frame.size.height);
                UIButton *button = [UIButton createButtonWithFrame:frame
                                                             title:self.titleArray[i]
                                                   backgroundImage:nil
                                                               tag:1000 + i
                                                            target:self
                                                            action:@selector(buttonsEvent:)];
                
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
                
                [backView addSubview:button];
                
                [self.buttonArray addObject:button];
                
                if (i == 0) {
                    
                    self.tmpButton = button;
                }

            }
            
        }
        
        [self addSubview:backView];
        
        //  创建title间割线
        for (int i = 1; i < self.titleArray.count; i++) {
            
            UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(i *titleLabel_W, 7, 0.5, frame.size.height - 14)];
            lineView.backgroundColor = [UIColor blackColor];
            lineView.alpha           = 0.3f;
            [self addSubview:lineView];
            
        }
        
        //  创建隔线
        {
            
            UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.7, self.width, 0.7)];
            lineView.backgroundColor = [UIColor blackColor];
            lineView.alpha           = 0.3f;
            [self addSubview:lineView];
            
        }
        
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(butWidth / 4, frame.size.height - 2, butWidth / 2, 2)];
        lineView.backgroundColor = [UIColor orangeColor];
        [self addSubview:lineView];
        self.lineView = lineView;
        
    }
    
    //  创建内容view滚动视图
    {
        
        CGRect frame     = CGRectZero;
        frame.origin.x   = 0;
        frame.size.width = Screen_Width;
        
        if (self.titleView_H && self.titleView_H != 0) {
            
            frame.size.height = self.height - self.titleView_H;
            frame.origin.y    = self.titleView_H;
            
        } else {
            
            frame.size.height = self.height - 44.f;
            frame.origin.y    = 44.f;
            
        }
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.contentSize   = CGSizeMake(Screen_Width *self.viewArray.count, frame.size.height);
        scrollView.delegate      = self;
        scrollView.pagingEnabled                  = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        //  添加内容视图
        for (int i = 0; i < self.viewArray.count; i++) {
            
            UIView *subView = self.viewArray[i];
            subView.frame   = CGRectMake(Screen_Width *i, 0, Screen_Width, scrollView.height);
            [scrollView addSubview:subView];
        }
        
        [self addSubview:scrollView];
        
        self.subViewScrollView = scrollView;
        
    }
    
    self.tmpButton.selected = YES;
    
}

- (void) loadData {

    

}

- (void) buttonsEvent:(UIButton *)sender {
    
    if (sender != self.tmpButton) {
        
        sender.selected         = YES;
        self.tmpButton.selected = NO;
        
    }
    
    NSInteger i = sender.tag - 1000;
    CGFloat   y = 0;
    if (self.titleView_H && self.titleView_H != 0) {
        
        y = self.titleView_H;
        
    } else {
        
        y = 44.f;
        
    }
    self.lineView.x = i *sender.width + butWidth / 4;
    [self.subViewScrollView setContentOffset:CGPointMake(Screen_Width *i, 0) animated:YES];

    self.tmpButton = sender;
    
}

//  滚动视图代理方法
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {



}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    CGFloat   subViewCenterX = scrollView.contentOffset.x;
    NSInteger i              = subViewCenterX / Screen_Width;
    
    UIButton *button = self.buttonArray[i];
    [self buttonsEvent:button];
}

@end
