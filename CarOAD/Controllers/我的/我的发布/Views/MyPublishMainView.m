//
//  MyPublishMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyPublishMainView.h"

#define Button_Height 50 *Scale_Height

@interface MyPublishMainView()<UIScrollViewDelegate>
{

    NSInteger view_tag;

}

@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation MyPublishMainView

- (NSMutableArray *)buttonArray {

    if (!_buttonArray) {

        _buttonArray = [[NSMutableArray alloc] init];
    }

    return _buttonArray;
}

- (void)buildSubView {

    self.backgroundColor = [UIColor whiteColor];

    NSArray *buttonTitleArray = @[@"问答",@"视频",@"文章"];

    view_tag = 0;

    for (int i = 0; i < 3; i++) {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(Screen_Width / 3 *i, 0, Screen_Width / 3, Button_Height)
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

@end
