//
//  CVSettingShieldingShopCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CVSettingShieldingShopCell.h"

@interface CVSettingShieldingShopCell()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView   *lineView;

@end

@implementation CVSettingShieldingShopCell

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
    
    self.button = [UIButton createButtonWithFrame:CGRectZero
                                       buttonType:kButtonNormal
                                            title:nil
                                            image:[UIImage imageNamed:@"search_delete"]
                                         higImage:nil
                                              tag:1000
                                           target:self
                                           action:@selector(buttonEvent:)];
    [self.contentView addSubview:self.button];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];
    
}

- (void) layoutSubviews {
    
    self.titleLabel.frame = CGRectMake(25 *Scale_Width, 0, self.contentView.width - 40 *Scale_Width - self.contentView.height, self.contentView.height);
    
    self.button.frame = CGRectMake(self.contentView.width - self.contentView.height, 0, self.contentView.height, self.contentView.height);
    
    self.lineView.frame = CGRectMake(self.titleLabel.x, self.contentView.height - 0.5f, self.contentView.width - self.titleLabel.x, 0.5f);
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    [self.delegate clickDeleteShieldingShopWithData:self.data];
    
}

- (void)loadContent {
    
    NSDictionary *model = self.data;
    
    NSString *shopName = model[@"shopName"];
    if (shopName.length > 0) {
        
        self.titleLabel.text = shopName;
        
    } else {
        
        self.titleLabel.text = @"";
    
    }
    
    self.button.tag = self.tag;
    
}

@end
