//
//  MyOrderListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyOrderListCell.h"

#import "MyOrderListData.h"

#define Image_More_Height 65 *Scale_Height

@interface MyOrderListCell()

@property (nonatomic, strong) UIImageView *smallImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *rushLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *countdownLabel;

@property (nonatomic, strong) UILabel *carLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UIImageView *countdownImageView;

@property (nonatomic, strong) UIView *v_lineView;

@end

@implementation MyOrderListCell

- (void)setupCell {
    
    [self registerNSNotificationCenter];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
}

- (void) buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.smallImageView               = [[UIImageView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Image_More_Height, Image_More_Height)];
    self.smallImageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.smallImageView.clipsToBounds = YES;
    self.smallImageView.image         = [UIImage imageNamed:carPlaceholderImageString];
    [self.contentView addSubview:self.smallImageView];
    
    self.rushLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@"紧急"
                                              font:UIFont_12
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter
                                               tag:101];
    self.rushLabel.backgroundColor = CarOadColor(210, 33, 33);
    [self.contentView addSubview:self.rushLabel];
    [self.rushLabel sizeToFit];
    self.rushLabel.frame = CGRectMake(Screen_Width - 29 *Scale_Width - self.rushLabel.width, self.smallImageView.y, self.rushLabel.width + 14 *Scale_Width, 18 *Scale_Height);
    self.rushLabel.layer.masksToBounds = YES;
    self.rushLabel.layer.cornerRadius  = 2.f *Scale_Width;
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(self.smallImageView.x + self.smallImageView.width + 10 *Scale_Width, self.smallImageView.y, self.rushLabel.x - (self.smallImageView.x + self.smallImageView.width + 25 *Scale_Width), 20 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];
    
    self.priceLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"¥0"
                                               font:UIFont_14
                                          textColor:[UIColor redColor]
                                      textAlignment:NSTextAlignmentRight
                                                tag:103];
    [self.contentView addSubview:self.priceLabel];

    self.countdownImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.countdownImageView.contentMode   = UIViewContentModeScaleAspectFit;
    self.countdownImageView.image         = [UIImage imageNamed:@"countdown_icon_lxf"];
    [self.contentView addSubview:self.countdownImageView];
    
    self.addressLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_13
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentCenter
                                                  tag:101];
    [self.contentView addSubview:self.addressLabel];
    
    
    self.stateLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_12
                                             textColor:MainColor
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:101];
    [self.contentView addSubview:self.stateLabel];
    
    self.countdownLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:UIFont_12
                                              textColor:TextGrayColor
                                          textAlignment:NSTextAlignmentCenter
                                                    tag:101];
    [self.contentView addSubview:self.countdownLabel];
    
    self.carLabel = [UILabel createLabelWithFrame:CGRectZero
                                        labelType:kLabelNormal
                                             text:@""
                                             font:UIFont_12
                                        textColor:TextGrayColor
                                    textAlignment:NSTextAlignmentCenter
                                              tag:101];
    [self.contentView addSubview:self.carLabel];
    
    self.typeLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_12
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentCenter
                                               tag:102];
    [self.contentView addSubview:self.typeLabel];
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.v_lineView];
    
}

