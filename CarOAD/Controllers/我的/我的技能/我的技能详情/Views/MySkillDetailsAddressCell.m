//
//  MySkillDetailsAddressCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MySkillDetailsAddressCell.h"

#import "MYSkillDetailesData.h"

@interface MySkillDetailsAddressCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *addressLabel;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UILabel     *numberLabel;

@end

@implementation MySkillDetailsAddressCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.iconImageView.image       = [UIImage imageNamed:@"contact_off_gray"];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconImageView];
    
    self.addressLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_14
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    self.addressLabel.numberOfLines = 0;
    [self.contentView addSubview:self.addressLabel];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];
    
    self.numberLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_13
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    [self.contentView addSubview:self.numberLabel];
    
    self.iconImageView.hidden = YES;
    self.addressLabel.hidden = YES;
    self.lineView.hidden = YES;
    self.numberLabel.hidden = YES;
    
}

- (void)layoutSubviews {
    
    self.iconImageView.frame = CGRectMake(15 *Scale_Width, 0, 20 *Scale_Width, self.contentView.height);
    
    [self.numberLabel sizeToFit];
    self.numberLabel.frame = CGRectMake(Screen_Width - 15 *Scale_Width - self.numberLabel.width, 0, self.numberLabel.width, self.contentView.height);
    
    self.lineView.frame = CGRectMake(self.numberLabel.x - 10 *Scale_Width, 10 *Scale_Height, 1.f, self.contentView.height - 20 *Scale_Height);
    
    CGFloat totalStringHeight = [self.addressLabel.text heightWithStringFont:UIFont_14 fixedWidth:self.lineView.x - 50 *Scale_Width];
    if (totalStringHeight < 20 *Scale_Height) {
        
        self.addressLabel.frame = CGRectMake(40 *Scale_Width, 10 *Scale_Height, self.lineView.x - 50 *Scale_Width, 20 *Scale_Height);
        
    } else {
        
        self.addressLabel.frame = CGRectMake(40 *Scale_Width, 10 *Scale_Height, self.lineView.x - 50 *Scale_Width, totalStringHeight);
        
    }
    
    
}

- (void)changeState {
    
    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kMySkillDetailsAddressCellNoDataType) {
        
        [self normalState];
        
    } else {
        
        [self expendState];
        
    }
    
}

- (void)normalState {
    
    self.iconImageView.hidden = YES;
    self.addressLabel.hidden = YES;
    self.lineView.hidden = YES;
    self.numberLabel.hidden = YES;
    
}

- (void)expendState {
    
    self.iconImageView.hidden = NO;
    self.addressLabel.hidden = NO;
    self.lineView.hidden = NO;
    self.numberLabel.hidden = NO;
    
}

- (void)loadContent {
    
    MYSkillDetailesData *model = self.dataAdapter.data;
    
    if (model.address.length > 0) {
        
        self.addressLabel.text = model.address;
        
        self.numberLabel.text = [model getDistance];
        
        [self changeState];
        
    } else {
        
        self.addressLabel.text = @"";
        
    }

}

- (void)selectedEvent {
    
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    MYSkillDetailesData *model = data;
    
    if (model) {
        
        CGFloat numberStringWidth = [[model getDistance] widthWithStringFont:UIFont_15];
        CGFloat totalStringHeight = [model.address heightWithStringFont:UIFont_15 fixedWidth:Screen_Width - 75 *Scale_Width - numberStringWidth];
        
        // Expend string height.
        model.normalStringHeight = 20 *Scale_Height + totalStringHeight;
        
        // One line height.
        model.noDataStringHeight = 0;
        
    }
    
    return 0.f;
}

@end
