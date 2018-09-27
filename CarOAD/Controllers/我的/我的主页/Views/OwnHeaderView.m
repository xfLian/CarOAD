//
//  OwnHeaderView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/5.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OwnHeaderView.h"

@implementation OwnHeaderView

- (void)buildSubview {

    UIView *backView         = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, Screen_Width, 110 *Scale_Height)];
    backView.backgroundColor = [UIColor clearColor];
    backView.tag             = 500;
    [self addSubview:backView];

    UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake(15 *Scale_Width, 15 *Scale_Height, 80 *Scale_Height, 80 *Scale_Height)];
    imageView.image           = [UIImage imageNamed:@"contact_off_gray"];
    imageView.contentMode     = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds   = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius  = imageView.width / 2;
    imageView.tag                 = 200;
    [backView addSubview:imageView];

    {

        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"注册/登录"
                                                  font:UIFont_15
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:110];
        [backView addSubview:label];
        [label sizeToFit];
        label.frame = CGRectMake(imageView.x + imageView.width + 20 *Scale_Width, imageView.y + (imageView.height - 30 *Scale_Height) / 2, label.width + 20 *Scale_Width, 30 *Scale_Height);
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius  = 2 *Scale_Width;
        label.layer.borderWidth   = 1.f *Scale_Width;
        label.layer.borderColor   = [UIColor whiteColor].CGColor;
        label.hidden = NO;

    }

    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(imageView.x + imageView.width + 10 *Scale_Width, imageView.y, 100 *Scale_Height, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:[UIFont fontWithName:@"STHeitiSC-Medium" size:15.f *Scale_Width]
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [backView addSubview:nameLabel];
    nameLabel.hidden = YES;

    {

        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 10 *Scale_Height, 100 *Scale_Height, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_14
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:101];
        [backView addSubview:label];
        [label sizeToFit];
        label.frame = CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 10 *Scale_Height, label.width, 20 *Scale_Height);
        label.hidden = YES;
    }

    {

        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 40 *Scale_Height, 100 *Scale_Height, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@"信誉度"
                                                  font:UIFont_14
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:102];
        [backView addSubview:label];
        [label sizeToFit];
        label.frame = CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 40 *Scale_Height, label.width, 20 *Scale_Height);
        label.hidden = YES;

        for (int i = 0; i < 5; i++) {

            UIImageView *favoriteImageView    = [[UIImageView alloc] initWithFrame:CGRectMake(label.x + label.width + 6 *Scale_Width + 17 *Scale_Height *i, label.y + 3 *Scale_Height, 14 *Scale_Height, 14 *Scale_Height)];
            favoriteImageView.image           = [UIImage imageNamed:@"favorite_off_hollow"];
            favoriteImageView.contentMode     = UIViewContentModeScaleAspectFit;
            favoriteImageView.tag             = 300 + i;
            [backView addSubview:favoriteImageView];
            favoriteImageView.hidden = YES;

        }

    }

    UIImageView *arrowImageView    = [[UIImageView alloc]initWithFrame:CGRectMake(backView.width - 30 *Scale_Width, (backView.height - 15 *Scale_Height) / 2, 15 *Scale_Height, 15 *Scale_Height)];
    arrowImageView.image           = [UIImage imageNamed:@"arrow_right_white"];
    arrowImageView.contentMode     = UIViewContentModeScaleAspectFit;
    arrowImageView.tag             = 400;
    [backView addSubview:arrowImageView];

    {

        UIButton *button = [UIButton createWithTopAndButtomButtonForOwnWithFrame:backView.bounds
                                                                           title:nil
                                                                           image:nil
                                                                             tag:2000
                                                                          target:self
                                                                          action:@selector(buttonEvent:)];
        [backView addSubview:button];

    }

    UIView *buttonBackView         = [[UIView alloc]initWithFrame:CGRectMake(0, backView.y + backView.height, Screen_Width, self.height - (backView.y + backView.height))];
    buttonBackView.backgroundColor = [UIColor whiteColor];
    buttonBackView.tag             = 501;
    [self addSubview:buttonBackView];

    NSArray *buttonTitleArray = @[@"我的简历",@"我的投递",@"我的技能",@"我的接单"];
    NSArray *buttonImageArray = @[@"resume_gray",@"delivery_gray",@"skill_gray",@"connect_order_gray"];

    for (int i = 0; i < 4; i++) {

        UIButton *button = [UIButton createWithTopAndButtomButtonForOwnWithFrame:CGRectMake(Screen_Width / 4 *i, 0, Screen_Width / 4, Screen_Width / 16 *3)
                                                                           title:buttonTitleArray[i]
                                                                           image:[UIImage imageNamed:buttonImageArray[i]]
                                                                             tag:1000 + i
                                                                          target:self
                                                                          action:@selector(buttonEvent:)];
        [buttonBackView addSubview:button];

    }

    
}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 2000) {

        [_delegate gotoEdiUserInfomationWithData:self.data];
        
    } else if (sender.tag >= 1000 && sender.tag < 2000) {

        [_delegate clickTabBarButtonWithTag:sender.tag - 1000];

    }

}

