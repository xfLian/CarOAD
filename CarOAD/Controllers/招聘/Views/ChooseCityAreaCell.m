//
//  ChooseCityAreaCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseCityAreaCell.h"

@interface ChooseCityAreaCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *lineView;

@end

@implementation ChooseCityAreaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    if (self) {

        [self initSubViews];

    }

    return self;

}

- (void) initSubViews {

    self.contentView.backgroundColor = [UIColor whiteColor];

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

    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 0, self.contentView.width - 15 *Scale_Width, self.contentView.height);

    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);

}

- (void) loadContent {

    NSString *title = self.data;

    if (title.length > 0) {

        self.titleLabel.text = title;

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
