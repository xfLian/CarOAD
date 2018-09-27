//
//  MyEvaluateListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyEvaluateListCell.h"

#import "MyEvaluateListCommentList.h"

@interface MyEvaluateListCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *shopLabel;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel     *arrowLabel;

@end

@implementation MyEvaluateListCell

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
    
    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(imageView.x + imageView.width + 10 *Scale_Width, imageView.y, 100 *Scale_Height, 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_16
                                             textColor:TextBlackColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *favoriteImageView    = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 15 *Scale_Width - 82 *Scale_Height + 17 *Scale_Height *i, imageView.y + 8 *Scale_Height, 14 *Scale_Height, 14 *Scale_Height)];
        favoriteImageView.image           = [UIImage imageNamed:@"favorite_off_hollow_blue"];
        favoriteImageView.contentMode     = UIViewContentModeScaleAspectFit;
        favoriteImageView.tag             = 300 + i;
        [self.contentView addSubview:favoriteImageView];
        favoriteImageView.hidden = YES;
    }
    
    UILabel *shopLabel = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 10 *Scale_Height, Screen_Width - (nameLabel.x + 15 *Scale_Height), 20 *Scale_Height)
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_14
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.contentView addSubview:shopLabel];
    self.shopLabel = shopLabel;
    
    UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(nameLabel.x, shopLabel.y + shopLabel.height + 10 *Scale_Height, Screen_Width - (nameLabel.x + 15 *Scale_Height), 20 *Scale_Height)
                                                labelType:kLabelNormal
                                                     text:@""
                                                     font:UIFont_15
                                                textColor:TextGrayColor
                                            textAlignment:NSTextAlignmentLeft
                                                      tag:100];
    contentLabel.numberOfLines = 0;
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
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    arrowImageView.contentMode  = UIViewContentModeScaleAspectFit;
    arrowImageView.image        = [UIImage imageNamed:@"arrow_right_gray"];
    [self.contentView addSubview:arrowImageView];
    self.arrowImageView = arrowImageView;
    
    UILabel *arrowLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"查看详情"
                                                  font:UIFont_13
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.contentView addSubview:arrowLabel];
    self.arrowLabel = arrowLabel;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = LineColor;
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    self.iconImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.contentLabel.hidden = YES;
    self.dateLabel.hidden = YES;
    self.shopLabel.hidden = YES;
    self.arrowImageView.hidden = YES;
    self.arrowLabel.hidden = YES;
    
}

- (void)layoutSubviews {
    
    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y, Screen_Width - 15 *Scale_Width - 82 *Scale_Height - (self.iconImageView.x + self.iconImageView.width + 20 *Scale_Width), 20 *Scale_Height);
    
    self.shopLabel.frame = CGRectMake(self.nameLabel.x, self.nameLabel.y + self.nameLabel.height + 10 *Scale_Height, Screen_Width - (self.nameLabel.x + 15 *Scale_Height), 20 *Scale_Height);
    
    CGFloat totalStringHeight = [self.contentLabel.text heightWithStringFont:UIFont_15 fixedWidth:Screen_Width - 90 *Scale_Width];
    self.contentLabel.frame = CGRectMake(self.nameLabel.x, self.shopLabel.y + self.shopLabel.height + 10 *Scale_Height, Screen_Width - 90 *Scale_Height, totalStringHeight);
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(self.nameLabel.x, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);

    self.arrowImageView.frame = CGRectMake(Screen_Width - 22 *Scale_Height, self.dateLabel.y + 3 *Scale_Height, 7 *Scale_Height, 14 *Scale_Height);
    
    [self.arrowLabel sizeToFit];
    self.arrowLabel.frame = CGRectMake(self.arrowImageView.x - 10 *Scale_Width - self.arrowLabel.width, self.dateLabel.y, self.arrowLabel.width, 20 *Scale_Height);
    
    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, Screen_Width - 15 *Scale_Width, 0.5f);

}

- (void)changeState {
    
    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kMyEvaluateListCellNoDataType) {
        
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
    self.arrowImageView.hidden = YES;
    self.arrowLabel.hidden = YES;
    
}

- (void)expendState {
    
    self.iconImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.contentLabel.hidden = NO;
    self.dateLabel.hidden = NO;
    self.shopLabel.hidden = NO;
    self.arrowImageView.hidden = NO;
    self.arrowLabel.hidden = NO;
    
}

- (void)loadContent {
    
    MyEvaluateListCommentList *model = self.dataAdapter.data;
    
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
    
    if (model.shopName.length > 0) {
        
        self.shopLabel.text = model.shopName;
        
    } else {
        
        self.shopLabel.text = @"";
        
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
    
    NSString *creditScoreString = [model.holistic stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSInteger creditScore = [creditScoreString integerValue];
    NSInteger creditScoreX = creditScore / 10;
    NSInteger creditScoreY = creditScore % 10;
    NSMutableArray *imageViewArray = [[NSMutableArray alloc] init];
    
    for (UIView *subView in self.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag >= 300 && subView.tag < 400) {
            
            UIImageView *imageView = (UIImageView *)subView;
            [imageViewArray addObject:imageView];
            imageView.hidden = NO;
        }
        
    }
    
    if (creditScoreX > 0) {
        
        for (int i = 0; i < creditScoreX; i++) {
            
            UIImageView *imageView = imageViewArray[i];
            imageView.image        = [UIImage imageNamed:@"favorite_off_full_blue"];
            
        }

        for (int i = (int)creditScoreX; i < 5; i++) {
            
            UIImageView *imageView = imageViewArray[i];
            imageView.image        = [UIImage imageNamed:@"favorite_off_hollow_blue"];
            
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
    
    MyEvaluateListCommentList *model = data;
    
    if (model) {
        
        CGFloat totalStringHeight = [model.commentInfo heightWithStringFont:UIFont_15 fixedWidth:Screen_Width - 90 *Scale_Height];
        // Expend string height.
        model.normalStringHeight = 110 *Scale_Height + totalStringHeight;
        
        // One line height.
        model.noDataStringHeight = 0;
    }
    
    return 0.f;
}

@end