- (void)loadContent {

    NSDictionary *model = self.data;

    NSString *userId = model[@"userId"];

    if (userId.length > 0) {

        NSString *userImgString     = model[@"userImg"];
        NSString *userNameString    = model[@"userName"];
        NSString *applyStateString  = model[@"applyState"];
        NSString *creditScoreString = [model[@"creditScore"] stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSInteger creditScore = [creditScoreString integerValue];
        NSInteger creditScoreX = creditScore / 10;
        NSInteger creditScoreY = creditScore % 10;
        NSMutableArray *imageViewArray = [[NSMutableArray alloc] init];

        if (self.subviews.count > 0) {

            for (UIView *backView in self.subviews) {

                if (backView.tag == 500) {

                    for (UIView *subView in backView.subviews) {

                        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 200) {

                            UIImageView *imageView = (UIImageView *)subView;

                            if (userImgString.length > 0) {

                                [QTDownloadWebImage downloadImageForImageView:imageView
                                                                     imageUrl:[NSURL URLWithString:userImgString]
                                                             placeholderImage:@"contact_off_gray"
                                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {

                                                                     }
                                                                      success:^(UIImage *finishImage) {

                                                                      }];

                            } else {

                                imageView.image = [UIImage imageNamed:@"contact_off_gray"];
                            }

                        }

                        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 110) {

                            UILabel *label = (UILabel *)subView;
                            label.hidden = YES;

                        }

                        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 100) {

                            UILabel *label = (UILabel *)subView;
                            label.hidden = NO;

                            if (userNameString.length > 0) {

                                label.text = userNameString;

                            } else {

                                label.text = @"***";

                            }

                            [label sizeToFit];
                            CGRect frame      = label.frame;
                            frame.size.width  = label.width;
                            frame.size.height = 20 *Scale_Height;
                            label.frame       = frame;

                        }

                        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

                            UILabel *label = (UILabel *)subView;
                            label.hidden = NO;

                            if (applyStateString.length > 0) {

                                label.text = applyStateString;

                            } else {

                                label.text = @"***";

                            }

                            [label sizeToFit];
                            CGRect frame      = label.frame;
                            frame.size.width  = label.width;
                            frame.size.height = 20 *Scale_Height;
                            label.frame       = frame;

                        }

                        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 102) {

                            UILabel *label = (UILabel *)subView;
                            label.hidden = NO;

                        }

                        if ([subView isKindOfClass:[UIImageView class]] && subView.tag >= 300 && subView.tag < 400) {

                            UIImageView *imageView = (UIImageView *)subView;
                            imageView.hidden       = NO;
                            imageView.image        = [UIImage imageNamed:@"favorite_off_hollow"];
                            [imageViewArray addObject:imageView];

                        }

                    }

                }

            }

        }

        if (creditScoreX > 0) {

            for (int i = 0; i < creditScoreX; i++) {

                UIImageView *imageView = imageViewArray[i];
                imageView.image        = [UIImage imageNamed:@"favorite_off_full"];

            }

            if (creditScoreY > 0) {

                UIImageView *imageView = imageViewArray[creditScoreX];
                imageView.image        = [UIImage imageNamed:@"favorite_off_hollow_full"];

            }

        } else {

            if (creditScoreY > 0) {

                UIImageView *imageView = imageViewArray[0];
                imageView.image        = [UIImage imageNamed:@"favorite_off_hollow_full"];

            }

        }

    } else {

        if (self.subviews.count > 0) {

            for (UIView *backView in self.subviews) {

                if (backView.tag == 500) {

                    for (UIView *subView in backView.subviews) {

                        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 200) {

                            UIImageView *imageView = (UIImageView *)subView;
                            imageView.image = [UIImage imageNamed:@"contact_off_gray"];

                        }

                        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 110) {

                            UILabel *label = (UILabel *)subView;
                            label.hidden = NO;

                        }

                        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 100) {

                            UILabel *label = (UILabel *)subView;
                            label.hidden = YES;

                        }

                        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

                            UILabel *label = (UILabel *)subView;
                            label.hidden = YES;

                        }

                        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 102) {

                            UILabel *label = (UILabel *)subView;
                            label.hidden = YES;

                        }

                        if ([subView isKindOfClass:[UIImageView class]] && subView.tag >= 300 && subView.tag < 400) {

                            UIImageView *imageView = (UIImageView *)subView;
                            imageView.hidden       = YES;

                        }

                    }

                }

            }
            
        }

    }

}

@end
