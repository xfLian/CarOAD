//
//  OADShareButtonView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADShareButtonView.h"

@interface OADShareButtonView()

@property (nonatomic, assign) CGRect stareRect;
@property (nonatomic, assign) CGRect endRect;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *messageView;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIWindow *windows;

@end

@implementation OADShareButtonView

- (void)buildView {

    //  获取目前页面窗口
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    self.windows      = windows;

    //  创建背景view
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windows.width,  windows.height)];

    //  创建容器view
    UIView   *contentView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width,  backView.height)];
    contentView.backgroundColor = [UIColor blackColor];
    contentView.alpha           = 0.4f;
    [backView addSubview:contentView];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(KeyboardHide)];
    tapGestureRecognizer.cancelsTouchesInView    = NO;
    [contentView addGestureRecognizer:tapGestureRecognizer];

    //  创建内容view
    UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   backView.height,
                                                                   backView.width, backView.width / 4 + SafeAreaBottomHeight)];
    messageView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:messageView];

    self.stareRect = messageView.frame;

    CGRect frame   = messageView.frame;
    frame.origin.y = backView.height - frame.size.height;
    self.endRect   = frame;

    //  添加确定按钮
    {

        NSArray *imageArray = @[@"wx_icon_hy",@"wx_icon_pyq",@"wx_icon_sc"];
        for (int i = 0; i < 3; i++) {

            UIButton *button = [UIButton createButtonWithFrame:CGRectMake(messageView.width / 4 *i, 0, messageView.width / 4, messageView.height)
                                                    buttonType:kButtonNormal
                                                         title:nil
                                                         image:nil
                                                      higImage:nil
                                                           tag:1000 + i
                                                        target:self
                                                        action:@selector(buttonEvent:)];

            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.x + (messageView.width / 4 - button.width *3 / 5) / 2, (messageView.width / 4 - button.width *3 / 5) / 2, button.width *3 / 5, button.width *3 / 5)];
            imageView.image        = [UIImage imageNamed:imageArray[i]];
            imageView.contentMode  = UIViewContentModeScaleAspectFill;
            [messageView addSubview:imageView];

            [messageView addSubview:button];

        }

    }

    [windows addSubview:backView];

    self.messageView = messageView;
    self.backView = backView;

}

- (void) show; {

    [self buildView];

    [UIView animateWithDuration:0.25f animations:^{

        self.messageView.frame = self.endRect;

    } completion:^(BOOL finished) {


    }];

}

- (void) hide; {

    [UIView animateWithDuration:0.2f animations:^{

        self.messageView.frame = self.stareRect;

    } completion:^(BOOL finished) {

        self.backView.alpha = 0.f;

        for (UIView *view in self.backView.subviews) {

            [view removeFromSuperview];

        }

        [self.backView removeFromSuperview];

    }];

}

- (void) KeyboardHide; {

    [self hide];

}

- (void) buttonEvent:(UIButton *)sender {

    [self hide];

    [_delegate clickSureButtonWithTag:sender.tag];

}

@end
