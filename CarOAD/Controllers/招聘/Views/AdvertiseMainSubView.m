//
//  AdvertiseMainSubView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AdvertiseMainSubView.h"

@interface AdvertiseMainSubView()

@property (nonatomic, strong) NSMutableArray *buttonBackArray;

@end

@implementation AdvertiseMainSubView

- (NSMutableArray *)buttonBackArray {

    if (!_buttonBackArray) {

        _buttonBackArray = [[NSMutableArray alloc] init];
    }

    return _buttonBackArray;
}

- (void)buildsubview {

    self.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i < self.buttonTitleArray.count; i++) {

        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(self.width / self.buttonTitleArray.count *i, 0, self.width / self.buttonTitleArray.count, self.height)];

        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:self.buttonTitleArray[i]
                                                  font:UIFont_15
                                             textColor:TextBlackColor
                                         textAlignment:NSTextAlignmentLeft tag:100];
        [backView addSubview:label];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode  = UIViewContentModeScaleAspectFit;
        imageView.image        = [UIImage imageNamed:@"arrow_down_gray"];
        imageView.tag          = 101;
        [backView addSubview:imageView];

        UIButton *button = [UIButton createButtonWithFrame:backView.bounds
                                                     title:nil
                                           backgroundImage:nil
                                                       tag:1000 + i
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [backView addSubview:button];
        [self.buttonBackArray addObject:backView];

        if (i < self.buttonTitleArray.count - 1) {

            UIView *h_lineView         = [[UIView alloc] initWithFrame:CGRectMake(backView.width - 0.5f, 5 *Scale_Height, 0.5f, backView.height - 10 *Scale_Height)];
            h_lineView.backgroundColor = LineColor;
            [backView addSubview:h_lineView];

        }

        [self addSubview:backView];

    }

    [self loadUI];

    UIView *h_lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5f, self.width, 0.5f)];
    h_lineView.backgroundColor = LineColor;
    [self addSubview:h_lineView];

}

- (void) loadUI {

    for (int i = 0; i < self.buttonBackArray.count; i++) {

        UIView *backView = self.buttonBackArray[i];

        CGFloat imageViewX = 0;

        for (UIView *subView in backView.subviews) {

            if ([subView isKindOfClass:[UILabel class]] && subView.tag == 100) {

                UILabel *label  = (UILabel *)subView;
                label.text      = self.buttonTitleArray[i];
                label.textColor = TextBlackColor;
                [label sizeToFit];

                CGFloat labelWidth = 0;
                if (label.width > (backView.width - 27 *Scale_Width)) {

                    labelWidth = backView.width - 27 *Scale_Width;

                } else {

                    labelWidth = label.width;

                }

                label.frame = CGRectMake((backView.width - (labelWidth + 17 *Scale_Width)) / 2, 0, labelWidth, backView.height);

                imageViewX = label.x + label.width + 5 *Scale_Width;

            }

            if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 101) {

                UIImageView *imageView = (UIImageView *)subView;

                imageView.image = [UIImage imageNamed:@"arrow_down_gray"];
                imageView.frame = CGRectMake(imageViewX, 0, 12 *Scale_Width, backView.height);

            }

            if ([subView isKindOfClass:[UIButton class]] && subView.tag >= 1000) {

                UIButton *button = (UIButton *)subView;
                button.selected = NO;

            }

        }

    }

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.selected == YES) {

        [self loadUI];

        [_delegate clickHideChooseTypeView];

    } else {

        [self loadUI];
        UIView *backView = self.buttonBackArray[sender.tag - 1000];
        for (UIView *subView in backView.subviews) {

            UIImageView *imageView;
            UILabel     *label;
            UIButton    *button;
            if ([subView isKindOfClass:[UILabel class]] && subView.tag == 100) {

                label           = (UILabel *)subView;
                label.textColor = MainColor;

            }

            if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 101) {

                imageView       = (UIImageView *)subView;
                imageView.image = [UIImage imageNamed:@"arrow_up_blue"];
                
            }

            if ([subView isKindOfClass:[UIButton class]] && subView.tag >= 1000) {

                button = (UIButton *)subView;
                button.selected = YES;

            }

        }

        [_delegate clickchooseButtonWithType:sender.tag - 1000];

    }

}

@end
