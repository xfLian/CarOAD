//
//  OADAboutUsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAboutUsViewController.h"

@interface OADAboutUsViewController ()

@end

@implementation OADAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (void)setNavigationController {

    self.navTitle     = @"关于我们";
    self.leftItemText = @"返回";
    [super setNavigationController];

}

- (void)buildSubView {

    [super buildSubView];

    UIView *backView         = [[UIView alloc]initWithFrame:self.contentView.bounds];
    backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:backView];

    {

        UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake((backView.width - 80 *Scale_Height) / 2, 50 *Scale_Height, 80 *Scale_Height, 80 *Scale_Height)];
        imageView.image           = [UIImage imageNamed:@"contact_off_gray"];
        imageView.contentMode     = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tag             = 200;
        [backView addSubview:imageView];

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, imageView.y + imageView.height + 10 *Scale_Height, backView.width, 20 *Scale_Height)
                                                  labelType:kLabelNormal
                                                       text:@"凯路登-技师端"
                                                       font:UIFont_M_18
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:100];
        [backView addSubview:titleLabel];

        UILabel *subTitleLabel = [UILabel createLabelWithFrame:CGRectMake(0, titleLabel.y + titleLabel.height + 10 *Scale_Height, backView.width, 20 *Scale_Height)
                                                  labelType:kLabelNormal
                                                       text:@"技术只有起点 创新没有终点"
                                                       font:UIFont_15
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:101];
        [backView addSubview:subTitleLabel];

        UILabel *versionLabel = [UILabel createLabelWithFrame:CGRectMake(0, subTitleLabel.y + subTitleLabel.height + 2 *Scale_Height, backView.width, 20 *Scale_Height)
                                                     labelType:kLabelNormal
                                                          text:Version
                                                          font:UIFont_13
                                                     textColor:TextGrayColor
                                                 textAlignment:NSTextAlignmentCenter
                                                           tag:102];
        [backView addSubview:versionLabel];

        {

            UIView *cellBackView          = [[UIView alloc]initWithFrame:CGRectMake(0, versionLabel.y + versionLabel.height + 40 *Scale_Height, Screen_Width, 88 *Scale_Height)];
            cellBackView.backgroundColor  = [UIColor whiteColor];
            [backView addSubview:cellBackView];

            {

                UILabel *firstCellTitleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 12 *Scale_Height, 180 *Scale_Width, 20 *Scale_Height)
                                                            labelType:kLabelNormal
                                                                 text:@"官方微信公众号"
                                                                 font:UIFont_15
                                                            textColor:TextBlackColor
                                                        textAlignment:NSTextAlignmentLeft
                                                                  tag:102];
                [cellBackView addSubview:firstCellTitleLabel];

            }

            {

                UILabel *firstCellContentLabel = [UILabel createLabelWithFrame:CGRectMake(cellBackView.width - 115 *Scale_Width, 12 *Scale_Height, 100 *Scale_Width, 20 *Scale_Height)
                                                                   labelType:kLabelNormal
                                                                        text:@"凯路登"
                                                                        font:UIFont_15
                                                                   textColor:TextBlackColor
                                                               textAlignment:NSTextAlignmentRight
                                                                         tag:102];
                [cellBackView addSubview:firstCellContentLabel];

            }

            {

                UILabel *secondCellTitleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 56 *Scale_Height, 180 *Scale_Width, 20 *Scale_Height)
                                                                   labelType:kLabelNormal
                                                                        text:@"去评价"
                                                                        font:UIFont_15
                                                                   textColor:TextBlackColor
                                                               textAlignment:NSTextAlignmentLeft
                                                                         tag:102];
                [cellBackView addSubview:secondCellTitleLabel];

            }

            {

                UIImageView *arrowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(cellBackView.width - 30 *Scale_Width, 60 *Scale_Height, 22 *Scale_Height, 12 *Scale_Height)];
                arrowImageView.contentMode   = UIViewContentModeScaleAspectFit;
                arrowImageView.image         = [UIImage imageNamed:@"arrow_right_gray"];
                [cellBackView addSubview:arrowImageView];

            }

            {

                UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 44 *Scale_Height, cellBackView.width, 44 *Scale_Height)
                                                                        title:nil
                                                              backgroundImage:nil
                                                                          tag:1000
                                                                       target:self
                                                                       action:@selector(buttonEvent:)];
                [cellBackView addSubview:button];

            }

            for (int i = 0; i < 3; i++) {

                UIView *lineView         = [[UIView alloc] initWithFrame:CGRectZero];
                lineView.backgroundColor = LineColor;
                [cellBackView addSubview:lineView];

                if (i == 0) {

                    lineView.frame = CGRectMake(0, 0, cellBackView.width, 0.5f);

                } else {

                    lineView.frame = CGRectMake(0, 44 *Scale_Height *i - 0.5f, cellBackView.width, 0.5f);

                }

            }

        }

    }

    UILabel *copyrightLabel = [UILabel createLabelWithFrame:CGRectMake(0, backView.height - 40 *Scale_Height - SafeAreaBottomHeight, backView.width, 20 *Scale_Height)
                                                labelType:kLabelNormal
                                                     text:@"Copyright © 2017 上海凯路登汽车科技有限公司"
                                                     font:UIFont_12
                                                textColor:TextGrayColor
                                            textAlignment:NSTextAlignmentCenter
                                                      tag:102];
    [backView addSubview:copyrightLabel];

}

- (void) buttonEvent:(UIButton *)sender {

    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/shan-shan-pen-di-fu-nu-jian/id1049660516?mt=8"];
    [[UIApplication sharedApplication] openURL:url];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
