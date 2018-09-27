//
//  ChooseNeedInfomationItemCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseNeedInfomationItemCell.h"

@interface ChooseNeedInfomationItemCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ChooseNeedInfomationItemCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {

        [self buildSubview];
    }
    return self;
}

- (void)buildSubview {

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_14
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentCenter
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

}

- (void)layoutSubviews {

    [super layoutSubviews];

    self.titleLabel.frame = self.contentView.bounds;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.borderWidth   = 1.f;
    self.titleLabel.layer.cornerRadius  = 4.f *Scale_Width;

}

- (void) loadContent; {

    NSDictionary *model  = self.data;
    NSString *title      = model[@"title"];
    self.titleLabel.text = title;

    NSString *isSelected = model[@"isSelected"];

    if ([isSelected integerValue] == 0) {

        self.titleLabel.layer.borderColor = TextGrayColor.CGColor;
        self.titleLabel.textColor         = TextGrayColor;

    } else {

        self.titleLabel.layer.borderColor = MainColor.CGColor;
        self.titleLabel.textColor         = MainColor;

    }

}

@end
