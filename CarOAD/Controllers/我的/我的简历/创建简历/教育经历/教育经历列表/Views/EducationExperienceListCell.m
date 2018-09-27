//
//  EducationExperienceListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "EducationExperienceListCell.h"

#import "CreateCVEducationExperienceData.h"

@interface EducationExperienceListCell ()

@property (nonatomic, strong) UIView      *expendBackView;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView  *bottom_line_view;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *universityLabel;
@property (nonatomic, strong) UILabel *educationNameLabel;
@property (nonatomic, strong) UILabel *eduMajorLabel;

@end

@implementation EducationExperienceListCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.expendBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 *Scale_Height)];
    self.expendBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expendBackView];
    
    {
        
        self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                                     labelType:kLabelNormal
                                                          text:@""
                                                          font:UIFont_15
                                                     textColor:TextBlackColor
                                                 textAlignment:NSTextAlignmentLeft
                                                           tag:100];
        [self.expendBackView addSubview:self.dateLabel];
        
        self.universityLabel = [UILabel createLabelWithFrame:CGRectZero
                                                   labelType:kLabelNormal
                                                        text:@""
                                                        font:UIFont_15
                                                   textColor:TextBlackColor
                                               textAlignment:NSTextAlignmentLeft
                                                         tag:100];
        [self.expendBackView addSubview:self.universityLabel];
        
        self.educationNameLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@""
                                                           font:UIFont_14
                                                      textColor:TextGrayColor
                                                  textAlignment:NSTextAlignmentRight
                                                            tag:101];
        [self.expendBackView addSubview:self.educationNameLabel];
        
        self.eduMajorLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentRight
                                                       tag:101];
        [self.expendBackView addSubview:self.eduMajorLabel];
        
    }
    
    self.bottom_line_view                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottom_line_view.backgroundColor = LineColor;
    [self.expendBackView addSubview:self.bottom_line_view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 22 *Scale_Height, (self.contentView.height - 14 *Scale_Height) / 2, 7 *Scale_Height, 14 *Scale_Height)];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:@"arrow_right_gray"];
    [self.contentView addSubview:imageView];
    self.arrowImageView = imageView;
}

- (void)layoutSubviews {
    
    self.dateLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.expendBackView.width - 50 *Scale_Width, 20 *Scale_Height);
    
    self.universityLabel.frame = CGRectMake(15 *Scale_Width, self.dateLabel.y + self.dateLabel.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Height, 20 *Scale_Height);
    
    [self.educationNameLabel sizeToFit];
    [self.eduMajorLabel sizeToFit];
    
    self.educationNameLabel.frame = CGRectMake(15 *Scale_Width, self.universityLabel.y + self.universityLabel.height + 10 *Scale_Height, self.educationNameLabel.width, 20 *Scale_Height);
    self.bottom_line_view.frame = CGRectMake(self.educationNameLabel.x + self.educationNameLabel.width + 5 *Scale_Width, self.educationNameLabel.y + 3 *Scale_Height, 1.f, 14 *Scale_Height);
    self.eduMajorLabel.frame = CGRectMake(self.bottom_line_view.x + self.bottom_line_view.width + 5 *Scale_Width, self.educationNameLabel.y, self.eduMajorLabel.width, 20 *Scale_Height);
    
    self.arrowImageView.frame = CGRectMake(Screen_Width - 22 *Scale_Height, (self.contentView.height - 14 *Scale_Height) / 2, 7 *Scale_Height, 14 *Scale_Height);
    
}

- (void)loadContent {
    
    CreateCVEducationExperienceData *model = self.data;
    
    if (model.entryEduDate.length > 0 && model.endEduDate.length > 0) {
        
        NSDate *quitDate = nil;
        NSString *quitDateString = nil;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *entryDate = [dateFormatter dateFromString:model.entryEduDate];
        
        if (![model.endEduDate isEqualToString:@"至今"]) {
            
            quitDate  = [dateFormatter dateFromString:model.endEduDate];
            [dateFormatter setDateFormat:@"yyyy.MM"];
            quitDateString = [dateFormatter stringFromDate:quitDate];
            
        } else {
            
            quitDateString = model.endEduDate;
            
        }
        
        [dateFormatter setDateFormat:@"yyyy.MM"];
        NSString *entryDateString = [dateFormatter stringFromDate:entryDate];
        
        self.dateLabel.text = [NSString stringWithFormat:@"%@-%@",entryDateString,quitDateString];
        
    } else {
        
        self.dateLabel.text = @"";
        
    }

    if (model.university.length > 0) {
        
        self.universityLabel.text = model.university;
        
    } else {
        
        self.universityLabel.text = @"";
        
    }
    
    if (model.educationName.length > 0) {
        
        self.educationNameLabel.text = model.educationName;
        
    } else {
        
        self.educationNameLabel.text = @"";
        
    }
    
    if (model.eduMajor.length > 0) {
        
        self.eduMajorLabel.text = model.eduMajor;
        
    } else {
        
        self.eduMajorLabel.text = @"";
        
    }
    
}

@end
