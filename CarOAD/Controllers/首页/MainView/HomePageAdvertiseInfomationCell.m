//
//  HomePageAdvertiseInfomationCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "HomePageAdvertiseInfomationCell.h"

#import "RecruitListData.h"

@interface HomePageAdvertiseInfomationCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *contentBackView;
@property (nonatomic, strong) UIView *firstBackView;
@property (nonatomic, strong) UIView *secondBackView;
@property (nonatomic, strong) UIView *thirdBackView;
@property (nonatomic, strong) UIView *forthBackView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation HomePageAdvertiseInfomationCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = BackGrayColor;

    self.contentBackView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contentBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.contentBackView];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_16
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    [self.contentBackView addSubview:self.titleLabel];

    self.priceLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"0"
                                               font:UIFont_14
                                          textColor:[UIColor redColor]
                                      textAlignment:NSTextAlignmentRight
                                                tag:101];
    [self.contentBackView addSubview:self.priceLabel];

    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_14
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:102];
    [self.contentBackView addSubview:self.contentLabel];

    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_12
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentRight
                                                  tag:103];
    [self.contentBackView addSubview:self.dateLabel];

    self.firstBackView = [self createTagViewWithImage:@"location_address"];
    self.firstBackView.backgroundColor = [UIColor clearColor];
    [self.contentBackView addSubview:self.firstBackView];

    self.secondBackView = [self createTagViewWithImage:@"job_limit"];
    self.secondBackView.backgroundColor = [UIColor clearColor];
    [self.contentBackView addSubview:self.secondBackView];

    self.thirdBackView = [self createTagViewWithImage:@"educational_background"];
    self.thirdBackView.backgroundColor = [UIColor clearColor];
    [self.contentBackView addSubview:self.thirdBackView];

    self.forthBackView = [self createTagViewWithImage:@"job_specification"];
    self.forthBackView.backgroundColor = [UIColor clearColor];
    [self.contentBackView addSubview:self.forthBackView];

    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentBackView addSubview:self.lineView];

}

- (UIView *) createTagViewWithImage:(NSString *)imageString {

    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:imageString];
    imageView.tag          = 100;
    imageView.backgroundColor = [UIColor clearColor];
    [backView addSubview:imageView];

    UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_12
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:101];
    label.backgroundColor = [UIColor clearColor];
    [backView addSubview:label];

    return backView;

}

- (void) layoutSubviews {

    self.contentBackView.frame = CGRectMake(0, 0, self.contentView.width, 100 *Scale_Height);

    [self.priceLabel sizeToFit];

    self.priceLabel.frame = CGRectMake(self.contentView.width - self.priceLabel.width - 15 *Scale_Width, 10 *Scale_Height, self.priceLabel.width, 20 *Scale_Height);

    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.priceLabel.x - 25 *Scale_Width, 20 *Scale_Height);

    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(self.contentView.width - self.dateLabel.width - 15 *Scale_Width, self.priceLabel.y + self.priceLabel.height + 5 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);

    self.contentLabel.frame = CGRectMake(self.titleLabel.x, self.titleLabel.y + self.titleLabel.height + 5 *Scale_Height, self.dateLabel.x - 30 *Scale_Width, 20 *Scale_Height);

    self.firstBackView.frame = CGRectMake(15 *Scale_Width, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, (self.contentView.width - 15 *Scale_Width) / 4, 25 *Scale_Height);

    for (UIView *subView in self.firstBackView.subviews) {

        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 100) {

            subView.frame = CGRectMake(0, (self.firstBackView.height - 16 *Scale_Height) / 2, 16 *Scale_Height, 16 *Scale_Height);

        }

        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

            subView.frame = CGRectMake(20 *Scale_Height, 0, self.firstBackView.width - (20 *Scale_Height + 10 *Scale_Width), self.firstBackView.height);

        }

    }

    self.secondBackView.frame = CGRectMake(self.firstBackView.x + self.firstBackView.width, self.firstBackView.y, self.firstBackView.width, self.firstBackView.height);

    for (UIView *subView in self.secondBackView.subviews) {

        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 100) {

            subView.frame = CGRectMake(0, (self.firstBackView.height - 16 *Scale_Height) / 2, 16 *Scale_Height, 16 *Scale_Height);

        }

        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

            subView.frame = CGRectMake(20 *Scale_Height, 0, self.secondBackView.width - (20 *Scale_Height + 10 *Scale_Width), self.secondBackView.height);

        }

    }

    self.thirdBackView.frame = CGRectMake(self.secondBackView.x + self.secondBackView.width, self.firstBackView.y, self.firstBackView.width, self.firstBackView.height);

    for (UIView *subView in self.thirdBackView.subviews) {

        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 100) {

            subView.frame = CGRectMake(0, (self.firstBackView.height - 16 *Scale_Height) / 2, 16 *Scale_Height, 16 *Scale_Height);

        }

        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

            subView.frame = CGRectMake(20 *Scale_Height, 0, self.thirdBackView.width - (20 *Scale_Height + 10 *Scale_Width), self.thirdBackView.height);

        }

    }

    self.forthBackView.frame = CGRectMake(self.thirdBackView.x + self.thirdBackView.width, self.firstBackView.y, self.firstBackView.width, self.firstBackView.height);

    for (UIView *subView in self.forthBackView.subviews) {

        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 100) {

            subView.frame = CGRectMake(0, (self.firstBackView.height - 16 *Scale_Height) / 2, 16 *Scale_Height, 16 *Scale_Height);

        }

        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

            subView.frame = CGRectMake(20 *Scale_Height, 0, self.forthBackView.width - (20 *Scale_Height + 10 *Scale_Width), self.forthBackView.height);

        }

    }

    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentBackView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);

}

- (void) loadContent {

    RecruitListData *model = self.data;

    if (model.skillPost.length > 0) {

        self.titleLabel.text = model.skillPost;

    } else {

        self.titleLabel.text = @"";

    }

    if (model.salaryRange.length > 0) {

        self.priceLabel.text = model.salaryRange;

    } else {

        self.priceLabel.text = @"";

    }

    if (model.ShopName.length > 0) {

        self.contentLabel.text = model.ShopName;

    } else {

        self.contentLabel.text = @"";

    }

    if (model.isShowPublicDate == YES) {

        self.dateLabel.hidden = NO;
        self.lineView.hidden  = YES;

        if (model.publicDate.length > 0) {

            self.dateLabel.text = model.publicDate;

        } else {

            self.dateLabel.text = @"";

        }
        
    } else {

        self.dateLabel.hidden = YES;
        
    }

    for (UIView *subView in self.firstBackView.subviews) {

        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

            UILabel *label = (UILabel *)subView;

            if (model.cityArea.length > 0) {

                label.text = model.cityArea;

            } else {

                label.text = @"";

            }

        }

    }

    for (UIView *subView in self.secondBackView.subviews) {

        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

            UILabel *label = (UILabel *)subView;

            if (model.expDuty.length > 0) {

                label.text = model.expDuty;

            } else {

                label.text = @"";

            }

        }

    }

    for (UIView *subView in self.thirdBackView.subviews) {

        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

            UILabel *label = (UILabel *)subView;

            if (model.eduDuty.length > 0) {

                label.text = model.eduDuty;

            } else {

                label.text = @"";

            }

        }

    }

    for (UIView *subView in self.forthBackView.subviews) {

        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {

            UILabel *label = (UILabel *)subView;

            if (model.workNature.length > 0) {

                label.text = model.workNature;

            } else {

                label.text = @"";

            }

        }

    }


}

@end
