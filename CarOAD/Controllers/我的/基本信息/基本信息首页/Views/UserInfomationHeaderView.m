//
//  UserInfomationHeaderView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UserInfomationHeaderView.h"

@implementation UserInfomationHeaderView

- (void)buildSubview {

    UIView *backView         = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, Screen_Width, 130 *Scale_Height)];
    backView.backgroundColor = [UIColor clearColor];
    backView.tag             = 500;
    [self addSubview:backView];

    UIButton *button = [UIButton createButtonWithFrame:backView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [backView addSubview:button];

    UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake((backView.width - 80 *Scale_Height) / 2, 10 *Scale_Height, 80 *Scale_Height, 80 *Scale_Height)];
    imageView.image           = [UIImage imageNamed:@"contact_off_gray"];
    imageView.contentMode     = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds   = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius  = imageView.width / 2;
    imageView.tag                 = 200;
    [backView addSubview:imageView];

    UIButton *chooseImageButton = [UIButton createButtonWithFrame:imageView.frame
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1001
                                                target:self
                                                action:@selector(buttonEvent:)];
    [backView addSubview:chooseImageButton];

    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(0, imageView.y + imageView.height + 10 *Scale_Height, backView.width, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@"一份好的工作从头像开始"
                                                  font:UIFont_13
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
    [backView addSubview:nameLabel];



}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        CarOadLog(@"选择背景图");

    } else {

        CarOadLog(@"选择头像");
        [_delegate ediUserImage];

    }

}

- (void)loadContent {

    if (self.subviews.count > 0) {

        for (UIView *backView in self.subviews) {

            if (backView.tag == 500) {

                for (UIView *subView in backView.subviews) {

                    if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 200) {

                        UIImageView *imageView = (UIImageView *)subView;

                        if ([self.data isKindOfClass:[UIImage class]]) {

                            UIImage *iamge  = self.data;
                            imageView.image = iamge;

                        } else {

                            NSString *userImgString = self.data;
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

                    }

                }

            }

        }

    }

}

@end
