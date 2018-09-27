//
//  JobExperiencesListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/17.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "JobExperiencesListCell.h"

#import "CreateCVJobexperiencesData.h"

@interface JobExperiencesListCell ()

@property (nonatomic, strong) UIView      *normalBackView;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *skillPostLabel;

@end

@implementation JobExperiencesListCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.normalBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 *Scale_Height)];
    self.normalBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.normalBackView];
    
    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:100];
    [self.normalBackView addSubview:self.dateLabel];
    self.dateLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.normalBackView.width - 30 *Scale_Width, 20 *Scale_Height);
    
    self.shopNameLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:TextBlackColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.normalBackView addSubview:self.shopNameLabel];
    self.shopNameLabel.frame = CGRectMake(15 *Scale_Width, self.dateLabel.y + self.dateLabel.height + 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    self.skillPostLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:UIFont_14
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [self.normalBackView addSubview:self.skillPostLabel];
    self.skillPostLabel.frame = CGRectMake(15 *Scale_Width, self.shopNameLabel.y + self.shopNameLabel.height + 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 22 *Scale_Height, (self.normalBackView.height - 14 *Scale_Height) / 2, 7 *Scale_Height, 14 *Scale_Height)];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:@"arrow_right_gray"];
    [self.normalBackView addSubview:imageView];
    self.arrowImageView = imageView;
    
}

- (void)loadContent {
    
    CreateCVJobexperiencesData *model = self.data;
    
    CarOadLog(@"model.entryDate --- %@",model.entryDate);
    CarOadLog(@"model.quitDate --- %@",model.quitDate);
    
    if (model.entryDate.length > 0 && model.quitDate.length > 0) {
        
        NSDate *quitDate = nil;
        NSString *quitDateString = nil;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        if (model.entryDate.length > 9) {
            
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
        } else {
            
            [dateFormatter setDateFormat:@"yyyy-MM"];
            
        }
        NSDate *entryDate = [dateFormatter dateFromString:model.entryDate];
        
        if (![model.quitDate isEqualToString:@"至今"]) {
            
            quitDate = [dateFormatter dateFromString:model.quitDate];
            [dateFormatter setDateFormat:@"yyyy.MM"];
            quitDateString = [dateFormatter stringFromDate:quitDate];
            
        } else {
            
            quitDateString = model.quitDate;
            
        }
        
        [dateFormatter setDateFormat:@"yyyy.MM"];
        NSString *entryDateString = [dateFormatter stringFromDate:entryDate];
        
        self.dateLabel.text = [NSString stringWithFormat:@"%@-%@",entryDateString,quitDateString];
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    if (model.shopName.length > 0) {
        
        self.shopNameLabel.text = model.shopName;
        
    } else {
        
        self.shopNameLabel.text = @"";
        
    }
    
    if (model.skillPost.length > 0) {
        
        self.skillPostLabel.text = model.skillPost;
        
    } else {
        
        self.skillPostLabel.text = @"";
        
    }
    
}

@end
