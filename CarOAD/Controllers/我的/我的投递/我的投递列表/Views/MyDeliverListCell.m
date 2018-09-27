//
//  MyDeliverListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyDeliverListCell.h"

#import "MyDeliverListData.h"

@interface MyDeliverListCell()

@property (nonatomic, strong) UIView       *backView;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIImageView *stateBackImageView;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView  *v_lineView;

@end

@implementation MyDeliverListCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.backView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 *Scale_Height)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.backView addSubview:self.titleLabel];
    
    self.stateBackImageView             = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.stateBackImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.stateBackImageView.image       = [UIImage imageNamed:@"state_back_gray"];
    [self.backView addSubview:self.stateBackImageView];
    
    self.stateLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_13
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.backView addSubview:self.stateLabel];
    
    self.addressLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.backView addSubview:self.addressLabel];
    
    self.shopNameLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.backView addSubview:self.shopNameLabel];
    
    self.priceLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_14
                                          textColor:[UIColor redColor]
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.backView addSubview:self.priceLabel];
    
    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_14
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.backView addSubview:self.dateLabel];
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = LineColor;
    [self.backView addSubview:self.v_lineView];
    
}

- (void)layoutSubviews {
    
    self.stateBackImageView.frame = CGRectMake(Screen_Width - 85 *Scale_Width, 10 *Scale_Height, 70 *Scale_Width, 20 *Scale_Height);
    
    self.stateLabel.frame = CGRectMake(self.stateBackImageView.x + 5 *Scale_Width, 10 *Scale_Height, 60 *Scale_Width, 20 *Scale_Height);
    
    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 130 *Scale_Width, 20 *Scale_Height);
    
    [self.addressLabel sizeToFit];
    self.addressLabel.frame = CGRectMake(15 *Scale_Width, self.titleLabel.y + self.titleLabel.height + 10 *Scale_Height, self.addressLabel.width, 20 *Scale_Height);
    
    self.v_lineView.frame = CGRectMake(self.addressLabel.x + self.addressLabel.width + 5 *Scale_Width, self.addressLabel.y + 3 *Scale_Height, 1.f, 14 *Scale_Height);
    
    [self.shopNameLabel sizeToFit];
    self.shopNameLabel.frame = CGRectMake(self.v_lineView.x + self.v_lineView.width + 5 *Scale_Width, self.addressLabel.y, self.shopNameLabel.width, 20 *Scale_Height);
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(15 *Scale_Width, self.addressLabel.y + self.addressLabel.height + 10 *Scale_Height, self.priceLabel.width, 20 *Scale_Height);
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(Screen_Width - 15 *Scale_Width - self.dateLabel.width, self.priceLabel.y, self.dateLabel.width, 20 *Scale_Height);
    
}

- (void)loadContent {
    
    MyDeliverListData *model = self.dataAdapter.data;

    if (model.skillPost.length > 0) {
        
        self.titleLabel.text = model.skillPost;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (model.status.length > 0) {
        
        if ([model.status isEqualToString:@"N"]) {
            
            self.stateLabel.text = @"投递成功";
            self.stateBackImageView.image = [UIImage imageNamed:@"state_back_red"];
            
        } else if ([model.status isEqualToString:@"Y"]) {
            
            self.stateLabel.text = @"已查看";
            self.stateBackImageView.image = [UIImage imageNamed:@"state_back_blue"];
            
        } else if ([model.status isEqualToString:@"D"]) {
            
            self.stateLabel.text = @"不合适";
            self.stateBackImageView.image = [UIImage imageNamed:@"state_back_gray"];
            
        }
        
    } else {
        
        self.stateLabel.text = @"";
        
    }
    
    if (model.cityArea.length > 0) {
        
        self.addressLabel.text = model.cityArea;
        
    } else {
        
        self.addressLabel.text = @"";
        
    }
    
    if (model.shopName.length > 0) {
        
        self.shopNameLabel.text = model.shopName;
        
    } else {
        
        self.shopNameLabel.text = @"";
        
    }
    
    if (model.salaryRange.length > 0) {
        
        self.priceLabel.text = model.salaryRange;
        
    } else {
        
        self.priceLabel.text = @"";
        
    }
    
    if (model.sendDate.length > 0) {
        
        self.dateLabel.text = [NSString stringWithFormat:@"投递时间：%@",model.sendDate];
        
    } else {
        
        self.dateLabel.text = @"投递时间：";
        
    }
    
}

@end
