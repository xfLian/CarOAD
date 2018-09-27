//
//  UserOptionsCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UserOptionsCell.h"

@interface UserOptionsCell()

@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *typeLabel;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation UserOptionsCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

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

    [self.typeLabel sizeToFit];

    self.typeLabel.frame = CGRectMake(self.arrowImageView.x - 5 *Scale_Width - self.typeLabel.width, 0, self.typeLabel.width, self.contentView.height);

    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 0, self.typeLabel.x - 15 *Scale_Width, self.contentView.height);

    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);

}

- (void) loadContent {

    NSDictionary *model = self.data;

    NSString  *title       = model[@"title"];
    NSString  *type        = model[@"type"];
    NSInteger  isShowArrow = [model[@"isShowArrow"] integerValue];
    NSInteger  isShowLine  = [model[@"isShowLine"] integerValue];
    
    if (title.length > 0) {
        
        self.titleLabel.text = title;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (isShowArrow == 0) {

        self.arrowImageView.image = [UIImage imageNamed:@"call_phone_blue"];
        self.arrowImageView.frame = CGRectMake(self.contentView.width - 30 *Scale_Width, (self.contentView.height - 20 *Scale_Height) / 2, 20 *Scale_Height, 20 *Scale_Height);

    } else {

        self.arrowImageView.image = [UIImage imageNamed:@"arrow_right_gray"];
        self.arrowImageView.frame = CGRectMake(self.contentView.width - 30 *Scale_Width, (self.contentView.height - 12 *Scale_Height) / 2, 22 *Scale_Height, 12 *Scale_Height);

    }

    if (type.length > 0) {

        self.typeLabel.text = type;

    } else {

        self.typeLabel.text = @"";

    }

    if (isShowLine == 0) {

        self.lineView.hidden = YES;

    } else {

        self.lineView.hidden = NO;

    }

}

@end
