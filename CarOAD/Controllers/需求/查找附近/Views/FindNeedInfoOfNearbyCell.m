//
//  FindNeedInfoOfNearbyCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/26.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "FindNeedInfoOfNearbyCell.h"

#import "FindNeedInfoOfNearbyData.h"

#define Image_More_Height 65 *Scale_Height

@interface FindNeedInfoOfNearbyCell()

@property (nonatomic, strong) UIImageView *smallImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *carLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *rushLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *countdownLabel;

@property (nonatomic, strong) UIImageView *distanceImageView;
@property (nonatomic, strong) UIImageView *countdownImageView;

@property (nonatomic, strong) UIView *v_lineView;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation FindNeedInfoOfNearbyCell

- (void)setupCell {
    
    [self registerNSNotificationCenter];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
}

- (void) buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 1.f)];
    lineView.backgroundColor = MainColor;
    [self.contentView addSubview:lineView];
    
    self.smallImageView               = [[UIImageView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Image_More_Height, Image_More_Height)];
    self.smallImageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.smallImageView.clipsToBounds = YES;
    self.smallImageView.image         = [UIImage imageNamed:@"logo_back_image_small"];
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
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(self.smallImageView.x + self.smallImageView.width + 10 *Scale_Width, self.smallImageView.y, self.rushLabel.x - (self.smallImageView.x + self.smallImageView.width + 25 *Scale_Width), 40 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    self.titleLabel.numberOfLines = 2;
    [self.contentView addSubview:self.titleLabel];
    
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
    
    self.priceLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"¥ 0"
                                               font:UIFont_14
                                          textColor:[UIColor redColor]
                                      textAlignment:NSTextAlignmentRight
                                                tag:103];
    [self.contentView addSubview:self.priceLabel];
    
    self.distanceImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.distanceImageView.contentMode   = UIViewContentModeScaleAspectFit;
    self.distanceImageView.image         = [UIImage imageNamed:@"distance_icon_lxf"];
    [self.contentView addSubview:self.distanceImageView];
    
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
    
    
    self.distanceLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"0.00km"
                                                  font:UIFont_13
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:101];
    [self.contentView addSubview:self.distanceLabel];
    
    self.countdownLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:UIFont_12
                                              textColor:TextGrayColor
                                          textAlignment:NSTextAlignmentCenter
                                                    tag:101];
    [self.contentView addSubview:self.countdownLabel];
    
    
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = MainColor;
    [self.contentView addSubview:self.v_lineView];
    
    self.numberLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_13
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentCenter
                                                tag:103];
    self.numberLabel.backgroundColor = MainColor;
    [self.contentView addSubview:self.numberLabel];
    
}

