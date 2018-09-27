//
//  ChooseCarTypeLeftCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/3.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseCarTypeLeftCell.h"

@interface ChooseCarTypeLeftCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation ChooseCarTypeLeftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    if (self) {

        [self initSubViews];

    }

    return self;

}

- (void) initSubViews {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.iconImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode   = UIViewContentModeScaleAspectFit;
    self.iconImageView.image         = [UIImage imageNamed:carPlaceholderImageString];
    [self.contentView addSubview:self.iconImageView];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];

}

- (void) layoutSubviews {

    self.iconImageView.frame = CGRectMake(15 *Scale_Width, 5 *Scale_Height, self.contentView.height - 10 *Scale_Height, self.contentView.height - 10 *Scale_Height);

    self.titleLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, 0, self.contentView.width - (self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width), self.contentView.height);

    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);

}

- (void) loadContent {

    NSDictionary *model = self.data;

    NSString *brandName = model[@"brandName"];
    NSString *brandImg  = model[@"brandImg"];

    if (brandImg.length > 0) {

        [QTDownloadWebImage downloadImageForImageView:self.iconImageView
                                             imageUrl:[NSURL URLWithString:brandImg]
                                     placeholderImage:carPlaceholderImageString
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {

                                             }
                                              success:^(UIImage *finishImage) {

                                              }];

    } else {

        self.iconImageView.image = [UIImage imageNamed:carPlaceholderImageString];

    }

    if (brandName.length > 0) {

        self.titleLabel.text = brandName;

    } else {

        self.titleLabel.text = @"";

    }

}

// 配置cell选中状态
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    if (selected) {

        self.contentView.backgroundColor = BackGrayColor;
        self.titleLabel.textColor        = MainColor;

    } else {

        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor        = TextBlackColor;

    }
}

@end
