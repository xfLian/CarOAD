//
//  CVSettingIsOpenCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CVSettingIsOpenCell.h"

#import "ResumeListData.h"

@interface CVSettingIsOpenCell()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *contentLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView   *lineView;

@end

@implementation CVSettingIsOpenCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];
    
    self.button = [UIButton createWithLeftTextAndRightImageButtonWithFrame:CGRectZero
                                                                     title:@"公开"
                                                                     image:[UIImage imageNamed:@"arrow_right_gray"]
                                                                       tag:1000
                                                                    target:self
                                                                    action:@selector(buttonEvent:)];
    self.button.titleLabel.font = UIFont_15;
    [self.contentView addSubview:self.button];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];
    
}

- (void) layoutSubviews {
    
    self.titleLabel.frame = CGRectMake(25 *Scale_Width, 0, self.contentView.width - 40 *Scale_Width - self.contentView.height *1.5, self.contentView.height);
    
    self.button.frame = CGRectMake(self.contentView.width - self.contentView.height *1.5, 0, self.contentView.height *1.5, self.contentView.height);
    
    self.lineView.frame = CGRectMake(self.titleLabel.x, self.contentView.height - 0.5f, self.contentView.width - self.titleLabel.x, 0.5f);
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    [self.delegate clickSetOpenCVWithData:self.data];
    
}

- (void)loadContent {
    
    ResumeListData *model = self.data;
    
    if (model.skillPost.length > 0) {
        
        self.titleLabel.text = model.skillPost;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (model.isOpen.length > 0 && [model.isOpen integerValue] == 1) {
        
        [self.button setTitle:@"公开" forState:UIControlStateNormal];
        
    } else {
        
        [self.button setTitle:@"保密" forState:UIControlStateNormal];
        
    }
    
    self.button.tag = self.tag;
    
}

@end
