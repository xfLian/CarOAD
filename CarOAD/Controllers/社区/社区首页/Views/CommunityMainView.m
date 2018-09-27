//
//  CommunityMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityMainView.h"

#import "CommunityBigImageCell.h"
#import "CommunitySmallImageCell.h"
#import "CommunityMoreImageCell.h"
#import "CommunityNotImageCell.h"

#import "CommunityChooseCardView.h"

#import "QuestionAndAnswerModel.h"

#define Button_Height 50 *Scale_Height

@interface CommunityMainView()<UIScrollViewDelegate>
{
    
    NSInteger view_tag;

}

@property (nonatomic, strong) CommunityChooseCardView *chooseCardView;

@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) UIImageView *addButtonImageView;
@property (nonatomic, strong) UIView      *buttonBackView;
@property (nonatomic, strong) UIView      *buttonBackBlackView;

@property (nonatomic, strong) UIView *addQAButtonBackView;
@property (nonatomic, strong) UIView *addMovieButtonBackView;
@property (nonatomic, strong) UIView *addTextButtonBackView;

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, assign) CGRect addQAStartRect;
@property (nonatomic, assign) CGRect addQAEndRect;

@property (nonatomic, assign) CGRect addMovieStartRect;
@property (nonatomic, assign) CGRect addMovieEndRect;

@property (nonatomic, assign) CGRect addTextStartRect;
@property (nonatomic, assign) CGRect addTextEndRect;

@end

@implementation CommunityMainView

- (NSMutableArray *)buttonArray {

    if (!_buttonArray) {
        
        _buttonArray = [[NSMutableArray alloc] init];
    }

    return _buttonArray;
}

