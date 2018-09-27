//
//  CreateCVEducationExperienceCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CreateCVEducationExperienceCell.h"

#import "CreateCVEducationExperienceData.h"

@interface CreateCVEducationExperienceCell()

@property (nonatomic, strong) UIView  *normalBackView;
@property (nonatomic, strong) UIView  *expendBackView;

@property (nonatomic, strong) UILabel *noDataTitleLabel;
@property (nonatomic, strong) UILabel *noDataContentLabel;

@property (nonatomic, strong) UIView  *top_line_view;
@property (nonatomic, strong) UIView  *bottom_line_view;

@property (nonatomic, strong) UILabel *entryEduDateLabel;
@property (nonatomic, strong) UILabel *endEduDateLabel;
@property (nonatomic, strong) UILabel *universityLabel;
@property (nonatomic, strong) UILabel *educationNameLabel;
@property (nonatomic, strong) UILabel *eduMajorLabel;
@property (nonatomic, strong) UIView  *bottom_v_lineView;

@end

@implementation CreateCVEducationExperienceCell

- (void)setupCell {

    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

}

- (void)buildSubview {

    self.normalBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height)];
    self.normalBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.normalBackView];

    self.expendBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 *Scale_Height)];
    self.expendBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expendBackView];

    {

        self.noDataTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:@"尚未添加教育经历"
                                                         font:UIFont_15
                                                    textColor:TextBlackColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:100];
        [self.normalBackView addSubview:self.noDataTitleLabel];
        [self.noDataTitleLabel sizeToFit];
        self.noDataTitleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.noDataTitleLabel.width, 20 *Scale_Height);

        self.noDataContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@"请从最高学历填起"
                                                           font:UIFont_14
                                                      textColor:TextGrayColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:101];
        [self.normalBackView addSubview:self.noDataContentLabel];
        [self.noDataContentLabel sizeToFit];
        self.noDataContentLabel.frame = CGRectMake(15 *Scale_Width, self.noDataTitleLabel.y + self.noDataTitleLabel.height + 10 *Scale_Height, self.noDataContentLabel.width, 20 *Scale_Height);

    }
    
    {
        
        self.entryEduDateLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:UIFont_15
                                              textColor:TextGrayColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
        [self.expendBackView addSubview:self.entryEduDateLabel];
        
        self.endEduDateLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_14
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentRight
                                                   tag:101];
        [self.expendBackView addSubview:self.endEduDateLabel];
        
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
    
    self.top_line_view                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.top_line_view.backgroundColor = LineColor;
    [self.expendBackView addSubview:self.top_line_view];
    
    self.bottom_line_view                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottom_line_view.backgroundColor = LineColor;
    [self.expendBackView addSubview:self.bottom_line_view];

    self.bottom_v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottom_v_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.bottom_v_lineView];
    
}

- (void)layoutSubviews {
    
    [self.entryEduDateLabel sizeToFit];
    [self.endEduDateLabel sizeToFit];
    
    self.entryEduDateLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.entryEduDateLabel.width, 20 *Scale_Height);
    self.top_line_view.frame = CGRectMake(self.entryEduDateLabel.x + self.entryEduDateLabel.width + 5 *Scale_Width, self.entryEduDateLabel.y + 3 *Scale_Height, 1.f, 14 *Scale_Height);
    self.endEduDateLabel.frame = CGRectMake(self.top_line_view.x + self.top_line_view.width + 5 *Scale_Width, 10 *Scale_Height, self.endEduDateLabel.width, 20 *Scale_Height);
    
    self.universityLabel.frame = CGRectMake(15 *Scale_Width, self.entryEduDateLabel.y + self.entryEduDateLabel.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Height, 20 *Scale_Height);
    
    [self.educationNameLabel sizeToFit];
    [self.eduMajorLabel sizeToFit];
    
    self.educationNameLabel.frame = CGRectMake(15 *Scale_Width, self.universityLabel.y + self.universityLabel.height + 10 *Scale_Height, self.educationNameLabel.width, 20 *Scale_Height);
    self.bottom_line_view.frame = CGRectMake(self.educationNameLabel.x + self.educationNameLabel.width + 5 *Scale_Width, self.educationNameLabel.y + 3 *Scale_Height, 1.f, 14 *Scale_Height);
    self.eduMajorLabel.frame = CGRectMake(self.bottom_line_view.x + self.bottom_line_view.width + 5 *Scale_Width, self.educationNameLabel.y, self.eduMajorLabel.width, 20 *Scale_Height);
    
    self.bottom_v_lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);
    
}

- (void)changeState {

    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kCreateCVEducationExperienceCellNoDataType) {

        [self normalState];

    } else {

        [self expendState];

    }

}

- (void)normalState {

    self.normalBackView.hidden = NO;
    self.expendBackView.hidden = YES;

}

- (void)expendState {

    self.normalBackView.hidden = YES;
    self.expendBackView.hidden = NO;

}

- (void)loadContent {

    CreateCVEducationExperienceData *model = self.dataAdapter.data;
    
    if (model.entryEduDate.length > 0) {
        
        self.entryEduDateLabel.text = model.entryEduDate;
        
    } else {
        
        self.entryEduDateLabel.text = @"";
        
    }
    
    if (model.endEduDate.length > 0) {
        
        self.endEduDateLabel.text = model.endEduDate;
        
    } else {
        
        self.endEduDateLabel.text = @"";
        
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
    
    [self changeState];

}

- (void)selectedEvent {


}

+ (CGFloat)cellHeightWithData:(id)data {

    CreateCVEducationExperienceData *model = data;

    if (model) {

        // Expend string height.
        model.normalStringHeight = 100 *Scale_Height;

        // One line height.
        model.noDataStringHeight = 70 *Scale_Height;

    }

    return 0.f;
}

@end
