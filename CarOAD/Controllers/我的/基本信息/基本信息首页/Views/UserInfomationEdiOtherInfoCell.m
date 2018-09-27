//
//  UserInfomationEdiOtherInfoCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UserInfomationEdiOtherInfoCell.h"

@interface UserInfomationEdiOtherInfoCell()

@end

@implementation UserInfomationEdiOtherInfoCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    NSArray *titleArray = @[@"所在城市",@"出生年月",@"最高学历",@"工作年限"];
    for (int i = 0; i < 4; i++) {

        [self createItemViewWithFrame:CGRectZero title:titleArray[i] tag:i];

    }

}

- (void) createItemViewWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag {

    UIView *backView = [[UIView alloc] initWithFrame:frame];
    backView.tag     = tag;

    {

        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:title
                                                   font:UIFont_13
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentCenter
                                                    tag:100];
        [backView addSubview:titleLabel];

        UILabel *statusLabel = [UILabel createLabelWithFrame:CGRectZero
                                               labelType:kLabelNormal
                                                    text:@"本科"
                                                    font:UIFont_15
                                               textColor:TextGrayColor
                                           textAlignment:NSTextAlignmentCenter
                                                     tag:101];
        statusLabel.adjustsFontSizeToFitWidth = YES;
        [backView addSubview:statusLabel];

        UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                                     title:nil
                                           backgroundImage:nil
                                                       tag:1000 + tag
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [backView addSubview:button];

    }

    [self.contentView addSubview:backView];

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        [self.delegate chooseUserAddressWithData:self.userAddress];

    } else if (sender.tag == 1001) {

        [self.delegate chooseUserBirthdayWithData:self.userBirthday];

    } else if (sender.tag == 1002) {

        [self.delegate chooseUserEducationWithData:self.userEducation];

    } else if (sender.tag == 1003) {

        [self.delegate chooseUserWorkExperienceWithData:self.userWorkExperience];
        
    }

}

- (void) layoutSubviews {

    CGRect frame      = CGRectZero;
    frame.origin.y    = 0;
    frame.size.width  = self.contentView.width / 4;
    frame.size.height = self.contentView.height;

    for (UIView *backView in self.contentView.subviews) {

        frame.origin.x = self.contentView.width / 4 *backView.tag;
        backView.frame = frame;

        for (UIView *subView in backView.subviews) {

            if (subView.tag == 100) {

                UILabel *label = (UILabel *)subView;
                label.frame    = CGRectMake(10 *Scale_Width, 5 *Scale_Height, backView.width - 20 *Scale_Width, 20 *Scale_Height);

            }

            if (subView.tag == 101) {

                UILabel *label = (UILabel *)subView;
                label.frame    = CGRectMake(10 *Scale_Width, 30 *Scale_Height, backView.width - 20 *Scale_Width, 20 *Scale_Height);

            }

            if (subView.tag >= 1000) {

                UIButton *button = (UIButton *)subView;
                button.frame     = backView.bounds;

            }

        }

    }

}

- (void)loadContent {

    NSMutableArray *viewDataArray = [NSMutableArray new];

    NSString *area      = self.userAddress;
    NSString *birthday  = self.userBirthday;
    NSString *topEdu    = self.userEducation;
    NSString *topYear   = self.userWorkExperience;

    NSArray *contentArray = @[@"请选择",@"请选择",@"请选择",@"请选择"];

    for (int i = 0; i < contentArray.count; i++) {

        NSString *title = nil;

        if (i == 0) {

            if (area.length > 0) {

                title = area;

            } else {

                title = contentArray[0];

            }

        } else if (i == 1) {

            if (birthday.length > 0) {

                title = birthday;

            } else {

                title = contentArray[1];

            }

        } else if (i == 2) {

            if (topEdu.length > 0) {

                title = topEdu;

            } else {

                title = contentArray[2];

            }

        } else if (i == 3) {

            if (topYear.length > 0) {

                title = topYear;

            } else {

                title = contentArray[3];

            }

        }

        [viewDataArray addObject:title];

    }

    for (UIView *backView in self.contentView.subviews) {

        for (UIView *subView in backView.subviews) {

            if (subView.tag == 101) {

                UILabel *label = (UILabel *)subView;
                label.text     = viewDataArray[backView.tag];

            }

        }

    }

}

@end
