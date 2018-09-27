//
//  CertificationMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CertificationMainView.h"

@interface CertificationMainView ()<UITextFieldDelegate>
{

    BOOL idPhonoFrontIsRight;
    BOOL idPhonoBackIsRight;
    BOOL idPhonoWithHandIsRight;

}
@property (nonatomic, strong) UILabel  *nameContentLabel;
@property (nonatomic, strong) UILabel  *idCodeContentLabel;
@property (nonatomic, strong) UIButton *publiahButton;

@end

@implementation CertificationMainView

- (void)buildSubview {

    idPhonoFrontIsRight = NO;
    idPhonoBackIsRight = NO;
    idPhonoWithHandIsRight = NO;

    UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height + 64, Screen_Width - 30 *Scale_Width, 20 *Scale_Height)
                                                labelType:kLabelNormal
                                                     text:@"请扫描身份证件以获取您的真实姓名及身份证号"
                                                     font:UIFont_14
                                                textColor:TextGrayColor
                                            textAlignment:NSTextAlignmentLeft
                                                      tag:100];
    [self addSubview:contentLabel];

    UIView *textBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, contentLabel.y + contentLabel.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 90 *Scale_Height)];
    textBackView.layer.masksToBounds = YES;
    textBackView.layer.cornerRadius  = 5 *Scale_Height;
    textBackView.layer.borderWidth   = 0.5 *Scale_Width;
    textBackView.layer.borderColor   = LineColor.CGColor;
    textBackView.backgroundColor     = [UIColor whiteColor];
    [self addSubview:textBackView];

    {

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@"真实姓名:"
                                                       font:UIFont_15
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:100];
        [textBackView addSubview:titleLabel];
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(10 *Scale_Width, 0, titleLabel.width, textBackView.height / 2);

        UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(titleLabel.x + titleLabel.width + 10 *Scale_Width, 0, textBackView.width - (titleLabel.x + titleLabel.width + 10 *Scale_Width), titleLabel.height)
                                                  labelType:kLabelNormal
                                                       text:@""
                                                       font:UIFont_15
                                                  textColor:TextGrayColor
                                              textAlignment:NSTextAlignmentLeft
                                                        tag:100];
        [textBackView addSubview:contentLabel];
        self.nameContentLabel = contentLabel;

    }

    {

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@"身份证号:"
                                                       font:UIFont_15
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentCenter
                                                        tag:100];
        [textBackView addSubview:titleLabel];
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(10 *Scale_Width, textBackView.height / 2, titleLabel.width, textBackView.height / 2);

        UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(titleLabel.x + titleLabel.width + 10 *Scale_Width, titleLabel.y, textBackView.width - (titleLabel.x + titleLabel.width + 10 *Scale_Width), titleLabel.height)
                                                    labelType:kLabelNormal
                                                         text:@""
                                                         font:UIFont_15
                                                    textColor:TextGrayColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:101];
        [textBackView addSubview:contentLabel];
        self.idCodeContentLabel = contentLabel;

    }

    {

        UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, textBackView.height / 2 - 0.5 *Scale_Height, textBackView.width, 0.5 *Scale_Height)];
        lineView.backgroundColor = LineColor;
        [textBackView addSubview:lineView];

    }

    //  创建选择身份证照片
    {

        [self createChooseIdPhotoView:CGRectMake(15 *Scale_Width, textBackView.y + textBackView.height + 10 *Scale_Height, self.width / 2 - 20 *Scale_Width, (self.width / 2 - 20 *Scale_Width) *540 / 856 + 25 *Scale_Height)
                                title:@"扫描身份证人像面"
                                image:@"idCode"
                                  tag:0];

    }

    {

        [self createChooseIdPhotoView:CGRectMake(self.width / 2 + 5 *Scale_Width, textBackView.y + textBackView.height + 10 *Scale_Height, self.width / 2 - 20 *Scale_Width, (self.width / 2 - 20 *Scale_Width) *540 / 856 + 25 *Scale_Height)
                                title:@"上传身份证国徽面"
                                image:@"idCodelBack"
                                  tag:1];

    }

    {

        [self createChooseIdPhotoView:CGRectMake(15 *Scale_Width, textBackView.y + textBackView.height + 20 *Scale_Height + (self.width / 2 - 20 *Scale_Width) *540 / 856 + 25 *Scale_Height, self.width - 30 *Scale_Width, (self.width - 30 *Scale_Width) *540 / 856 + 25 *Scale_Height)
                                title:@"上传手持身份证照片，请确保身份证号码清晰可见"
                                image:@""
                                  tag:2];

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, self.height - 50 *Scale_Height, Screen_Width, 50 *Scale_Height)
                                                     title:@"提交"
                                           backgroundImage:nil
                                                       tag:2000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor = CarOadColor(129, 196, 255);
        button.titleLabel.font = UIFont_M_17;
        [button setTitleColor:CarOadColor(215, 233, 248) forState:UIControlStateNormal];
        [self addSubview:button];
        self.publiahButton = button;
        self.publiahButton.enabled = NO;

    }

}

