//
//  DeliverDetailsUserInfoCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "DeliverDetailsUserInfoCell.h"

#import "MyDeliverDetailsData.h"

@interface DeliverDetailsUserInfoCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *firstBackView;
@property (nonatomic, strong) UIView *secondBackView;
@property (nonatomic, strong) UIView *thirdBackView;
@property (nonatomic, strong) UIView *forthBackView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *shopNameLabel;
@property (nonatomic, strong) UILabel     *shopLinkmanLabel;
@property (nonatomic, strong) UIView      *h_lineView;
@property (nonatomic, strong) UILabel     *shopLinkRoleLabel;

@end

@implementation DeliverDetailsUserInfoCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_M_17
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    [self.contentView addSubview:self.titleLabel];
    
    self.priceLabel = [UILabel createLabelWithFrame:CGRectZero
                                           labelType:kLabelNormal
                                                text:@""
                                                font:UIFont_13
                                           textColor:[UIColor redColor]
                                       textAlignment:NSTextAlignmentLeft
                                                 tag:100];
    [self.contentView addSubview:self.priceLabel];
    
    self.firstBackView = [self createTagViewWithImage:@"location_address"];
    self.firstBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.firstBackView];
    
    self.secondBackView = [self createTagViewWithImage:@"job_limit"];
    self.secondBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.secondBackView];
    
    self.thirdBackView = [self createTagViewWithImage:@"educational_background"];
    self.thirdBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.thirdBackView];
    
    self.forthBackView = [self createTagViewWithImage:@"job_specification"];
    self.forthBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.forthBackView];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];
    
    self.iconImageView             = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.iconImageView.image       = [UIImage imageNamed:@"logo_back_image_small"];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.backgroundColor = BackGrayColor;
    [self.contentView addSubview:self.iconImageView];
    
    self.shopNameLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_14
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.shopNameLabel];
    
    self.shopLinkmanLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_13
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.shopLinkmanLabel];
    
    self.h_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.h_lineView];
    
    self.shopLinkRoleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_13
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.shopLinkRoleLabel];
    
    self.titleLabel.hidden = YES;
    self.priceLabel.hidden = YES;
    self.lineView.hidden = YES;
    self.firstBackView.hidden = YES;
    self.secondBackView.hidden = YES;
    self.thirdBackView.hidden = YES;
    self.forthBackView.hidden = YES;
    self.iconImageView.hidden = YES;
    self.shopNameLabel.hidden = YES;
    self.shopLinkmanLabel.hidden = YES;
    self.h_lineView.hidden = YES;
    self.shopLinkRoleLabel.hidden = YES;
    
}

- (UIView *) createTagViewWithImage:(NSString *)imageString {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:imageString];
    imageView.tag          = 100;
    imageView.backgroundColor = [UIColor clearColor];
    [backView addSubview:imageView];
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_12
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:101];
    label.backgroundColor = [UIColor clearColor];
    [backView addSubview:label];
    
    return backView;
    
}