- (void) layoutSubviews {
    
    CGFloat totalStringHeight = [self.titleLabel.text heightWithStringFont:UIFont_16 fixedWidth:self.titleLabel.width];

    if (totalStringHeight > 22 *Scale_Height) {
        
        self.titleLabel.frame = CGRectMake(self.smallImageView.x + self.smallImageView.width + 10 *Scale_Width, self.smallImageView.y, self.rushLabel.x - (self.smallImageView.x + self.smallImageView.width + 25 *Scale_Width), 40 *Scale_Height);
        
    } else {
        
        self.titleLabel.frame = CGRectMake(self.smallImageView.x + self.smallImageView.width + 10 *Scale_Width, self.smallImageView.y, self.rushLabel.x - (self.smallImageView.x + self.smallImageView.width + 25 *Scale_Width), 20 *Scale_Height);
        
    }
    
    [self.carLabel sizeToFit];
    self.carLabel.frame = CGRectMake(self.titleLabel.x, self.titleLabel.y + 48 *Scale_Height, self.carLabel.width + 10 *Scale_Width, 18 *Scale_Height);
    self.carLabel.layer.masksToBounds = YES;
    self.carLabel.layer.borderWidth   = 0.7f;
    self.carLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.carLabel.layer.cornerRadius  = 3.f *Scale_Width;
    
    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(self.carLabel.x + self.carLabel.width + 5 *Scale_Width, self.carLabel.y, self.typeLabel.width + 10 *Scale_Width, 18 *Scale_Height);
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.layer.borderWidth   = 0.7f;
    self.typeLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.typeLabel.layer.cornerRadius  = 3.f *Scale_Width;
    
    self.priceLabel.frame = CGRectMake(self.typeLabel.x + self.typeLabel.width + 10 *Scale_Width, self.titleLabel.y + 45 *Scale_Height, Screen_Width - (self.typeLabel.x + self.typeLabel.width + 25 *Scale_Width), 20 *Scale_Height);
    
    self.countdownImageView.frame = CGRectMake(self.smallImageView.x, self.smallImageView.y + self.smallImageView.height + 11 *Scale_Height, 18 *Scale_Height, 18 *Scale_Height);
    [self.countdownLabel sizeToFit];
    self.countdownLabel.frame = CGRectMake(self.countdownImageView.x + self.countdownImageView.width + 5 *Scale_Width, self.smallImageView.y + self.smallImageView.height + 10 *Scale_Height, self.countdownLabel.width, 20 *Scale_Height);
    
    [self.distanceLabel sizeToFit];
    self.distanceLabel.frame = CGRectMake(self.contentView.width - 15 *Scale_Width - self.distanceLabel.width, self.countdownImageView.y, self.distanceLabel.width, 20 *Scale_Height);
    
    [self.addressLabel sizeToFit];
    self.addressLabel.frame = CGRectMake(self.distanceLabel.x - 10 *Scale_Width - self.addressLabel.width, self.countdownImageView.y, self.addressLabel.width, 20 *Scale_Height);
    self.distanceImageView.frame = CGRectMake(self.addressLabel.x - 25 *Scale_Height, self.distanceLabel.y + 1 *Scale_Height, 18 *Scale_Height, 18 *Scale_Height);
    
    self.v_lineView.frame = CGRectMake(0, self.addressLabel.y + self.addressLabel.height + 10 *Scale_Height, self.contentView.width, 1.f);
    
    self.numberLabel.frame = CGRectMake((self.contentView.width - 20 *Scale_Height) / 2, self.v_lineView.y + self.v_lineView.height + 7 *Scale_Height, 20 *Scale_Height, 20 *Scale_Height);
    self.numberLabel.layer.masksToBounds = YES;
    self.numberLabel.layer.cornerRadius  = self.numberLabel.width / 2;
    
}

- (void) loadContent {
    
    FindNeedInfoOfNearbyData *model = self.dataAdapter.data;
    
    if (model.demandImg.length > 0) {
        
        NSArray *imageStringArray = [model.demandImg componentsSeparatedByString:@","];
        
        [QTDownloadWebImage downloadImageForImageView:self.smallImageView
                                             imageUrl:[NSURL URLWithString:imageStringArray[0]]
                                     placeholderImage:@"logo_back_image_small"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } else {
        
        self.smallImageView.image = [UIImage imageNamed:@"logo_back_image_small"];
        
    }
    
    if (model.demandTitle.length > 0) {
        
        self.titleLabel.text = model.demandTitle;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if ([model.URGLevel isEqualToString:@"Y"]) {
        
        self.rushLabel.hidden = NO;
        
    } else {
        
        self.rushLabel.hidden = YES;
        
    }
    
    if (model.price.length > 0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
        
    } else {
        
        self.priceLabel.text   = @"¥ 0";
        
    }
    
    if (model.cityArea.length > 0) {
        
        self.addressLabel.text = model.cityArea;
        
    } else {
        
        self.addressLabel.text = @"";
        
    }
    
    if (model.distance.length > 0) {
        
        self.distanceLabel.text = [NSString stringWithFormat:@"%@km",model.distance];
        
    } else {
        
        self.distanceLabel.text = @"0.00km";
        
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
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",model.cell_tag];
    
}

- (void) loadTimeContent; {
    
    FindNeedInfoOfNearbyData *model = self.dataAdapter.data;
    self.countdownLabel.text = [model currentTimeString];
    
}

- (void)dealloc {
    
    [self removeNSNotificationCenter];
}

#pragma mark - 通知中心
- (void)registerNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:NSNotificationCountDownTimeFindNeedInfoOfNearbyCell
                                               object:nil];
}

- (void)removeNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationCountDownTimeFindNeedInfoOfNearbyCell object:nil];
}

- (void)notificationCenterEvent:(id)sender {
    
    if (self.display) {
        
        [self loadTimeContent];
    }
}

@end
