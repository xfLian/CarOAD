//
//  MessageDetailsCell.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/5.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "MessageDetailsCell.h"

#import "MessageDetailsData.h"

@interface MessageDetailsCell()

@property (nonatomic, strong) UIView      *normalBackView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIView      *v_lineView;
@property (nonatomic, strong) UIView      *buttonBackView;
@property (nonatomic, strong) UILabel     *buttonTitleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation MessageDetailsCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.normalBackView                 = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 0)];
    self.normalBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.normalBackView];
    self.normalBackView.layer.masksToBounds = YES;
    self.normalBackView.layer.cornerRadius  = 3 *Scale_Width;
    self.normalBackView.layer.borderColor   = CarOadColor(183, 183, 183).CGColor;
    self.normalBackView.layer.borderWidth   = 0.7f;
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(10 *Scale_Width, 10 *Scale_Height, self.normalBackView.width - 20 *Scale_Width, 20 *Scale_Height)
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_16
                                         textColor:TextBlackColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:100];
    [self.normalBackView addSubview:self.titleLabel];
    
    self.dateLabel = [UILabel createLabelWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.y + self.titleLabel.height + 10 *Scale_Height, self.titleLabel.width, 20 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_13
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.normalBackView addSubview:self.dateLabel];
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectMake(self.titleLabel.x, self.dateLabel.y + self.dateLabel.height + 10 *Scale_Height, self.titleLabel.width, 20 *Scale_Height)
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_15
                                         textColor:TextBlackColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.normalBackView addSubview:self.contentLabel];
    
    self.buttonBackView                 = [[UIView alloc] initWithFrame:CGRectMake(self.titleLabel.x, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, self.titleLabel.width, 40 *Scale_Height)];
    self.buttonBackView.backgroundColor = [UIColor clearColor];
    [self.normalBackView addSubview:self.buttonBackView];
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.buttonBackView.width, 1.f)];
    self.v_lineView.backgroundColor = LineColor;
    [self.buttonBackView addSubview:self.v_lineView];
    
    self.buttonTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@"查看详情"
                                              font:UIFont_15
                                         textColor:MainColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:100];
    [self.buttonBackView addSubview:self.buttonTitleLabel];
    [self.buttonTitleLabel sizeToFit];
    self.buttonTitleLabel.frame = CGRectMake(0, 0, self.buttonTitleLabel.width, self.buttonBackView.height);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.buttonBackView.width - 8 *Scale_Height, (self.buttonBackView.height - 14 *Scale_Height) / 2, 8 *Scale_Height, 16 *Scale_Height)];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:@"arrow_right_gray"];
    [self.buttonBackView addSubview:imageView];
    self.arrowImageView = imageView;
    
    UIButton *button = [UIButton createButtonWithFrame:self.buttonBackView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [self.buttonBackView addSubview:button];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    MessageDetailsData *model = self.dataAdapter.data;
    [_cellSubDelegate clickChankDetailsWithData:model];
    
}


- (void)layoutSubviews {
    
    CGFloat totalStringHeight = [self.contentLabel.text heightWithStringFont:UIFont_15 fixedWidth:self.titleLabel.width];
    self.contentLabel.frame = CGRectMake(self.titleLabel.x, self.dateLabel.y + self.dateLabel.height + 10 *Scale_Height, self.titleLabel.width, totalStringHeight);
    self.buttonBackView.frame = CGRectMake(self.titleLabel.x, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, self.titleLabel.width, 40 *Scale_Height);
    self.normalBackView.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, self.buttonBackView.y + self.buttonBackView.height);
    
}

- (void)loadContent {
    
    MessageDetailsData *model = self.dataAdapter.data;
    
    if (model.noticeType.length > 0) {
        
        self.titleLabel.text = model.noticeType;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (model.lastNoticeDate.length > 0) {
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd hh:mm"];
        NSDate *date = [formatter dateFromString:model.lastNoticeDate];
        [formatter setDateFormat:@"MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        self.dateLabel.text = dateString;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    if (model.noticeInfo.length > 0) {
        
        self.contentLabel.text = model.noticeInfo;
        
    } else {
        
        self.contentLabel.text = @"";
        
    }
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    MessageDetailsData *model = data;
    
    if (model) {
        
        CGFloat totalStringHeight = [model.noticeInfo heightWithStringFont:UIFont_15 fixedWidth:Width - 50 *Scale_Width];
        
        // Expend string height.
        model.normalStringHeight = 140 *Scale_Height + totalStringHeight;

    }
    
    return 0.f;
}

@end
