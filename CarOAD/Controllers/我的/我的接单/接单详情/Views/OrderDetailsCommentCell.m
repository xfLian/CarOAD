//
//  OrderDetailsCommentCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OrderDetailsCommentCell.h"

#import "MyOrderDetailsOrderMsgList.h"

@interface OrderDetailsCommentCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *priceLabel;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UIImageView *signImageView;

@end

@implementation OrderDetailsCommentCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, 50 *Scale_Height, 50 *Scale_Height)];
    imageView.image           = [UIImage imageNamed:@"contact_off_gray"];
    imageView.contentMode     = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds   = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius  = imageView.width / 2;
    imageView.tag                 = 200;
    [self.contentView addSubview:imageView];
    self.iconImageView = imageView;
    
    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(imageView.x + imageView.width + 10 *Scale_Width, imageView.y, Screen_Width - (imageView.x + imageView.width + 25 *Scale_Width), 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:TextBlackColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 10 *Scale_Height, Screen_Width - (nameLabel.x + 15 *Scale_Height), 20 *Scale_Height)
                                                labelType:kLabelNormal
                                                     text:@""
                                                     font:UIFont_15
                                                textColor:TextGrayColor
                                            textAlignment:NSTextAlignmentLeft
                                                      tag:100];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel *dateLabel = [UILabel createLabelWithFrame:CGRectMake(imageView.x, contentLabel.y + contentLabel.height + 10 *Scale_Height, 100 *Scale_Width, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_13
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    UILabel *priceLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:[UIColor redColor]
                                         textAlignment:NSTextAlignmentRight
                                                   tag:100];
    [self.contentView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UIImageView *signImageView    = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width - 15 *Scale_Width - 80 *Scale_Height, 10 *Scale_Height, 80 *Scale_Height, 80 *Scale_Height)];
    signImageView.contentMode     = UIViewContentModeScaleAspectFit;
    signImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:signImageView];
    self.signImageView = signImageView;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = LineColor;
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    self.iconImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.contentLabel.hidden = YES;
    self.dateLabel.hidden = YES;
    self.priceLabel.hidden = YES;
    self.signImageView.hidden = YES;
    
}

- (void)layoutSubviews {
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(self.iconImageView.x, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    self.priceLabel.frame = CGRectMake(self.dateLabel.x + self.dateLabel.width + 10 *Scale_Width, self.dateLabel.y, Screen_Width - (self.dateLabel.x + self.dateLabel.width + 25 *Scale_Width), 20 *Scale_Height);
    
    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, Screen_Width - 15 *Scale_Width, 0.5f);
    
}

- (void)changeState {
    
    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kOrderDetailsCommentCellNoDataType) {
        
        [self normalState];
        
    } else {
        
        [self expendState];
        
    }
    
}

- (void)normalState {
    
    self.iconImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.contentLabel.hidden = YES;
    self.dateLabel.hidden = YES;
    self.priceLabel.hidden = YES;
    
}

- (void)expendState {
    
    self.iconImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.contentLabel.hidden = NO;
    self.dateLabel.hidden = NO;
    self.priceLabel.hidden = NO;
    
}

- (void)loadContent {
    
    MyOrderDetailsOrderMsgList *model = self.dataAdapter.data;
    
    if (model.userImg.length > 0) {
        
        [QTDownloadWebImage downloadImageForImageView:self.iconImageView
                                             imageUrl:[NSURL URLWithString:model.userImg]
                                     placeholderImage:@"contact_off_gray"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } else {
        
        self.iconImageView.image = [UIImage imageNamed:@"contact_off_gray"];
        
    }
    
    if (model.userName.length > 0) {
        
        self.nameLabel.text = model.userName;
        
    } else {
        
        self.nameLabel.text = @"";
        
    }
    
    if (model.orderMsg.length > 0) {
        
        self.contentLabel.text = model.orderMsg;
        
    } else {
        
        self.contentLabel.text = @"";
        
    }
    
    if (model.date.length > 0) {
        
        self.dateLabel.text = model.date;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    if (model.quote.length > 0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"报价：¥ %@",model.quote];
        
    } else {
        
        self.priceLabel.text = @"报价：¥ 0";
        
    }
    
    //N-接单中 C-成交 T-不合适 Y-有意向
    if ([model.state isEqualToString:@"C"] || [model.state isEqualToString:@"T"] || [model.state isEqualToString:@"Y"]) {
        
        self.signImageView.hidden = NO;
        
        if ([model.state isEqualToString:@"C"]) {
            
            self.signImageView.image = [UIImage imageNamed:@"order_sign_clinch"];
            
        } else if ([model.state isEqualToString:@"T"]) {
            
            self.signImageView.image = [UIImage imageNamed:@"order_sign_unseemliness"];
            
        } else if ([model.state isEqualToString:@"Y"]) {
            
            self.signImageView.image = [UIImage imageNamed:@"order_sign_intention"];
            
        }
        
    } else {
        
        self.signImageView.hidden = YES;
        
    }

    [self changeState];
    
}

- (void)selectedEvent {
    
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    MyOrderDetailsOrderMsgList *model = data;
    
    if (model) {
        
        // Expend string height.
        model.normalStringHeight = 100 *Scale_Height;
        
        // One line height.
        model.noDataStringHeight = 0;
    }
    
    return 0.f;
}

@end
