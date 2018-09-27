//
//  OADSureCertificationIdSuccessViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADSureCertificationIdSuccessViewController.h"

#import "OADOwnViewController.h"

@interface OADSureCertificationIdSuccessViewController ()

@end

@implementation OADSureCertificationIdSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setNavigationController {

    self.navTitle     = @"提交成功";
    self.leftItemText = @"返回";

    [super setNavigationController];

}

- (void)clickLeftItem {

    for (UIViewController *controller in self.navigationController.viewControllers) {

        if ([controller isKindOfClass:[OADOwnViewController class]]) {

            OADOwnViewController *viewController = (OADOwnViewController *)controller;
            [self.navigationController popToViewController:viewController animated:YES];

        }

    }

}

- (void)buildSubView {

    [super buildSubView];

    UIView *backView         = [[UIView alloc]initWithFrame:self.contentView.bounds];
    backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:backView];

    {

        UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake((backView.width - 80 *Scale_Height) / 2, 40 *Scale_Height, 80 *Scale_Height, 80 *Scale_Height)];
        imageView.image           = [UIImage imageNamed:@"contact_off_gray"];
        imageView.contentMode     = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tag             = 200;
        [backView addSubview:imageView];

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, imageView.y + imageView.height + 20 *Scale_Height, backView.width, 20 *Scale_Height)
                                                  labelType:kLabelNormal
                                                       text:@"实名认证资料提交成功"
                                                       font:UIFont_M_18
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:100];
        [backView addSubview:titleLabel];

        UILabel *subTitleLabel = [UILabel createLabelWithFrame:CGRectMake(0, titleLabel.y + titleLabel.height + 20 *Scale_Height, backView.width, 20 *Scale_Height)
                                                     labelType:kLabelNormal
                                                          text:@"凯路登平台正在审核您的申请信息"
                                                          font:UIFont_15
                                                     textColor:TextBlackColor
                                                 textAlignment:NSTextAlignmentCenter
                                                           tag:101];
        [backView addSubview:subTitleLabel];

        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(0, subTitleLabel.y + subTitleLabel.height + 5 *Scale_Height, backView.width, 20 *Scale_Height)
                                                    labelType:kLabelNormal
                                                         text:@"将在1-3个工作日内反馈结果"
                                                         font:UIFont_15
                                                    textColor:TextBlackColor
                                                textAlignment:NSTextAlignmentCenter
                                                          tag:102];
        [backView addSubview:label];

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, label.y + label.height + 20 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"确定"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = MainColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_17;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backView addSubview:button];

    }

}

- (void) buttonEvent:(UIButton *)sender {

    for (UIViewController *controller in self.navigationController.viewControllers) {

        if ([controller isKindOfClass:[OADOwnViewController class]]) {

            OADOwnViewController *viewController = (OADOwnViewController *)controller;
            [self.navigationController popToViewController:viewController animated:YES];

        }

    }

}

@end
