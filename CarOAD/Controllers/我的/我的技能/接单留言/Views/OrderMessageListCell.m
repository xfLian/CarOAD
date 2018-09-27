//
//  OrderMessageListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OrderMessageListCell.h"

#import "OrderMessageListData.h"

@interface OrderMessageListCell()

@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *priceLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *shopLabel;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UIButton    *phoneButton;
@property (nonatomic, strong) UIButton    *typeButton;
@property (nonatomic, strong) UIButton    *sureButton;

@end

@implementation OrderMessageListCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    self.backView = backView;
    
    UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, 50 *Scale_Height, 50 *Scale_Height)];
    imageView.image           = [UIImage imageNamed:@"contact_off_gray"];
    imageView.contentMode     = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds   = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius  = imageView.width / 2;
    imageView.tag                 = 200;
    [backView addSubview:imageView];
    self.iconImageView = imageView;
    
    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(imageView.x + imageView.width + 10 *Scale_Width, imageView.y + 5 *Scale_Height, 100 *Scale_Height, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:TextBlackColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [backView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *priceLabel = [UILabel createLabelWithFrame:CGRectMake(imageView.x + imageView.width + 10 *Scale_Width, imageView.y + 5 *Scale_Height, 100 *Scale_Height, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:[UIColor redColor]
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [backView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 10 *Scale_Height, Screen_Width - (nameLabel.x + 25 *Scale_Height), 20 *Scale_Height)
                                                labelType:kLabelNormal
                                                     text:@""
                                                     font:UIFont_15
                                                textColor:TextGrayColor
                                            textAlignment:NSTextAlignmentLeft
                                                      tag:100];
    contentLabel.numberOfLines = 0;
    [backView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel *dateLabel = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, contentLabel.y + contentLabel.height + 10 *Scale_Height, 100 *Scale_Width, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_13
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [backView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    UILabel *shopLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentRight
                                                   tag:100];
    [backView addSubview:shopLabel];
    self.shopLabel = shopLabel;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = LineColor;
    [backView addSubview:lineView];
    self.lineView = lineView;
    
    {
        
        UIButton *button = [UIButton createWithLeftImageAndRightTextButtonWithFrame:CGRectZero
                                                                              title:@"电话"
                                                                              image:[UIImage imageNamed:@"call_phone_white"]
                                                                                tag:1000
                                                                             target:self
                                                                             action:@selector(buttonEvent:)];
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:15.f];
        [backView addSubview:button];
        self.phoneButton = button;
        self.phoneButton.backgroundColor = MainColor;
        
    }
    
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                                     title:@"不合适"
                                           backgroundImage:nil
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:13.f];
        [backView addSubview:button];
        self.typeButton = button;
        self.typeButton.layer.masksToBounds = YES;
        self.typeButton.layer.borderWidth   = 0.7f;
        self.typeButton.layer.borderColor   = TextGrayColor.CGColor;
        self.typeButton.layer.cornerRadius  = 3.f *Scale_Width;
        
    }
    
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                                     title:@"成   交"
                                           backgroundImage:nil
                                                       tag:1002
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:13.f];
        [backView addSubview:button];
        self.sureButton = button;
        self.sureButton.layer.masksToBounds = YES;
        self.sureButton.layer.borderWidth   = 0.7f;
        self.sureButton.layer.borderColor   = TextGrayColor.CGColor;
        self.sureButton.layer.cornerRadius  = 3.f *Scale_Width;
        
    }
    
    self.iconImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.contentLabel.hidden = YES;
    self.priceLabel.hidden = YES;
    self.dateLabel.hidden = YES;
    self.shopLabel.hidden = YES;
    self.phoneButton.hidden = YES;
    self.typeButton.hidden = YES;
    self.sureButton.hidden = YES;
}

- (void) buttonEvent:(UIButton *)sender {
    
    [self.delegate clickCellButtonWithType:sender.tag - 1000 data:self.data];
    
}

- (void)layoutSubviews {
    
    self.backView.frame = CGRectMake(0, 10 *Scale_Height, Screen_Width, self.contentView.height - 10 *Scale_Height);
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(Screen_Width - 15 *Scale_Width - self.priceLabel.width, self.nameLabel.y, self.priceLabel.width, 20 *Scale_Height);
    
    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y + 5 *Scale_Height, self.priceLabel.x - (self.iconImageView.x + self.iconImageView.width + 20 *Scale_Width), 20 *Scale_Height);
    
    CGFloat totalStringHeight = [self.contentLabel.text heightWithStringFont:UIFont_15 fixedWidth:Screen_Width - 15 *Scale_Width - self.nameLabel.x];
    self.contentLabel.frame = CGRectMake(self.nameLabel.x, self.nameLabel.y + self.nameLabel.height + 10 *Scale_Height, Screen_Width - (self.nameLabel.x + 15 *Scale_Height), totalStringHeight);
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(15 *Scale_Width, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    self.shopLabel.frame = CGRectMake(self.dateLabel.x + self.dateLabel.width + 10 *Scale_Width, self.dateLabel.y, Screen_Width - (self.dateLabel.x + self.dateLabel.width + 25 *Scale_Width), 20 *Scale_Height);
    
    self.lineView.frame = CGRectMake(15 *Scale_Width, self.backView.height - 0.5f - 40 *Scale_Height, Screen_Width - 15 *Scale_Width, 0.5f);
    
    self.phoneButton.frame = CGRectMake(0, self.lineView.y + self.lineView.height, Screen_Width / 2, 40 *Scale_Height);
    
    self.typeButton.frame = CGRectMake(Screen_Width / 2 + 10 *Scale_Width, self.lineView.y + self.lineView.height + 7 *Scale_Height, (Screen_Width / 2 - 30 *Scale_Width) / 2, 26 *Scale_Height);
    
    self.sureButton.frame = CGRectMake(self.typeButton.x + self.typeButton.width + 10 *Scale_Width, self.typeButton.y, self.typeButton.width, self.typeButton.height);
    
}

