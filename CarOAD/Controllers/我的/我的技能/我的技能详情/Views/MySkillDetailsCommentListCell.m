//
//  MySkillDetailsCommentListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MySkillDetailsCommentListCell.h"

#import "MYSkillDetailesOrderMsgList.h"

@interface MySkillDetailsCommentListCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *shopLabel;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation MySkillDetailsCommentListCell

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
    
    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(imageView.x + imageView.width + 10 *Scale_Width, imageView.y + 5 *Scale_Height, 100 *Scale_Height, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:TextBlackColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *favoriteImageView    = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 15 *Scale_Width - 82 *Scale_Height + 17 *Scale_Height *i, 18 *Scale_Height, 14 *Scale_Height, 14 *Scale_Height)];
        favoriteImageView.image           = [UIImage imageNamed:@"favorite_off_hollow_blue"];
        favoriteImageView.contentMode     = UIViewContentModeScaleAspectFit;
        favoriteImageView.tag             = 300 + i;
        [self.contentView addSubview:favoriteImageView];
        
    }
    
    UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 10 *Scale_Height, Screen_Width - (nameLabel.x + 15 *Scale_Height), 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel *dateLabel = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, contentLabel.y + contentLabel.height + 10 *Scale_Height, 100 *Scale_Width, 20 *Scale_Height)
                                                labelType:kLabelNormal
                                                     text:@""
                                                     font:UIFont_13
                                                textColor:TextGrayColor
                                            textAlignment:NSTextAlignmentLeft
                                                      tag:100];
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    UILabel *shopLabel = [UILabel createLabelWithFrame:CGRectZero
                                                labelType:kLabelNormal
                                                     text:@""
                                                     font:UIFont_15
                                                textColor:TextGrayColor
                                            textAlignment:NSTextAlignmentRight
                                                      tag:100];
    [self.contentView addSubview:shopLabel];
    self.shopLabel = shopLabel;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = LineColor;
    [self.contentView addSubview:lineView];
    self.lineView = lineView;

    self.iconImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.contentLabel.hidden = YES;
    self.dateLabel.hidden = YES;
    self.shopLabel.hidden = YES;
    
}

- (void)layoutSubviews {
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(self.nameLabel.x, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    self.shopLabel.frame = CGRectMake(self.dateLabel.x + self.dateLabel.width + 10 *Scale_Width, self.dateLabel.y, Screen_Width - (self.dateLabel.x + self.dateLabel.width + 25 *Scale_Width), 20 *Scale_Height);
    
    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, Screen_Width - 15 *Scale_Width, 0.5f);
    
}

- (void)changeState {
    
    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kMySkillDetailsCommentListCellNoDataType) {
        
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
    self.shopLabel.hidden = YES;
    
    for (UIView *subView in self.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag >= 300 && subView.tag < 400) {
            
            UIImageView *imageView = (UIImageView *)subView;
            imageView.hidden = YES;
            
        }
        
    }
    
}

- (void)expendState {
    
    self.iconImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.contentLabel.hidden = NO;
    self.dateLabel.hidden = NO;
    self.shopLabel.hidden = NO;
    
    for (UIView *subView in self.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag >= 300 && subView.tag < 400) {
            
            UIImageView *imageView = (UIImageView *)subView;
            imageView.hidden = NO;
            
        }
        
    }
    
}

- (void)loadContent {
    
    MYSkillDetailesOrderMsgList *model = self.dataAdapter.data;
        
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
    
    if (model.shopLinkman.length > 0) {
        
        self.nameLabel.text = model.shopLinkman;
        
    } else {
        
        self.nameLabel.text = @"";
        
    }
    
    if (model.commentInfo.length > 0) {
        
        self.contentLabel.text = model.commentInfo;
        
    } else {
        
        self.contentLabel.text = @"";
        
    }
    
    if (model.commentDate.length > 0) {
        
        self.dateLabel.text = model.commentDate;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    if (model.shopName.length > 0) {
        
        self.shopLabel.text = model.shopName;
        
    } else {
        
        self.shopLabel.text = @"";
        
    }
    
    NSString *creditScoreString = [model.score stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSInteger creditScore = [creditScoreString integerValue];
    NSInteger creditScoreX = creditScore / 10;
    NSInteger creditScoreY = creditScore % 10;
    NSMutableArray *imageViewArray = [[NSMutableArray alloc] init];
    
    for (UIView *subView in self.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag >= 300 && subView.tag < 400) {
            
            UIImageView *imageView = (UIImageView *)subView;
            [imageViewArray addObject:imageView];
            
        }
        
    }
    
    if (creditScoreX > 0) {
        
        for (int i = 0; i < creditScoreX; i++) {
            
            UIImageView *imageView = imageViewArray[i];
            imageView.image        = [UIImage imageNamed:@"favorite_off_full_blue"];
            
        }
        
        if (creditScoreY > 0) {
            
            UIImageView *imageView = imageViewArray[creditScoreX];
            imageView.image        = [UIImage imageNamed:@"favorite_off_hollow_full_blue"];
            
        }
        
    } else {
        
        if (creditScoreY > 0) {
            
            UIImageView *imageView = imageViewArray[0];
            imageView.image        = [UIImage imageNamed:@"favorite_off_hollow_full_blue"];
            
        }
        
    }
    
    [self changeState];
    
}

- (void)selectedEvent {
    
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    MYSkillDetailesOrderMsgList *model = data;
    
    if (model) {
        
        // Expend string height.
        model.normalStringHeight = 110 *Scale_Height;
        
        // One line height.
        model.noDataStringHeight = 0;
    }
    
    return 0.f;
}

@end
