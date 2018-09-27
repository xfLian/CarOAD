//
//  CreateCVHeaderView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/15.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CreateCVHeaderView.h"

@interface CreateCVHeaderView ()

@property (nonatomic, strong) UIView     *backView;
@property (nonatomic, strong) UIView     *contentBackView;
@property (nonatomic, strong) UIButton   *button;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *typeLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, assign) BOOL isShowButton;

@end

@implementation CreateCVHeaderView

- (void)buildSubview {
    
    UIView *backView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50 *Scale_Height)];
    backView.backgroundColor = BackGrayColor;
    [self addSubview:backView];
    self.backView = backView;
    
    UIView *contentView         = [[UIView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Height, Screen_Width, 40 *Scale_Height)];
    contentView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:contentView];
    self.contentBackView = contentView;
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 *Scale_Width, (contentView.height - 20 *Scale_Height) / 2, 25 *Scale_Height, 20 *Scale_Height)];
    iconImageView.contentMode  = UIViewContentModeScaleAspectFit;
    iconImageView.image        = [UIImage imageNamed:@""];
    [contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(iconImageView.x + iconImageView.width + 5 *Scale_Width, (contentView.height - 20 *Scale_Height) / 2, 200 *Scale_Width, 20 *Scale_Height)
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:[UIFont fontWithName:@"STHeitiSC-Medium" size:16.f *Scale_Width]
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *typeLabel = [UILabel createLabelWithFrame:CGRectMake(titleLabel.x + titleLabel.width + 10 *Scale_Width, (contentView.height - 20 *Scale_Height) / 2, 200 *Scale_Width, 20 *Scale_Height)
                                              labelType:kLabelNormal
                                                   text:@"必填"
                                                   font:UIFont_12
                                              textColor:CarOadColor(210, 33, 33)
                                          textAlignment:NSTextAlignmentCenter
                                                    tag:100];
    [contentView addSubview:typeLabel];
    self.typeLabel = typeLabel;
    
    UIView *h_lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, contentView.height - 0.7f, contentView.width, 0.7f)];
    h_lineView.backgroundColor = LineColor;
    [contentView addSubview:h_lineView];
    self.lineView = h_lineView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 22 *Scale_Height, 14 *Scale_Height, 7 *Scale_Height, 14 *Scale_Height)];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:@"arrow_right_gray"];
    [contentView addSubview:imageView];
    self.arrowImageView = imageView;
    
    UIButton *button = [UIButton createButtonWithFrame:contentView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [contentView addSubview:button];
    self.button = button;
    
}

- (void)loadContent {
    
    NSDictionary *model = self.data;
    NSString *iconImageString = model[@"iconImageString"];
    NSString *title           = model[@"title"];
    NSString *isShowButton    = model[@"isShowButton"];
    NSString *isShowType      = model[@"isShowType"];
    
    if (iconImageString.length > 0) {
        
        self.iconImageView.image = [UIImage imageNamed:iconImageString];
        
    } else {
        
        self.iconImageView.image = [UIImage imageNamed:@"照片"];
        
    }
    
    if (title.length > 0) {
        
        self.titleLabel.text = title;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, (self.contentBackView.height - 20 *Scale_Height) / 2, self.titleLabel.width, 20 *Scale_Height);
    
    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(self.titleLabel.x + self.titleLabel.width + 10 *Scale_Width, (self.contentBackView.height - 16 *Scale_Height) / 2, self.typeLabel.width + 16 *Scale_Height, 16 *Scale_Height);
    self.typeLabel.backgroundColor = [UIColor clearColor];
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.layer.cornerRadius  = self.typeLabel.height / 2;
    self.typeLabel.layer.borderColor   = CarOadColor(210, 33, 33).CGColor;
    self.typeLabel.layer.borderWidth   = 0.7f;
    
    if ([isShowType integerValue] == 1) {
        
        self.typeLabel.hidden = NO;

    } else {
        
        self.typeLabel.hidden = YES;
        
    }
    
    if ([isShowButton integerValue] == 1) {
        
        self.arrowImageView.hidden = NO;
        self.button.hidden = NO;
        
    } else {
        
        self.arrowImageView.hidden = YES;
        self.button.hidden = YES;
        
    }
    
}

- (void)buttonEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customHeaderFooterView:event:)]) {
        
        [self.delegate customHeaderFooterView:self event:nil];
    }
    
}

@end
