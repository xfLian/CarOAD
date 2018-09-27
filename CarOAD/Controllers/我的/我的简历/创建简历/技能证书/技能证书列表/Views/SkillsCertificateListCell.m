//
//  SkillsCertificateListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "SkillsCertificateListCell.h"

#import "CreateCVSkillsCertificateData.h"

@interface SkillsCertificateListCell()

@property (nonatomic, strong) UIView  *expendBackView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView  *imageBackView;

@property (nonatomic, strong) UIView *h_lineView;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation SkillsCertificateListCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.expendBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - 37 *Scale_Height, 50 *Scale_Height + (Screen_Width - 97 *Scale_Width) / 3)];
    self.expendBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expendBackView];
    
    {
        
        self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:UIFont_15
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
        [self.expendBackView addSubview:self.titleLabel];
        [self.titleLabel sizeToFit];
        self.titleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.titleLabel.width, 20 *Scale_Height);
        
        self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_14
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentRight
                                                   tag:101];
        [self.expendBackView addSubview:self.dateLabel];
        
        
    }
    
    {
        
        self.imageBackView                 = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 40 *Scale_Height, self.expendBackView.width - 30 *Scale_Width, (self.expendBackView.width - 60 *Scale_Width) / 3)];
        self.imageBackView.backgroundColor = [UIColor clearColor];
        [self.expendBackView addSubview:self.imageBackView];
        
    }
    
    self.h_lineView                 = [[UIView alloc] initWithFrame:CGRectMake(self.expendBackView.x + self.expendBackView.width, 0, 0.7f, self.expendBackView.height)];
    self.h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.h_lineView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 22 *Scale_Height, (self.contentView.height - 14 *Scale_Height) / 2, 7 *Scale_Height, 14 *Scale_Height)];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:@"arrow_right_gray"];
    [self.contentView addSubview:imageView];
    self.arrowImageView = imageView;
    
}

- (void)layoutSubviews {
    
    self.arrowImageView.frame = CGRectMake(Screen_Width - 22 *Scale_Height, (self.contentView.height - 14 *Scale_Height) / 2, 7 *Scale_Height, 14 *Scale_Height);
    
}

- (void)loadContent {
    
    for (UIView *subView in self.imageBackView.subviews) {
        
        if (subView) {
            
            [subView removeFromSuperview];
            
        }
        
    }
    
    CreateCVSkillsCertificateData *model = self.data;
    
    if (model.skillCertName.length > 0) {
        
        self.titleLabel.text = model.skillCertName;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (model.certDate.length > 0) {
        
        self.dateLabel.text = model.certDate;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(self.expendBackView.width - 15 *Scale_Width - self.dateLabel.width, 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height,  self.dateLabel.x - 25 *Scale_Width, 20 *Scale_Height);
    
    if (model.certImg.length > 0) {
        
        NSArray *imageStringArray = [model.certImg componentsSeparatedByString:@","];
        
        for (int i = 0; i < imageStringArray.count; i++) {
            
            UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake((self.imageBackView.height + 15 *Scale_Width) *i, 0, self.imageBackView.height, self.imageBackView.height)];
            imageView.image         = [UIImage imageNamed:@"contact_off_gray"];
            imageView.contentMode   = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [self.imageBackView addSubview:imageView];
            
            [QTDownloadWebImage downloadImageForImageView:imageView
                                                 imageUrl:[NSURL URLWithString:imageStringArray[i]]
                                         placeholderImage:@"contact_off_gray"
                                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                     
                                                 }
                                                  success:^(UIImage *finishImage) {
                                                      
                                                  }];
            
        }
        
    }
    
}

@end
