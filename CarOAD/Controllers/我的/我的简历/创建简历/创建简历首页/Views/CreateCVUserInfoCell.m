//
//  CreateCVUserInfoCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CreateCVUserInfoCell.h"
#import "CreateCVUserInfoData.h"

#import "NSString+LabelWidthAndHeight.h"

@interface CreateCVUserInfoCell()

@property (nonatomic, strong) UIView  *normalBackView;
@property (nonatomic, strong) UIView  *expendBackView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UIView  *first_h_lineView;
@property (nonatomic, strong) UILabel *ageLabel;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIView  *second_h_lineView;
@property (nonatomic, strong) UILabel *jobStatusLabel;

@property (nonatomic, strong) UIImageView *addressImageView;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIImageView *topJobexperiencesImageView;
@property (nonatomic, strong) UILabel *topJobexperiencesLabel;

@property (nonatomic, strong) UIImageView *topEduImageView;
@property (nonatomic, strong) UILabel *topEduLabel;

@property (nonatomic, strong) UIView  *v_lineView;

@property (nonatomic, strong) UILabel *skillsLabel;

@end

@implementation CreateCVUserInfoCell

- (void)setupCell {

    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

}

- (void)buildSubview {

    self.normalBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 *Scale_Height)];
    self.normalBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.normalBackView];

    self.expendBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, self.normalBackView.y + self.normalBackView.height, Screen_Width, 60 *Scale_Height)];
    self.expendBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expendBackView];

    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15 *Scale_Width, (self.normalBackView.height - 70 *Scale_Height) / 2, 70 *Scale_Height, 70 *Scale_Height)];
    self.iconImageView.image           = [UIImage imageNamed:@"contact_off_gray"];
    self.iconImageView.contentMode     = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds   = YES;
    self.iconImageView.backgroundColor = [UIColor clearColor];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2;
    self.iconImageView.tag                 = 200;
    [self.normalBackView addSubview:self.iconImageView];

    self.nameLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_14
                                             textColor:TextBlackColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
    [self.normalBackView addSubview:self.nameLabel];

    self.sexLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_13
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:101];
    [self.normalBackView addSubview:self.sexLabel];

    self.first_h_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.first_h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.first_h_lineView];

    self.ageLabel = [UILabel createLabelWithFrame:CGRectZero
                                        labelType:kLabelNormal
                                             text:@""
                                             font:UIFont_13
                                        textColor:TextGrayColor
                                    textAlignment:NSTextAlignmentLeft
                                              tag:102];
    [self.normalBackView addSubview:self.ageLabel];

    self.phoneLabel = [UILabel createLabelWithFrame:CGRectZero
                                        labelType:kLabelNormal
                                             text:@""
                                             font:UIFont_13
                                        textColor:TextGrayColor
                                    textAlignment:NSTextAlignmentLeft
                                              tag:102];
    [self.normalBackView addSubview:self.phoneLabel];

    self.second_h_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.second_h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.second_h_lineView];

    self.jobStatusLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_13
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:102];
    [self.normalBackView addSubview:self.jobStatusLabel];

    self.addressImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.addressImageView.image       = [UIImage imageNamed:@"location_address"];
    self.addressImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.normalBackView addSubview:self.addressImageView];

    self.addressLabel = [UILabel createLabelWithFrame:CGRectZero
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:UIFont_13
                                              textColor:TextGrayColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:102];
    [self.normalBackView addSubview:self.addressLabel];

    self.topJobexperiencesImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.topJobexperiencesImageView.image       = [UIImage imageNamed:@"job_limit"];
    self.topJobexperiencesImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.normalBackView addSubview:self.topJobexperiencesImageView];

    self.topJobexperiencesLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_13
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:102];
    [self.normalBackView addSubview:self.topJobexperiencesLabel];

    self.topEduImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.topEduImageView.image       = [UIImage imageNamed:@"educational_background"];
    self.topEduImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.normalBackView addSubview:self.topEduImageView];

    self.topEduLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@""
                                                           font:UIFont_13
                                                      textColor:TextGrayColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:102];
    [self.normalBackView addSubview:self.topEduLabel];

    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = LineColor;
    [self.expendBackView addSubview:self.v_lineView];

    self.skillsLabel = [UILabel createLabelWithFrame:CGRectZero
                                           labelType:kLabelNormal
                                                text:@""
                                                font:UIFont_14
                                           textColor:TextGrayColor
                                       textAlignment:NSTextAlignmentLeft
                                                 tag:102];
    self.skillsLabel.numberOfLines = 0;
    [self.expendBackView addSubview:self.skillsLabel];

}

