//
//  UserInfomationEdiPhoneCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UserInfomationEdiPhoneCell.h"

@interface UserInfomationEdiPhoneCell()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIView   *v_lineView;
@property (nonatomic, strong) UILabel  *phoneLabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation UserInfomationEdiPhoneCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"手机号码"
                                               font:UIFont_13
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentCenter
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

    self.phoneLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentCenter
                                                tag:100];
    [self.contentView addSubview:self.phoneLabel];

    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = TextGrayColor;
    [self.contentView addSubview:self.v_lineView];

    UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                                 title:@"添加"
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    button.titleLabel.font = UIFont_15;
    [button setTitleColor:TextGrayColor forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    self.button = button;

}

- (void) buttonEvent:(UIButton *)sender {

    [self.delegate chooseUserPhoneWithPhoneString:nil];

}

- (void) layoutSubviews {

    self.titleLabel.frame  = CGRectMake(0, 5 *Scale_Height, Screen_Width, 20 *Scale_Height);

    if (self.phoneLabel.text.length > 0) {

        self.phoneLabel.hidden = NO;
        self.v_lineView.hidden = NO;

        [self.phoneLabel sizeToFit];
        self.phoneLabel.frame = CGRectMake((self.contentView.width - self.phoneLabel.width - 11.5 *Scale_Width - 65 *Scale_Width) / 2, self.titleLabel.height + 10 *Scale_Height, self.phoneLabel.width, 20 *Scale_Height);

        self.v_lineView.frame  = CGRectMake(self.phoneLabel.x + self.phoneLabel.width + 10 *Scale_Width, self.phoneLabel.y + 3 *Scale_Height, 1.5 *Scale_Width, 14 *Scale_Height);

        self.button.frame      = CGRectMake(self.v_lineView.x + self.v_lineView.width + 10 *Scale_Width, self.phoneLabel.y + 2 *Scale_Height, 55 *Scale_Width, 18 *Scale_Height);
        self.button.layer.masksToBounds = YES;
        self.button.layer.cornerRadius  = self.button.height / 2;

    } else {

        self.phoneLabel.hidden = YES;
        self.v_lineView.hidden = YES;
        self.button.frame      = CGRectMake((self.contentView.width - 60 *Scale_Width) / 2, self.titleLabel.height + 10 *Scale_Height, 60 *Scale_Width, 20 *Scale_Height);

    }

}

- (void)loadContent {

    NSString *userPhone = self.data;

    if (userPhone.length > 0) {

        self.phoneLabel.text = userPhone;

    } else {

        self.phoneLabel.text = @"";

    }

    NSString *phoneIdenti = self.phoneIdenti;
    if ([phoneIdenti isEqualToString:@"Y"]) {

        self.button.titleLabel.font = UIFont_15;
        [self.button setTitle:@"修改" forState:UIControlStateNormal];
        [self.button setTitleColor:TextGrayColor forState:UIControlStateNormal];
        self.button.backgroundColor = [UIColor clearColor];

    } else {

        self.button.titleLabel.font = UIFont_12;
        [self.button setTitle:@"需验证" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.button.backgroundColor = CarOadColor(210, 33, 33);
        
    }

}

@end
