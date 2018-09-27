//
//  UserInfomationEdiJobStatusCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UserInfomationEdiJobStatusCell.h"

@interface UserInfomationEdiJobStatusCell()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *statusLabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation UserInfomationEdiJobStatusCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"求职状态"
                                               font:UIFont_13
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentCenter
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

    self.statusLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"请选择您目前的求职状态"
                                               font:UIFont_15
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentCenter
                                                tag:100];
    [self.contentView addSubview:self.statusLabel];

    UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [self.contentView addSubview:button];
    self.button = button;

}

- (void) buttonEvent:(UIButton *)sender {

    [self.delegate chooseUserJobStatus];

}

- (void) layoutSubviews {

    self.titleLabel.frame  = CGRectMake(0, 5 *Scale_Height, Screen_Width, 20 *Scale_Height);
    self.statusLabel.frame = CGRectMake(0, self.titleLabel.height + 10 *Scale_Height, Screen_Width, 20 *Scale_Height);
    self.button.frame      = self.contentView.bounds;

}

- (void)loadContent {

    NSString *title = self.data;

    if (title.length > 0) {

        self.statusLabel.text = title;

    } else {

        self.statusLabel.text = @"请选择您目前的求职状态";

    }

}

@end
