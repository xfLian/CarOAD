//
//  UserInfomationEdiSexCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UserInfomationEdiSexCell.h"

@interface UserInfomationEdiSexCell()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *manButton;
@property (nonatomic, strong) UIButton *wemanButton;

@end

@implementation UserInfomationEdiSexCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"性别"
                                               font:UIFont_13
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentCenter
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

    UIButton *manButton = [UIButton createButtonWithFrame:CGRectZero
                                               buttonType:kButtonSel
                                                    title:nil
                                                    image:[UIImage imageNamed:@"sex_men_gray"]
                                                 higImage:[UIImage imageNamed:@"sex_men_gray_blue"]
                                                      tag:1000
                                                   target:self
                                                   action:@selector(buttonEvent:)];
    [self.contentView addSubview:manButton];
    self.manButton = manButton;

    UIButton *wemanButton = [UIButton createButtonWithFrame:CGRectZero
                                               buttonType:kButtonSel
                                                    title:nil
                                                    image:[UIImage imageNamed:@"sex_women_gray"]
                                                 higImage:[UIImage imageNamed:@"sex_women_gray_red"]
                                                      tag:1001
                                                   target:self
                                                   action:@selector(buttonEvent:)];
    [self.contentView addSubview:wemanButton];
    self.wemanButton = wemanButton;

    self.manButton.selected   = NO;
    self.wemanButton.selected = NO;

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        self.manButton.selected   = YES;
        self.wemanButton.selected = NO;

        [self.delegate getUserSexString:@"M"];

    } else {

        self.manButton.selected   = NO;
        self.wemanButton.selected = YES;

        [self.delegate getUserSexString:@"W"];

    }

}

- (void) layoutSubviews {

    self.titleLabel.frame  = CGRectMake(0, 5 *Scale_Height, Screen_Width, 20 *Scale_Height);
    self.manButton.frame   = CGRectMake(self.contentView.width / 2 - 70 *Scale_Height, self.titleLabel.height + 10 *Scale_Height, 60 *Scale_Height, 20 *Scale_Height);
    self.wemanButton.frame = CGRectMake(self.contentView.width / 2 + 10 *Scale_Height, self.titleLabel.height + 10 *Scale_Height, 60 *Scale_Height, 20 *Scale_Height);

}

- (void)loadContent {

    NSString *userSex = self.data;

    if (userSex.length > 0) {

        if ([userSex isEqualToString:@"M"]) {

            self.manButton.selected   = YES;
            self.wemanButton.selected = NO;

        } else {

            self.manButton.selected   = NO;
            self.wemanButton.selected = YES;

        }

    } else {

        self.manButton.selected   = NO;
        self.wemanButton.selected = NO;

    }

}

@end
