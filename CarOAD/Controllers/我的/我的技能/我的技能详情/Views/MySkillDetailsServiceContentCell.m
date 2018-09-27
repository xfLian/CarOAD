//
//  MySkillDetailsServiceContentCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MySkillDetailsServiceContentCell.h"

#import "MYSkillDetailesData.h"

@interface MySkillDetailsServiceContentCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MySkillDetailsServiceContentCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
}

- (void)layoutSubviews {
    
    CGFloat totalStringHeight = [self.titleLabel.text heightWithStringFont:UIFont_15 fixedWidth:Width - 30 *Scale_Width];
    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, totalStringHeight);
    
}

- (void)changeState {

    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kMySkillDetailsServiceContentCellNoDataType) {
        
        [self normalState];
        
    } else {
        
        [self expendState];
        
    }
    
}

- (void)normalState {
    
    self.titleLabel.hidden = YES;
    
}

- (void)expendState {

    self.titleLabel.hidden = NO;
    
}

- (void)loadContent {
    
    MYSkillDetailesData *model = self.dataAdapter.data;
    
    if (model.skillInfo.length > 0) {
        
        self.titleLabel.text = model.skillInfo;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    [self changeState];
        
}

- (void)selectedEvent {
    
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    MYSkillDetailesData *model = data;
    
    if (model) {
        
        CGFloat totalStringHeight = [model.skillInfo heightWithStringFont:UIFont_15 fixedWidth:Width - 30 *Scale_Width];
        // Expend string height.
        model.normalStringHeight = 20 *Scale_Height + totalStringHeight;
        
        // One line height.
        model.noDataStringHeight = 0;
    }
    
    return 0.f;
}

@end