- (void)layoutSubviews {
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(self.contentView.width - self.priceLabel.width - 15 *Scale_Width, 10 *Scale_Height, self.priceLabel.width, 20 *Scale_Height);
    
    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.priceLabel.x - 25 *Scale_Width, 20 *Scale_Height);

    self.firstBackView.frame = CGRectMake(15 *Scale_Width, self.titleLabel.y + self.titleLabel.height + 10 *Scale_Height, (self.contentView.width - 15 *Scale_Width) / 4, 25 *Scale_Height);
    
    for (UIView *subView in self.firstBackView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 100) {
            
            subView.frame = CGRectMake(0, (self.firstBackView.height - 16 *Scale_Height) / 2, 16 *Scale_Height, 16 *Scale_Height);
            
        }
        
        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {
            
            subView.frame = CGRectMake(20 *Scale_Height, 0, self.firstBackView.width - (20 *Scale_Height + 10 *Scale_Width), self.firstBackView.height);
            
        }
        
    }
    
    self.secondBackView.frame = CGRectMake(self.firstBackView.x + self.firstBackView.width, self.firstBackView.y, self.firstBackView.width, self.firstBackView.height);
    
    for (UIView *subView in self.secondBackView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 100) {
            
            subView.frame = CGRectMake(0, (self.firstBackView.height - 16 *Scale_Height) / 2, 16 *Scale_Height, 16 *Scale_Height);
            
        }
        
        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {
            
            subView.frame = CGRectMake(20 *Scale_Height, 0, self.secondBackView.width - (20 *Scale_Height + 10 *Scale_Width), self.secondBackView.height);
            
        }
        
    }
    
    self.thirdBackView.frame = CGRectMake(self.secondBackView.x + self.secondBackView.width, self.firstBackView.y, self.firstBackView.width, self.firstBackView.height);
    
    for (UIView *subView in self.thirdBackView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 100) {
            
            subView.frame = CGRectMake(0, (self.firstBackView.height - 16 *Scale_Height) / 2, 16 *Scale_Height, 16 *Scale_Height);
            
        }
        
        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {
            
            subView.frame = CGRectMake(20 *Scale_Height, 0, self.thirdBackView.width - (20 *Scale_Height + 10 *Scale_Width), self.thirdBackView.height);
            
        }
        
    }
    
    self.forthBackView.frame = CGRectMake(self.thirdBackView.x + self.thirdBackView.width, self.firstBackView.y, self.firstBackView.width, self.firstBackView.height);
    
    for (UIView *subView in self.forthBackView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag == 100) {
            
            subView.frame = CGRectMake(0, (self.firstBackView.height - 16 *Scale_Height) / 2, 16 *Scale_Height, 16 *Scale_Height);
            
        }
        
        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {
            
            subView.frame = CGRectMake(20 *Scale_Height, 0, self.forthBackView.width - (20 *Scale_Height + 10 *Scale_Width), self.forthBackView.height);
            
        }
        
    }
    
    self.lineView.frame = CGRectMake(0, self.firstBackView.y + self.firstBackView.height + 10 *Scale_Height, self.contentView.width, 0.5f);
    
    self.iconImageView.frame = CGRectMake(15 *Scale_Height, self.lineView.y + self.lineView.height + 10 *Scale_Height, 50 *Scale_Height, 50 *Scale_Height);
    
    self.shopNameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y, Screen_Width - (self.iconImageView.x + self.iconImageView.width + 25 *Scale_Width), 20 *Scale_Height);
    
    [self.shopLinkmanLabel sizeToFit];
    self.shopLinkmanLabel.frame = CGRectMake(self.shopNameLabel.x, self.iconImageView.y + self.iconImageView.height - 20 *Scale_Height, self.shopLinkmanLabel.width, 20 *Scale_Height);
    
    self.h_lineView.frame = CGRectMake(self.shopLinkmanLabel.x + self.shopLinkmanLabel.width + 5 *Scale_Width, self.shopLinkmanLabel.y + 3 *Scale_Height, 1.f, 14 *Scale_Height);
    
    self.shopLinkRoleLabel.frame = CGRectMake(self.h_lineView.x + self.h_lineView.width + 5 *Scale_Width, self.shopLinkmanLabel.y, Screen_Width - (self.h_lineView.x + self.h_lineView.width + 20 *Scale_Width), 20 *Scale_Height);
    
}

- (void)changeState {
    
    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kDeliverDetailsUserInfoCellNoDataType) {
        
        [self normalState];
        
    } else {
        
        [self expendState];
        
    }
    
}

