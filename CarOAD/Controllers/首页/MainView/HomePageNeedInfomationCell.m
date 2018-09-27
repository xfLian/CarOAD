//
//  HomePageNeedInfomationCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "HomePageNeedInfomationCell.h"

#import "DemandListData.h"

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface HomePageNeedInfomationCell()

@property (nonatomic, strong) UIImageView *smallImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *carLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView  *v_lineView;

@end

@implementation HomePageNeedInfomationCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.smallImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.smallImageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.smallImageView.clipsToBounds = YES;
    self.smallImageView.image         = [UIImage imageNamed:@"logo_back_image_small"];
    self.smallImageView.backgroundColor = BackGrayColor;
    [self.contentView addSubview:self.smallImageView];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@"凯路登"
                                                 font:UIFont_16
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    [self.contentView addSubview:self.titleLabel];

    self.carLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@"凯路登汽车"
                                              font:UIFont_12
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentCenter
                                               tag:101];
    [self.contentView addSubview:self.carLabel];

    self.typeLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@"底盘护板"
                                                      font:UIFont_12
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentCenter
                                                       tag:102];
    [self.contentView addSubview:self.typeLabel];

    self.priceLabel = [UILabel createLabelWithFrame:CGRectZero
                                        labelType:kLabelNormal
                                             text:@"¥4000"
                                             font:UIFont_14
                                        textColor:[UIColor redColor]
                                    textAlignment:NSTextAlignmentRight
                                              tag:103];
    [self.contentView addSubview:self.priceLabel];

    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.v_lineView];

}

- (void) layoutSubviews {

    self.smallImageView.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, Image_More_Height, Image_More_Height);

    self.titleLabel.frame = CGRectMake(self.smallImageView.x + self.smallImageView.width + 10 *Scale_Width, self.smallImageView.y, self.contentView.width - (self.smallImageView.x + self.smallImageView.width + 25 *Scale_Width), 20 *Scale_Height);

    [self.carLabel sizeToFit];
    self.carLabel.frame = CGRectMake(self.titleLabel.x, self.smallImageView.y + self.smallImageView.height - 20 *Scale_Height, self.carLabel.width + 10 *Scale_Width, 20 *Scale_Height);
    self.carLabel.layer.masksToBounds = YES;
    self.carLabel.layer.borderWidth   = 0.7f;
    self.carLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.carLabel.layer.cornerRadius  = 3.f *Scale_Width;

    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(self.carLabel.x + self.carLabel.width + 5 *Scale_Width, self.carLabel.y, self.typeLabel.width + 10 *Scale_Width, 20 *Scale_Height);
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.layer.borderWidth   = 0.7f;
    self.typeLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.typeLabel.layer.cornerRadius  = 3.f *Scale_Width;

    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(self.contentView.width - 15 *Scale_Width - self.priceLabel.width, self.carLabel.y, self.priceLabel.width, 20 *Scale_Height);

    self.v_lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);

}

- (void) loadContent {

    DemandListData *model = self.data;

    if (model.demandImg.length > 0) {

        [QTDownloadWebImage downloadImageForImageView:self.smallImageView
                                             imageUrl:[NSURL URLWithString:model.demandImg]
                                     placeholderImage:@"logo_back_image_small"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {

                                              }];

    } else {

        self.smallImageView.image = [UIImage imageNamed:@"logo_back_image_small"];

    }

    if (model.demandTitle.length > 0) {

        self.titleLabel.text = model.demandTitle;

    } else {

        self.titleLabel.text = @"";

    }

    if (model.carType.length > 0) {

        self.carLabel.text = model.carType;
        self.carLabel.hidden = NO;

    } else {

        self.carLabel.text   = @"";
        self.carLabel.hidden = YES;

    }

    if (model.demandType.length > 0) {

        self.typeLabel.text = model.demandType;
        self.typeLabel.hidden = NO;

    } else {

        self.typeLabel.text   = @"";
        self.typeLabel.hidden = YES;

    }

    if (model.price.length > 0) {

        self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];

    } else {

        self.priceLabel.text   = @"¥ 0";

    }

}

@end