- (void) layoutSubviews {
    
    [self.addressLabel sizeToFit];
    self.addressLabel.frame = CGRectMake(self.titleLabel.x, self.smallImageView.y + self.smallImageView.height - 20 *Scale_Height, self.addressLabel.width, 20 *Scale_Height);
    
    [self.stateLabel sizeToFit];
    self.stateLabel.frame = CGRectMake(self.contentView.width - 31 *Scale_Width - self.stateLabel.width, self.addressLabel.y, self.stateLabel.width + 16 *Scale_Width, 20 *Scale_Height);
    self.stateLabel.layer.borderColor = MainColor.CGColor;
    self.stateLabel.layer.borderWidth = 0.7f *Scale_Width;
    self.stateLabel.layer.masksToBounds = YES;
    self.stateLabel.layer.cornerRadius  = self.stateLabel.height / 2;
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(self.titleLabel.x, self.smallImageView.y + self.smallImageView.height - 40 *Scale_Height, self.priceLabel.width, 20 *Scale_Height);
    
    self.countdownImageView.frame = CGRectMake(self.smallImageView.x, self.smallImageView.y + self.smallImageView.height + 10 *Scale_Height, 20 *Scale_Height, 20 *Scale_Height);
    [self.countdownLabel sizeToFit];
    self.countdownLabel.frame = CGRectMake(self.countdownImageView.x + self.countdownImageView.width + 5 *Scale_Width, self.countdownImageView.y, self.countdownLabel.width, 20 *Scale_Height);
    
    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(self.contentView.width - 25 *Scale_Width - self.typeLabel.width, self.countdownLabel.y, self.typeLabel.width + 10 *Scale_Width, 18 *Scale_Height);
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.layer.borderWidth   = 0.7f;
    self.typeLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.typeLabel.layer.cornerRadius  = 3.f *Scale_Width;
    
    [self.carLabel sizeToFit];
    
    if (self.typeLabel.text.length > 0) {
        
        self.carLabel.frame = CGRectMake(self.typeLabel.x - 15 *Scale_Width - self.carLabel.width, self.countdownLabel.y, self.carLabel.width + 10 *Scale_Width, 18 *Scale_Height);
        
    } else {
        
        self.carLabel.frame = CGRectMake(self.contentView.width - 25 *Scale_Width - self.carLabel.width, self.countdownLabel.y, self.carLabel.width + 10 *Scale_Width, 18 *Scale_Height);
        
    }
    
    self.carLabel.layer.masksToBounds = YES;
    self.carLabel.layer.borderWidth   = 0.7f;
    self.carLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.carLabel.layer.cornerRadius  = 3.f *Scale_Width;
    
    self.v_lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);
    
}

- (void) loadTimeContent; {
    
    MyOrderListData *model   = self.dataAdapter.data;
    self.countdownLabel.text = [model currentTimeString];
    
}

- (void) loadContent {
    
    MyOrderListData *model = self.dataAdapter.data;
    
    if (model.demandImg.length > 0) {
        
        [QTDownloadWebImage downloadImageForImageView:self.smallImageView
                                             imageUrl:[NSURL URLWithString:model.demandImg]
                                     placeholderImage:carPlaceholderImageString
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } else {
        
        self.smallImageView.image = [UIImage imageNamed:carPlaceholderImageString];
        
    }
    
    if (model.demandTitle.length > 0) {
        
        self.titleLabel.text = model.demandTitle;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (model.URGLevel.length > 0) {
        
        self.rushLabel.hidden = NO;
        
    } else {
        
        self.rushLabel.hidden = YES;
        
    }
    
    if (model.price.length > 0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
        
    } else {
        
        self.priceLabel.text   = @"¥0";
        
    }
    
    if (model.cityArea.length > 0) {
        
        self.addressLabel.text = model.cityArea;
        
    } else {
        
        self.addressLabel.text = @"";
        
    }
    
    self.stateLabel.hidden = NO;
    if (model.demandOrderState.length > 0 && [model.demandOrderState isEqualToString:@"1"]) {

        self.stateLabel.text = @"接单中";
        
    } else if (model.demandOrderState.length > 0 && [model.demandOrderState isEqualToString:@"2"]) {
        
        self.stateLabel.text = @"不合适";
        
    } else if (model.demandOrderState.length > 0 && [model.demandOrderState isEqualToString:@"3"]) {
        
        self.stateLabel.text = @"有意向";
        
    } else if (model.demandOrderState.length > 0 && [model.demandOrderState isEqualToString:@"4"]) {
        
        self.stateLabel.text = @"已成交";
        
    } else {
        
        self.stateLabel.hidden = YES;
        
    }
    
    if (model.carType.length > 0) {
        
        self.carLabel.text = model.carType;
        self.carLabel.hidden = NO;
        
    } else {
        
        self.carLabel.text   = @"";
        self.carLabel.hidden = YES;
        
    }
    
    if (model.demandType.length > 0) {
        
        self.typeLabel.text = model.demandType;
        self.typeLabel.hidden = NO;
        
    } else {
        
        self.typeLabel.text   = @"";
        self.typeLabel.hidden = YES;
        
    }
    
}

- (void)dealloc {
    
    [self removeNSNotificationCenter];
}

#pragma mark - 通知中心
- (void)registerNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:NSNotificationCountDownTimeCell
                                               object:nil];
}

- (void)removeNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationCountDownTimeCell object:nil];
}

- (void)notificationCenterEvent:(id)sender {
    
    if (self.display) {
        
        [self loadTimeContent];
    }
}

@end