- (void)normalState {

    self.titleLabel.hidden = YES;
    self.priceLabel.hidden = YES;
    self.lineView.hidden = YES;
    self.firstBackView.hidden = YES;
    self.secondBackView.hidden = YES;
    self.thirdBackView.hidden = YES;
    self.forthBackView.hidden = YES;
    self.iconImageView.hidden = YES;
    self.shopNameLabel.hidden = YES;
    self.shopLinkmanLabel.hidden = YES;
    self.h_lineView.hidden = YES;
    self.shopLinkRoleLabel.hidden = YES;
    
}

- (void)expendState {
    
    self.titleLabel.hidden = NO;
    self.priceLabel.hidden = NO;
    self.lineView.hidden = NO;
    self.firstBackView.hidden = NO;
    self.secondBackView.hidden = NO;
    self.thirdBackView.hidden = NO;
    self.forthBackView.hidden = NO;
    self.iconImageView.hidden = NO;
    self.shopNameLabel.hidden = NO;
    self.shopLinkmanLabel.hidden = NO;
    self.h_lineView.hidden = NO;
    self.shopLinkRoleLabel.hidden = NO;
    
}

- (void)loadContent {
    
    MyDeliverDetailsData *model = self.dataAdapter.data;
    
    if (model.skillPost.length > 0) {
        
        self.titleLabel.text = model.skillPost;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (model.salaryRange.length > 0) {
        
        self.priceLabel.text = model.salaryRange;
        
    } else {
        
        self.priceLabel.text = @"";
        
    }
    
    for (UIView *subView in self.firstBackView.subviews) {
        
        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {
            
            UILabel *label = (UILabel *)subView;
            
            if (model.cityArea.length > 0) {
                
                label.text = model.cityArea;
                
            } else {
                
                label.text = @"";
                
            }
            
        }
        
    }
    
    for (UIView *subView in self.secondBackView.subviews) {
        
        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {
            
            UILabel *label = (UILabel *)subView;
            
            if (model.expDuty.length > 0) {
                
                label.text = model.expDuty;
                
            } else {
                
                label.text = @"";
                
            }
            
        }
        
    }
    
    for (UIView *subView in self.thirdBackView.subviews) {
        
        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {
            
            UILabel *label = (UILabel *)subView;
            
            if (model.eduDuty.length > 0) {
                
                label.text = model.eduDuty;
                
            } else {
                
                label.text = @"";
                
            }
            
        }
        
    }
    
    for (UIView *subView in self.forthBackView.subviews) {
        
        if ([subView isKindOfClass:[UILabel class]] && subView.tag == 101) {
            
            UILabel *label = (UILabel *)subView;
            
            if (model.workNature.length > 0) {
                
                label.text = model.workNature;
                
            } else {
                
                label.text = @"";
                
            }
            
        }
        
    }
    
    if (model.shopImg.length > 0) {
        
        [QTDownloadWebImage downloadImageForImageView:self.iconImageView
                                             imageUrl:[NSURL URLWithString:model.shopImg]
                                     placeholderImage:@"logo_back_image_small"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } else {
        
        self.iconImageView.image = [UIImage imageNamed:@"logo_back_image_small"];
        
    }
    
    if (model.ShopName.length > 0) {
        
        self.shopNameLabel.text = model.ShopName;
        
    } else {
        
        self.shopNameLabel.text = @"";
        
    }
    
    if (model.shopLinkman.length > 0) {
        
        self.shopLinkmanLabel.text = model.shopLinkman;
        
    } else {
        
        self.shopLinkmanLabel.text = @"";
        
    }
    
    if (model.shopLinkRole.length > 0) {
        
        self.shopLinkRoleLabel.text = model.shopLinkRole;
        
    } else {
        
        self.shopLinkRoleLabel.text = @"";
        
    }
    
    [self changeState];
    
}

- (void)selectedEvent {
    
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    MyDeliverDetailsData *model = data;
    
    if (model) {

        // Expend string height.
        model.normalStringHeight = 145 *Scale_Height;
        
        // One line height.
        model.noDataStringHeight = 0;
        
    }
    
    return 0.f;
}

@end