- (void)buildSubView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *buttonTitleArray = @[@"问答",@"视频",@"文章",@"资讯",@"新闻"];
    
    view_tag = 0;
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(Screen_Width / 5 *i, 0, Screen_Width / 5, Button_Height)
                                                     title:buttonTitleArray[i]
                                           backgroundImage:nil
                                                       tag:1000 + i
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        
        button.titleLabel.font = UIFont_15;
        [button setBackgroundImage:[UIImage imageNamed:@"icon_buttonback_grayline"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"icon_buttonback_blueline"] forState:UIControlStateSelected];
        
        [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        
        [self addSubview:button];
        
        if (i == 0) {
            
            button.selected = YES;
            
        }
        
        [self.buttonArray addObject:button];
        
    }
    
    UIScrollView *scrollView   = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Button_Height, Screen_Width, self.height - Button_Height)];
    scrollView.backgroundColor = BackGrayColor;
    scrollView.delegate        = self;
    scrollView.keyboardDismissMode = YES;
    scrollView.pagingEnabled    = YES;
    scrollView.scrollEnabled    = YES;
    [self addSubview:scrollView];
    
    for (int i = 0; i < self.viewsArray.count; i++) {
        
        UIView *subView = self.viewsArray[i];
        
        subView.frame = CGRectMake(scrollView.width *i, 0, scrollView.width, scrollView.height);
        
        [scrollView addSubview:subView];
        
    }
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.contentSize                    = CGSizeMake(Screen_Width *self.viewsArray.count, scrollView.height);
    self.scrollView = scrollView;
    
    {
        
        UIView *buttonBackView         = [[UIView alloc] initWithFrame:self.bounds];
        buttonBackView.backgroundColor = [UIColor clearColor];
        [self addSubview:buttonBackView];
        self.buttonBackView = buttonBackView;
        
        UIView *buttonBackBlackView         = [[UIView alloc] initWithFrame:buttonBackView.bounds];
        buttonBackBlackView.backgroundColor = [UIColor blackColor];
        buttonBackBlackView.alpha = 0.f;
        [buttonBackView addSubview:buttonBackBlackView];
        self.buttonBackBlackView = buttonBackBlackView;
        
        //  添加问答按钮
        {
            
            UIView *addQAButtonBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 156 *Scale_Width, buttonBackView.width, 46 *Scale_Width)];
            addQAButtonBackView.backgroundColor = [UIColor clearColor];
            [buttonBackView addSubview:addQAButtonBackView];
            self.addQAButtonBackView = addQAButtonBackView;
            
            self.addQAEndRect = addQAButtonBackView.frame;
            
            UIButton *button = [UIButton createButtonWithFrame:CGRectMake(Screen_Width - 60 *Scale_Width, 0, 46 *Scale_Width, addQAButtonBackView.height)
                                                              title:nil
                                                    backgroundImage:nil
                                                                tag:2003
                                                             target:self
                                                             action:@selector(buttonEvent:)];
            
            [button setBackgroundImage:[UIImage imageNamed:@"文章"] forState:UIControlStateNormal];
            [addQAButtonBackView addSubview:button];
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(button.x - 70 *Scale_Width, (addQAButtonBackView.height - 25 *Scale_Height) / 2, 65 *Scale_Width, 25 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"文章"
                                                      font:UIFont_15
                                                 textColor:[UIColor whiteColor]
                                             textAlignment:NSTextAlignmentCenter tag:100];
            label.backgroundColor     = [UIColor blackColor];
            label.layer.cornerRadius  = label.height / 2;
            label.layer.masksToBounds = YES;
            [addQAButtonBackView addSubview:label];
            
        }
        
        //  添加视频按钮
        {
            
            UIView *addMovieButtonBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 212 *Scale_Width, buttonBackView.width, 46 *Scale_Width)];
            addMovieButtonBackView.backgroundColor = [UIColor clearColor];
            [buttonBackView addSubview:addMovieButtonBackView];
            self.addMovieButtonBackView = addMovieButtonBackView;
            
            self.addMovieEndRect = addMovieButtonBackView.frame;
            
            UIButton *button = [UIButton createButtonWithFrame:CGRectMake(Screen_Width - 60 *Scale_Width, 0, 46 *Scale_Width, addMovieButtonBackView.height)
                                                         title:nil
                                               backgroundImage:nil
                                                           tag:2002
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            
            [button setBackgroundImage:[UIImage imageNamed:@"视频"] forState:UIControlStateNormal];
            [addMovieButtonBackView addSubview:button];
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(button.x - 70 *Scale_Width, (addMovieButtonBackView.height - 25 *Scale_Height) / 2, 65 *Scale_Width, 25 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"视频"
                                                      font:UIFont_15
                                                 textColor:[UIColor whiteColor]
                                             textAlignment:NSTextAlignmentCenter tag:100];
            label.backgroundColor     = [UIColor blackColor];
            label.layer.cornerRadius  = label.height / 2;
            label.layer.masksToBounds = YES;
            [addMovieButtonBackView addSubview:label];
            
        }
        
        //  添加文章按钮
        {
            
            UIView *addTextButtonBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 268 *Scale_Width, buttonBackView.width, 46 *Scale_Width)];
            addTextButtonBackView.backgroundColor = [UIColor clearColor];
            [buttonBackView addSubview:addTextButtonBackView];
            self.addTextButtonBackView = addTextButtonBackView;
            
            self.addTextEndRect = addTextButtonBackView.frame;
            
            UIButton *button = [UIButton createButtonWithFrame:CGRectMake(Screen_Width - 60 *Scale_Width, 0, 46 *Scale_Width, addTextButtonBackView.height)
                                                         title:nil
                                               backgroundImage:nil
                                                           tag:2001
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            
            [button setBackgroundImage:[UIImage imageNamed:@"问答"] forState:UIControlStateNormal];
            [addTextButtonBackView addSubview:button];
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(button.x - 70 *Scale_Width, (addTextButtonBackView.height - 25 *Scale_Height) / 2, 65 *Scale_Width, 25 *Scale_Height)
                                                 labelType:kLabelNormal
                                                      text:@"问答"
                                                      font:UIFont_15
                                                 textColor:[UIColor whiteColor]
                                             textAlignment:NSTextAlignmentCenter tag:100];
            label.backgroundColor     = [UIColor blackColor];
            label.layer.cornerRadius  = label.height / 2;
            label.layer.masksToBounds = YES;
            [addTextButtonBackView addSubview:label];
            
        }
        
        self.buttonBackBlackView.alpha = 0.f;
        self.buttonBackView.hidden     = YES;
        
    }
    
    //  创建添加按钮
    UIView *addButtonBackView         = [[UIView alloc] initWithFrame:CGRectMake(Screen_Width - 60 *Scale_Width, self.height - 100 *Scale_Width, 46 *Scale_Width, 46 *Scale_Width)];
    addButtonBackView.backgroundColor = [UIColor clearColor];
    [self addSubview:addButtonBackView];
    addButtonBackView.backgroundColor = CarOadColor(254, 202, 40);
    addButtonBackView.layer.cornerRadius  = addButtonBackView.height / 2;
    addButtonBackView.layer.masksToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((addButtonBackView.width - 25 *Scale_Width) / 2, (addButtonBackView.height - 25 *Scale_Width) / 2, 25 *Scale_Width, 25 *Scale_Width)];
    imageView.image        = [UIImage imageNamed:@"lxf_addwithdelebutton"];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    [addButtonBackView addSubview:imageView];
    self.addButtonImageView = imageView;
    
    UIButton *button = [UIButton createButtonWithFrame:addButtonBackView.bounds
                                            buttonType:kButtonNaviTitleView
                                                 title:nil
                                                 image:nil
                                              higImage:nil
                                                   tag:2000
                                                target:self
                                                action:@selector(buttonEvent:)];
    
    [addButtonBackView addSubview:button];
    self.addButton = button;
    
    CGRect frame = CGRectMake(0, self.height - 100 *Scale_Width, self.width, 40 *Scale_Width);
    self.addQAButtonBackView.frame = frame;
    self.addQAStartRect = frame;
    
    self.addMovieButtonBackView.frame = frame;
    self.addMovieStartRect = frame;
    
    self.addTextButtonBackView.frame = frame;
    self.addTextStartRect = frame;
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag >= 1000 && sender.tag < 2000) {
        
        view_tag = sender.tag - 1000;
        
        for (UIButton *button in self.buttonArray) {
            
            button.selected = NO;
        }
        
        sender.selected = YES;
        
        [self.scrollView scrollRectToVisible:CGRectMake(Screen_Width *view_tag, 0, Screen_Width, self.scrollView.height) animated:YES];
        
        [_delegate clickChooseCardButton:view_tag];
        
    } else if (sender.tag == 2000) {
        
        if (sender.selected == YES) {
            
            [self hideButtonBackView];
            
        } else {
            
            [self showButtonBackView];
            
        }
        
    } else if (sender.tag == 2001) {
        
        [_delegate clickAddMessageButtonWithTag:sender.tag - 2000];
        
    } else if (sender.tag == 2002) {
        
        [_delegate clickAddMessageButtonWithTag:sender.tag - 2000];
        
    } else if (sender.tag == 2003) {
        
        [_delegate clickAddMessageButtonWithTag:sender.tag - 2000];
        
    }
    
}