- (void)layoutSubviews {

    [self.phoneLabel sizeToFit];
    self.phoneLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y + 30 *Scale_Height, self.phoneLabel.width, 20 *Scale_Height);

    self.second_h_lineView.frame = CGRectMake(self.phoneLabel.x + self.phoneLabel.width + 10 *Scale_Width, self.phoneLabel.y + 3 *Scale_Height, 1.5f *Scale_Width, 14 *Scale_Height);

    self.first_h_lineView.frame = CGRectMake(self.second_h_lineView.x, self.second_h_lineView.y - 30 *Scale_Height, self.second_h_lineView.width, self.second_h_lineView.height);

    [self.sexLabel sizeToFit];
    self.sexLabel.frame = CGRectMake(self.first_h_lineView.x - 10 *Scale_Width - self.sexLabel.width, self.iconImageView.y, self.sexLabel.width, 20 *Scale_Height);

    [self.nameLabel sizeToFit];
    self.nameLabel.frame = CGRectMake(self.phoneLabel.x, self.iconImageView.y, self.sexLabel.x - self.phoneLabel.x - 5 *Scale_Width, 20 *Scale_Height);

    [self.ageLabel sizeToFit];
    self.ageLabel.frame = CGRectMake(self.first_h_lineView.x + self.first_h_lineView.width + 10 *Scale_Width, self.nameLabel.y, self.ageLabel.width, 20 *Scale_Height);

    self.jobStatusLabel.frame = CGRectMake(self.second_h_lineView.x + self.second_h_lineView.width + 10 *Scale_Width, self.phoneLabel.y, Screen_Width - (self.second_h_lineView.x + self.second_h_lineView.width + 25 *Scale_Width), 20 *Scale_Height);

    CGFloat width = (Screen_Width - self.iconImageView.x - self.iconImageView.width - 25 *Scale_Width) / 3;
    self.addressImageView.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y + self.iconImageView.height - 16 *Scale_Width, 16 *Scale_Height, 16 *Scale_Height);
    self.addressLabel.frame = CGRectMake(self.addressImageView.x + self.addressImageView.width + 5 *Scale_Width, self.addressImageView.y - 2 *Scale_Height, width - (self.addressImageView.width + 10 *Scale_Width), 20 *Scale_Height);

    self.topJobexperiencesImageView.frame = CGRectMake(self.addressImageView.x + width, self.addressImageView.y, 16 *Scale_Height, 16 *Scale_Height);
    self.topJobexperiencesLabel.frame = CGRectMake(self.topJobexperiencesImageView.x + self.topJobexperiencesImageView.width + 5 *Scale_Width, self.topJobexperiencesImageView.y, width - (self.topJobexperiencesImageView.width + 10 *Scale_Width), 20 *Scale_Height);

    self.topEduImageView.frame = CGRectMake(self.topJobexperiencesImageView.x + width, self.addressImageView.y, 16 *Scale_Height, 16 *Scale_Height);
    self.topEduLabel.frame = CGRectMake(self.topEduImageView.x + self.topEduImageView.width + 5 *Scale_Width, self.topEduImageView.y, width - (self.topEduImageView.width + 10 *Scale_Width), 20 *Scale_Height);

    CGFloat totalStringHeight = [self.skillsLabel.text heightWithStringFont:UIFont_14 fixedWidth:Width - 30 *Scale_Width];
    self.skillsLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, totalStringHeight);
    self.expendBackView.frame = CGRectMake(0, self.normalBackView.y + self.normalBackView.height, Screen_Width, 20 *Scale_Height + totalStringHeight);
    self.v_lineView.frame = CGRectMake(0, 0, self.expendBackView.width, 0.5f);

}

- (void)changeState {
    

    
}

- (void)normalState {
    

    
}

- (void)expendState {
    

    
}

- (void)loadContent {

    CreateCVUserInfoData *model = self.dataAdapter.data;

    NSString *userImgString = model.userImg;
    if (userImgString.length > 0) {

        [QTDownloadWebImage downloadImageForImageView:self.iconImageView
                                             imageUrl:[NSURL URLWithString:userImgString]
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

    if (model.userSex.length > 0) {

        if ([model.userSex isEqualToString:@"M"]) {
            
            self.sexLabel.text = @"男";
            
        } else {
            
            self.sexLabel.text = @"女";
            
        }
        

    } else {

        self.sexLabel.text = @"";

    }

    if (model.birthDate.length > 0) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSDate *birthDate = [dateFormatter dateFromString:model.birthDate];
        [dateFormatter setDateFormat:@"yyyy"];
        NSString *year    = [dateFormatter stringFromDate:birthDate];
        NSString *nowYear = [dateFormatter stringFromDate:[NSDate date]];
        NSInteger age = [nowYear integerValue] - [year integerValue];

        self.ageLabel.text = [NSString stringWithFormat:@"%ld岁",age];

    } else {

        self.ageLabel.text = @"";

    }

    if (model.phone.length > 0) {

        self.phoneLabel.text = model.phone;

    } else {

        self.phoneLabel.text = @"";

    }

    if (model.applyStateName.length > 0) {

        self.jobStatusLabel.text = model.applyStateName;

    } else {

        self.jobStatusLabel.text = @"";

    }

    if (model.inCity.length > 0) {

        self.addressLabel.text = model.inCity;

    } else {

        self.addressLabel.text = @"";

    }

    if (model.workLifeName.length > 0) {

        self.topJobexperiencesLabel.text = model.workLifeName;

    } else {

        self.topJobexperiencesLabel.text = @"";

    }
    
    CarOadLog(@"model.topEduName --- %@",model.topEduName);

    if (model.topEduName.length > 0) {

        self.topEduLabel.text = model.topEduName;

    } else {

        self.topEduLabel.text = @"";

    }

    if (model.adeptSkill.length > 0) {

        self.skillsLabel.text = model.adeptSkill;

    } else {

        self.skillsLabel.text = @"";

    }
    
}

- (void)selectedEvent {


}

+ (CGFloat)cellHeightWithData:(id)data {

    CreateCVUserInfoData *model = data;

    if (model) {

        CGFloat totalStringHeight = [model.adeptSkill heightWithStringFont:UIFont_14 fixedWidth:Width - 30 *Scale_Width];
        
        // Expend string height.
        model.normalStringHeight = 120 *Scale_Height + totalStringHeight;

        // One line height.
        model.noDataStringHeight = 100 *Scale_Height;
    }

    return 0.f;
}

@end