- (void) createChooseIdPhotoView:(CGRect)frame title:(NSString *)title image:(NSString *)image tag:(NSInteger)tag {

    UIView *backView = [[UIView alloc] initWithFrame:frame];
    backView.backgroundColor = [UIColor clearColor];
    backView.tag             = 200 + tag;

    UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backView.width, backView.height - 25 *Scale_Height)];
    imageView.image           = [UIImage imageNamed:image];
    imageView.contentMode     = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = BackGrayColor;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius  = 5 *Scale_Width;
    imageView.tag                 = 300 + tag;
    [backView addSubview:imageView];

    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, imageView.y + imageView.height + 5 *Scale_Height, backView.width, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:title
                                                  font:UIFont_13
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
    [backView addSubview:titleLabel];

    UIButton *button = [UIButton createButtonWithFrame:backView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000 + tag
                                                target:self
                                                action:@selector(buttonEvent:)];
    [backView addSubview:button];

    [self addSubview:backView];


}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag >= 1000 && sender.tag < 2000) {

        [_delegate chooseIdCodePhotoWithTag:sender.tag - 1000];

    } else {



    }

}

- (void) loadUserNameAndIdCodeWithName:(NSString *)name idCode:(NSString *)idCode; {

    self.nameContentLabel.text   = name;
    self.idCodeContentLabel.text = idCode;

}

- (void) loadIdPhotoWithImage:(UIImage *)image tag:(NSInteger)tag; {

    if (tag == 0) {

        if (image) {

            idPhonoFrontIsRight = YES;

        } else {

            idPhonoFrontIsRight = NO;

        }

    } else if (tag == 1) {

        if (image) {

            idPhonoBackIsRight = YES;

        } else {

            idPhonoBackIsRight = NO;

        }

    } else if (tag == 2) {

        if (image) {

            idPhonoWithHandIsRight = YES;

        } else {

            idPhonoWithHandIsRight = NO;

        }

    }

    [self publishButtonIsCanClick];

    for (UIView *backView in self.subviews) {

        if (backView.tag >= 200 && backView.tag < 300) {

            for (UIView *subView in backView.subviews) {

                if (subView.tag >= 300 && backView.tag < 400 && [subView isKindOfClass:[UIImageView class]]) {

                    UIImageView *imageView = (UIImageView *)subView;

                    if (imageView.tag - 300 == tag) {

                        imageView.image = image;

                    }

                }

            }

        }

    }

}

- (void) publishButtonIsCanClick; {

    if (idPhonoBackIsRight == YES && idPhonoFrontIsRight == YES && idPhonoWithHandIsRight == YES) {

        self.publiahButton.enabled = YES;
        [self.publiahButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.publiahButton.backgroundColor = MainColor;

    } else {

        self.publiahButton.enabled = NO;
        [self.publiahButton setTitleColor:CarOadColor(215, 233, 248) forState:UIControlStateNormal];
        self.publiahButton.backgroundColor = CarOadColor(129, 196, 255);

    }


}

@end
