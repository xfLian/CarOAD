//
//  PublishQuestionAndAnswerChooseCarTypeCell.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/7.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "PublishQuestionAndAnswerChooseCarTypeCell.h"

@interface PublishQuestionAndAnswerChooseCarTypeCell()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation PublishQuestionAndAnswerChooseCarTypeCell

- (void)setupCell {
    
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
}

- (void) buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"车辆品牌"
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 0, self.titleLabel.width, 50 *Scale_Height);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 22 *Scale_Height, (50 *Scale_Height - 14 *Scale_Height) / 2, 7 *Scale_Height, 14 *Scale_Height)];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:@"arrow_right_gray"];
    [self.contentView addSubview:imageView];
    self.arrowImageView = imageView;
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectMake(self.titleLabel.x + self.titleLabel.width + 10 *Scale_Width, 0, imageView.x - (self.titleLabel.x + self.titleLabel.width + 20 *Scale_Width), 50 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@"请选择车辆品牌"
                                               font:UIFont_15
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentRight
                                                tag:103];
    [self.contentView addSubview:self.contentLabel];
    
}

- (void) loadContent {
    
    NSDictionary *data    = self.data;
    NSString     *content = data[@"carInfo"];
    
    if (content.length > 0) {
        
        self.contentLabel.text = content;
        
    } else {
        
        self.contentLabel.text = @"请选择车辆品牌";
        
    }
    
}

@end
