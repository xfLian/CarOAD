//
//  MessageListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/5.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "MessageListCell.h"

#import "MessageListData.h"

@interface MessageListCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UILabel     *numberLabel;
@property (nonatomic, strong) UIView      *v_lineView;

@end

@implementation MessageListCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.iconImageView                 = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode     = UIViewContentModeScaleAspectFit;
    self.iconImageView.backgroundColor = BackGrayColor;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_14
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentRight
                                                tag:100];
    [self.contentView addSubview:self.dateLabel];
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_14
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    [self.contentView addSubview:self.contentLabel];
    
    self.numberLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_12
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
    self.numberLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.numberLabel];
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.v_lineView];
    
}

- (void) layoutSubviews {
    
    self.iconImageView.frame = CGRectMake(15 *Scale_Width, 12 *Scale_Height, 50 *Scale_Height, 50 *Scale_Height);
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = self.iconImageView.width / 2;
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(self.contentView.width - self.dateLabel.width - 15 *Scale_Width, self.iconImageView.y, self.dateLabel.width, 20 *Scale_Height);
    
    self.titleLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Height, self.iconImageView.y, self.dateLabel.x - (self.iconImageView.x + self.iconImageView.width + 20 *Scale_Height), 20 *Scale_Height);
    
    self.numberLabel.frame = CGRectMake(self.contentView.width - 20 *Scale_Height - 15 *Scale_Width, self.dateLabel.y + self.dateLabel.height + 10 *Scale_Height, 18 *Scale_Height, 18 *Scale_Height);
    self.numberLabel.layer.masksToBounds = YES;
    self.numberLabel.layer.cornerRadius = self.numberLabel.width / 2;
    
    self.contentLabel.frame = CGRectMake(self.titleLabel.x, self.titleLabel.y + self.titleLabel.height + 10 *Scale_Height, self.numberLabel.x - (self.titleLabel.x + 20 *Scale_Height), 20 *Scale_Height);
    
    self.v_lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);
    
}

- (void)loadContent {
    
    MessageListData *model = self.dataAdapter.data;
    
    if ([model.noticeTypeId isEqualToString:@"XT"]) {
        
        self.iconImageView.image = [UIImage imageNamed:@""];
        
    } else if ([model.noticeTypeId isEqualToString:@"JS"]) {
        
        self.iconImageView.image = [UIImage imageNamed:@""];
        
    } else if ([model.noticeTypeId isEqualToString:@"SK"]) {
        
        self.iconImageView.image = [UIImage imageNamed:@""];
        
    } else if ([model.noticeTypeId isEqualToString:@"SB"]) {
        
        self.iconImageView.image = [UIImage imageNamed:@""];
        
    } else if ([model.noticeTypeId isEqualToString:@"QT"]) {
        
        self.iconImageView.image = [UIImage imageNamed:@""];
        
    }
    
    if (model.noticeType.length > 0) {
        
        self.titleLabel.text = model.noticeType;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (model.lastNoticeDate.length > 0) {
        
        self.dateLabel.text = model.lastNoticeDate;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    if (model.unreadCounnt.length > 0 && [model.unreadCounnt integerValue] != 0) {
        
        if ([model.unreadCounnt integerValue] <= 99) {
            
            self.numberLabel.text = model.unreadCounnt;
            
        } else {
            
            self.numberLabel.text = @"…";
            
        }
        
        self.numberLabel.hidden = NO;
        
    } else {
        
        self.numberLabel.hidden = YES;
        
    }
    
    self.contentLabel.text = @"暂无最新消息";
    
    if (model.isShowLineView == YES) {
        
        self.v_lineView.hidden = NO;
        
    } else {
        
        self.v_lineView.hidden = YES;
        
    }
    
}
@end
