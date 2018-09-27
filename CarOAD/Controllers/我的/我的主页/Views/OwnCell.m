//
//  OwnCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/4.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OwnCell.h"

@interface OwnCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *typeLabel;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation OwnCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.iconImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode   = UIViewContentModeScaleAspectFit;
    self.iconImageView.image         = [UIImage imageNamed:carPlaceholderImageString];
    [self.contentView addSubview:self.iconImageView];

    self.arrowImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.arrowImageView.contentMode   = UIViewContentModeScaleAspectFit;
    self.arrowImageView.image         = [UIImage imageNamed:@"arrow_right_gray"];
    [self.contentView addSubview:self.arrowImageView];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

    self.typeLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_13
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:101];
    [self.contentView addSubview:self.typeLabel];

    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];

}

- (void) layoutSubviews {

    self.iconImageView.frame = CGRectMake(15 *Scale_Width, (self.contentView.height - 20 *Scale_Height) / 2, 20 *Scale_Height, 20 *Scale_Height);

    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(self.contentView.width - 15 *Scale_Width - self.typeLabel.width, (self.contentView.height - 20 *Scale_Height) / 2, self.typeLabel.width, 20 *Scale_Height);

    self.arrowImageView.frame = CGRectMake(self.contentView.width - 22 *Scale_Width, (self.contentView.height - 14 *Scale_Height) / 2, 7 *Scale_Height, 14 *Scale_Height);

    self.titleLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, 0, self.contentView.width - (self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width), self.contentView.height);

    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);

}

- (void) loadContent {

    NSDictionary *model = self.data;

    NSString  *title      = model[@"title"];
    NSString  *iconImage  = model[@"iconImage"];
    NSString  *type       = model[@"type"];
    NSInteger  isShowLine = [model[@"isShowLine"] integerValue];

    self.iconImageView.image = [UIImage imageNamed:iconImage];

    if (title.length > 0) {

        self.titleLabel.text = title;

    } else {

        self.titleLabel.text = @"";

    }

    if (type.length > 0) {

        self.typeLabel.text        = type;
        self.arrowImageView.hidden = YES;

    } else {

        self.typeLabel.text        = @"";
        self.arrowImageView.hidden = NO;

    }

    if (isShowLine == 0) {

        self.lineView.hidden = YES;

    } else {

        self.lineView.hidden = NO;

    }

}

@end