- (void)changeState {
    
    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kOrderMessageListCellNoDataType) {
        
        [self normalState];
        
    } else {
        
        [self expendState];
        
    }
    
}

- (void)normalState {
    
    self.iconImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.contentLabel.hidden = YES;
    self.priceLabel.hidden = YES;
    self.dateLabel.hidden = YES;
    self.shopLabel.hidden = YES;
    self.phoneButton.hidden = YES;
    self.typeButton.hidden = YES;
    self.sureButton.hidden = YES;
    
}

- (void)expendState {
    
    self.iconImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.contentLabel.hidden = NO;
    self.priceLabel.hidden = NO;
    self.dateLabel.hidden = NO;
    self.shopLabel.hidden = NO;
    self.phoneButton.hidden = NO;
    self.typeButton.hidden = NO;
    self.sureButton.hidden = NO;
    
}

- (void)loadContent {
    
    OrderMessageListData *model = self.dataAdapter.data;
    
    if (model.shopImg.length > 0) {
        
        [QTDownloadWebImage downloadImageForImageView:self.iconImageView
                                             imageUrl:[NSURL URLWithString:model.shopImg]
                                     placeholderImage:@"contact_off_gray"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } else {
        
        self.iconImageView.image = [UIImage imageNamed:@"contact_off_gray"];
        
    }
    
    if (model.createName.length > 0) {
        
        self.nameLabel.text = model.createName;
        
    } else {
        
        self.nameLabel.text = @"";
        
    }
    
    if (model.price.length > 0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"出价:%@",model.price];
        
    } else {
        
        self.priceLabel.text = @"出价:";
        
    }
    
    if (model.shopMsg.length > 0) {
        
        self.contentLabel.text = model.shopMsg;
        
    } else {
        
        self.contentLabel.text = @"";
        
    }
    
    if (model.createDate.length > 0) {
        
        self.dateLabel.text = model.createDate;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    if (model.shopName.length > 0) {
        
        self.shopLabel.text = model.shopName;
        
    } else {
        
        self.shopLabel.text = @"";
        
    }
    
    if ([model.skillOrderState integerValue] == 2) {
        
        self.typeButton.layer.borderColor = MainColor.CGColor;
        [self.typeButton setTitleColor:MainColor forState:UIControlStateNormal];
        self.typeButton.enabled = NO;
        
        self.sureButton.layer.borderColor = TextGrayColor.CGColor;
        [self.sureButton setTitleColor:TextGrayColor forState:UIControlStateNormal];
        self.sureButton.enabled = NO;
        
    } else if ([model.skillOrderState integerValue] == 3) {
        
        self.typeButton.layer.borderColor = TextGrayColor.CGColor;
        [self.typeButton setTitleColor:TextGrayColor forState:UIControlStateNormal];
        self.typeButton.enabled = NO;
        
        self.sureButton.layer.borderColor = MainColor.CGColor;
        [self.sureButton setTitleColor:MainColor forState:UIControlStateNormal];
        self.sureButton.enabled = NO;
        
    } else {
        
        self.typeButton.layer.borderColor = TextGrayColor.CGColor;
        [self.typeButton setTitleColor:TextGrayColor forState:UIControlStateNormal];
        self.typeButton.enabled = YES;
        
        self.sureButton.layer.borderColor = TextGrayColor.CGColor;
        [self.sureButton setTitleColor:TextGrayColor forState:UIControlStateNormal];
        self.sureButton.enabled = YES;
        
    }
    
    [self changeState];
    
}

- (void)selectedEvent {
    
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    OrderMessageListData *model = data;
    
    if (model) {
        
        CGFloat totalStringHeight = [model.shopMsg heightWithStringFont:UIFont_15 fixedWidth:Screen_Width - 90 *Scale_Height];
        // Expend string height.
        model.normalStringHeight = 140 *Scale_Height + totalStringHeight;
        
        // One line height.
        model.noDataStringHeight = 0;
    }
    
    return 0.f;
}

@end
