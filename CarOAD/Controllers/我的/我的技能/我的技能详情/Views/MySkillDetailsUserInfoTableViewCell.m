//
//  MySkillDetailsUserInfoTableViewCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MySkillDetailsUserInfoTableViewCell.h"

#import "MYSkillDetailesData.h"

@interface MySkillDetailsUserInfoTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *typeLabel;

@end

@implementation MySkillDetailsUserInfoTableViewCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, 70 *Scale_Height, 70 *Scale_Height)];
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
        
        UIImageView *favoriteImageView    = [[UIImageView alloc] initWithFrame:CGRectMake(nameLabel.x + 17 *Scale_Height *i, nameLabel.y + nameLabel.height + 23 *Scale_Height, 14 *Scale_Height, 14 *Scale_Height)];
        favoriteImageView.image           = [UIImage imageNamed:@"favorite_off_hollow_blue"];
        favoriteImageView.contentMode     = UIViewContentModeScaleAspectFit;
        favoriteImageView.tag             = 300 + i;
        [self.contentView addSubview:favoriteImageView];
        
    }
    
    UILabel *typeLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"已实名认证"
                                                  font:UIFont_13
                                             textColor:CarOadColor(214, 150, 0)
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
    [self.contentView addSubview:typeLabel];
    [typeLabel sizeToFit];
    typeLabel.frame = CGRectMake(Screen_Width - 25 *Scale_Width - typeLabel.width, nameLabel.y, typeLabel.width + 10 *Scale_Width, 20 *Scale_Height);
    typeLabel.layer.masksToBounds = YES;
    typeLabel.layer.cornerRadius  = 3 *Scale_Height;
    typeLabel.layer.borderWidth   = 0.5f;
    typeLabel.layer.borderColor   = CarOadColor(214, 150, 0).CGColor;
    self.typeLabel = typeLabel;
    
    self.iconImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.typeLabel.hidden = YES;
    
}

- (void)changeState {
    
    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kMySkillDetailsUserInfoTableViewCellNoDataType) {
        
        [self normalState];
        
    } else {
        
        [self expendState];
        
    }
    
}

- (void)normalState {

    self.iconImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.typeLabel.hidden = YES;
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
    self.typeLabel.hidden = NO;
    for (UIView *subView in self.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]] && subView.tag >= 300 && subView.tag < 400) {
            
            UIImageView *imageView = (UIImageView *)subView;
            imageView.hidden = NO;
            
        }
        
    }
    
}

- (void)loadContent {
    
    MYSkillDetailesData *model = self.dataAdapter.data;
    
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
        
    NSString *creditScoreString = [model.creditScore stringByReplacingOccurrencesOfString:@"." withString:@""];
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
    
    if (model.isRealNameAuth.length > 0 && [model.isRealNameAuth integerValue] == 1) {
        
        self.typeLabel.hidden = NO;
        
    } else {
        
        self.typeLabel.hidden = YES;
        
    }
    
    [self changeState];
    
}

- (void)selectedEvent {
    
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    MYSkillDetailesData *model = data;
    
    if (model) {
        
        // Expend string height.
        model.normalStringHeight = 90 *Scale_Height;
        
        // One line height.
        model.noDataStringHeight = 0;
    }
    
    return 0.f;
}

@end