- (void)loadContent {
    

    
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    int index = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;

    [_delegate clickChooseCardButton:index];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    for (UIButton *button in self.buttonArray) {
        
        button.selected = NO;
    }
    
    int index = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    
    UIButton *button = self.buttonArray[index];
    
    button.selected = YES;
    
    [_delegate clickChooseCardButton:index];

}

/**
 *  显示动画
 *
 */
- (void)showButtonBackView; {
    
    self.buttonBackView.hidden = NO;
    self.buttonBackBlackView.alpha = 0.3f;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.addQAButtonBackView.frame    = self.addQAEndRect;
        self.addMovieButtonBackView.frame = self.addMovieEndRect;
        self.addTextButtonBackView.frame  = self.addTextEndRect;
        
    } completion:^(BOOL finished) {
        
    }];
    
    if (self.addButton.selected == NO) {
        
        //创建一个CGAffineTransform  transform对象
        CGAffineTransform transform;
        //设置旋转度数
        transform = CGAffineTransformRotate(self.addButtonImageView.transform,M_PI_4 *3);
        //动画开始
        [UIView beginAnimations:@"rotate" context:nil ];
        //动画时常
        [UIView setAnimationDuration:0.3f];
        //添加代理
        [UIView setAnimationDelegate:self];
        //获取transform的值
        [self.addButtonImageView setTransform:transform];
        //关闭动画
        [UIView commitAnimations];
        
    }
    
    self.addButton.selected = YES;
    
}

/**
 *  隐藏动画
 *
 */
- (void)hideButtonBackView; {
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.addQAButtonBackView.frame    = self.addQAStartRect;
        self.addMovieButtonBackView.frame = self.addMovieStartRect;
        self.addTextButtonBackView.frame  = self.addTextStartRect;
        
    } completion:^(BOOL finished) {
        
        self.buttonBackView.hidden     = YES;
        self.buttonBackBlackView.alpha = 0.f;
        
    }];
    
    if (self.addButton.selected == YES) {
        
        //创建一个CGAffineTransform  transform对象
        CGAffineTransform transform;
        //设置旋转度数
        transform = CGAffineTransformRotate(self.addButtonImageView.transform,-M_PI_4 *3);
        //动画开始
        [UIView beginAnimations:@"rotate" context:nil ];
        //动画时常
        [UIView setAnimationDuration:0.25f];
        //添加代理
        [UIView setAnimationDelegate:self];
        //获取transform的值
        [self.addButtonImageView setTransform:transform];
        //关闭动画
        [UIView commitAnimations];
        
    }
    
    self.addButton.selected = NO;
    
}

@end
