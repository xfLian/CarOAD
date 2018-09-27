//
//  ResumeListNoDataView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ResumeListNoDataView.h"

@implementation ResumeListNoDataView

-(void) buildSubview {

    UIView *backView         = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, self.height - 64)];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];

    {

        UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake((backView.width - 80 *Scale_Height) / 2, 40 *Scale_Height, 80 *Scale_Height, 80 *Scale_Height)];
        imageView.image           = [UIImage imageNamed:@"contact_off_gray"];
        imageView.contentMode     = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tag             = 200;
        [backView addSubview:imageView];

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, imageView.y + imageView.height + 20 *Scale_Height, backView.width, 20 *Scale_Height)
                                                  labelType:kLabelNormal
                                                       text:@"您还没有创建个人简历！"
                                                       font:UIFont_M_17
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:100];
        [backView addSubview:titleLabel];

        UILabel *subTitleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, titleLabel.y + titleLabel.height + 20 *Scale_Height, backView.width - 30 *Scale_Width, 20 *Scale_Height)
                                                     labelType:kLabelNormal
                                                          text:@"1.填写完整正确的信息有助于获取更多的面试机会"
                                                          font:UIFont_15
                                                     textColor:TextGrayColor
                                                 textAlignment:NSTextAlignmentLeft
                                                           tag:101];
        [backView addSubview:subTitleLabel];

        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(subTitleLabel.x, subTitleLabel.y + subTitleLabel.height + 5 *Scale_Height, subTitleLabel.width, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@"2.最多可以添加3份简历"
                                                  font:UIFont_15
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:102];
        [backView addSubview:label];

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, label.y + label.height + 20 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"添加"
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

    [_delegate gotoCreateResume];
    
}

@end
