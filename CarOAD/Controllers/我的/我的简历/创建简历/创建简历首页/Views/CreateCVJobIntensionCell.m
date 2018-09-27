//
//  CreateCVJobIntensionCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CreateCVJobIntensionCell.h"

#import "CreateCVUserInfoData.h"

@interface CreateCVJobIntensionCell()

@property (nonatomic, strong) UIView  *normalBackView;
@property (nonatomic, strong) UIView  *expendBackView;

@property (nonatomic, strong) UILabel *noDataTitleLabel;
@property (nonatomic, strong) UILabel *noDataContentLabel;

@property (nonatomic, strong) UILabel *positionTitleLabel;
@property (nonatomic, strong) UILabel *positionContentLabel;

@property (nonatomic, strong) UILabel *payTitleLabel;
@property (nonatomic, strong) UILabel *payContentLabel;

@property (nonatomic, strong) UILabel *occupationTitleLabel;
@property (nonatomic, strong) UILabel *occupationContentLabel;

@property (nonatomic, strong) UILabel *typeTitleLabel;
@property (nonatomic, strong) UILabel *typeContentLabel;

@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UILabel *addressContentLabel;

@end

@implementation CreateCVJobIntensionCell

- (void)setupCell {

    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

}

- (void)buildSubview {

    self.normalBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height)];
    self.normalBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.normalBackView];

    self.expendBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 160 *Scale_Height)];
    self.expendBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expendBackView];

    {

        self.noDataTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:@"尚未添加求职意向"
                                                         font:UIFont_15
                                                    textColor:TextBlackColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:100];
        [self.normalBackView addSubview:self.noDataTitleLabel];
        [self.noDataTitleLabel sizeToFit];
        self.noDataTitleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.noDataTitleLabel.width, 20 *Scale_Height);

        self.noDataContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@"请根据实际情况填写"
                                                           font:UIFont_14
                                                      textColor:TextGrayColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:101];
        [self.normalBackView addSubview:self.noDataContentLabel];
        [self.noDataContentLabel sizeToFit];
        self.noDataContentLabel.frame = CGRectMake(15 *Scale_Width, self.noDataTitleLabel.y + self.noDataTitleLabel.height + 10 *Scale_Height, self.noDataContentLabel.width, 20 *Scale_Height);

    }

    {

        self.positionTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@"期望职位"
                                                           font:UIFont_14
                                                      textColor:TextBlackColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:100];
        [self.expendBackView addSubview:self.positionTitleLabel];
        [self.positionTitleLabel sizeToFit];
        self.positionTitleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.positionTitleLabel.width, 20 *Scale_Height);

        self.positionContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                        labelType:kLabelNormal
                                                             text:@""
                                                             font:UIFont_14
                                                        textColor:TextGrayColor
                                                    textAlignment:NSTextAlignmentLeft
                                                              tag:101];
        [self.expendBackView addSubview:self.positionContentLabel];
        self.positionContentLabel.frame = CGRectMake(self.positionTitleLabel.x + self.positionTitleLabel.width + 10 *Scale_Width, self.positionTitleLabel.y, self.expendBackView.width - (self.positionTitleLabel.x + self.positionTitleLabel.width + 25 *Scale_Width), 20 *Scale_Height);

    }

    {

        self.payTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@"期望薪资"
                                                           font:UIFont_14
                                                      textColor:TextBlackColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:100];
        [self.expendBackView addSubview:self.payTitleLabel];
        [self.payTitleLabel sizeToFit];
        self.payTitleLabel.frame = CGRectMake(self.positionTitleLabel.x, self.positionTitleLabel.y + self.positionTitleLabel.height + 10 *Scale_Height, self.payTitleLabel.width, 20 *Scale_Height);

        self.payContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                        labelType:kLabelNormal
                                                             text:@""
                                                             font:UIFont_14
                                                        textColor:TextGrayColor
                                                    textAlignment:NSTextAlignmentLeft
                                                              tag:101];
        [self.expendBackView addSubview:self.payContentLabel];
        self.payContentLabel.frame = CGRectMake(self.positionContentLabel.x, self.payTitleLabel.y, self.positionContentLabel.width, 20 *Scale_Height);

    }

    {

        self.occupationTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@"期望工种"
                                                      font:UIFont_14
                                                 textColor:TextBlackColor
                                             textAlignment:NSTextAlignmentLeft
                                                       tag:100];
        [self.expendBackView addSubview:self.occupationTitleLabel];
        [self.occupationTitleLabel sizeToFit];
        self.occupationTitleLabel.frame = CGRectMake(self.positionTitleLabel.x, self.payTitleLabel.y + self.payTitleLabel.height + 10 *Scale_Height, self.occupationTitleLabel.width, 20 *Scale_Height);

        self.occupationContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                   labelType:kLabelNormal
                                                        text:@""
                                                        font:UIFont_14
                                                   textColor:TextGrayColor
                                               textAlignment:NSTextAlignmentLeft
                                                         tag:101];
        [self.expendBackView addSubview:self.occupationContentLabel];
        self.occupationContentLabel.frame = CGRectMake(self.positionContentLabel.x, self.occupationTitleLabel.y, self.positionContentLabel.width, 20 *Scale_Height);

    }

    {

        self.typeTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                        labelType:kLabelNormal
                                                             text:@"工作类型"
                                                             font:UIFont_14
                                                        textColor:TextBlackColor
                                                    textAlignment:NSTextAlignmentLeft
                                                              tag:100];
        [self.expendBackView addSubview:self.typeTitleLabel];
        [self.typeTitleLabel sizeToFit];
        self.typeTitleLabel.frame = CGRectMake(self.positionTitleLabel.x, self.occupationTitleLabel.y + self.occupationTitleLabel.height + 10 *Scale_Height, self.typeTitleLabel.width, 20 *Scale_Height);

        self.typeContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                          labelType:kLabelNormal
                                                               text:@""
                                                               font:UIFont_14
                                                          textColor:TextGrayColor
                                                      textAlignment:NSTextAlignmentLeft
                                                                tag:101];
        [self.expendBackView addSubview:self.typeContentLabel];
        self.typeContentLabel.frame = CGRectMake(self.positionContentLabel.x, self.typeTitleLabel.y, self.positionContentLabel.width, 20 *Scale_Height);

    }

    {

        self.addressTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                        labelType:kLabelNormal
                                                             text:@"工作地点"
                                                             font:UIFont_14
                                                        textColor:TextBlackColor
                                                    textAlignment:NSTextAlignmentLeft
                                                              tag:100];
        [self.expendBackView addSubview:self.addressTitleLabel];
        [self.addressTitleLabel sizeToFit];
        self.addressTitleLabel.frame = CGRectMake(self.positionTitleLabel.x, self.typeTitleLabel.y + self.typeTitleLabel.height + 10 *Scale_Height, self.addressTitleLabel.width, 20 *Scale_Height);

        self.addressContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                          labelType:kLabelNormal
                                                               text:@""
                                                               font:UIFont_14
                                                          textColor:TextGrayColor
                                                      textAlignment:NSTextAlignmentLeft
                                                                tag:101];
        [self.expendBackView addSubview:self.addressContentLabel];
        self.addressContentLabel.frame = CGRectMake(self.positionContentLabel.x, self.addressTitleLabel.y, self.positionContentLabel.width, 20 *Scale_Height);

    }

}

- (void)changeState {

    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kCreateCVJobIntensionCellNoDataType) {

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

    CreateCVUserInfoData *model = self.dataAdapter.data;

    if (model.skillPost.length > 0) {

        self.positionContentLabel.text = model.skillPost;

    } else {

        self.positionContentLabel.text = @"";

    }

    if (model.hopeSalaryName.length > 0) {

        self.payContentLabel.text = model.hopeSalaryName;

    } else {

        self.payContentLabel.text = @"";

    }

    if (model.workTypeName.length > 0) {

        self.occupationContentLabel.text = model.workTypeName;

    } else {

        self.occupationContentLabel.text = @"";

    }

    if (model.workNatureName.length > 0) {

        self.typeContentLabel.text = model.workNatureName;

    } else {

        self.typeContentLabel.text = @"";

    }

    if (model.workAddress.length > 0) {

        self.addressContentLabel.text = model.workAddress;

    } else {

        self.addressContentLabel.text = @"";

    }

    [self changeState];

}

- (void)selectedEvent {


}

+ (CGFloat)cellHeightWithData:(id)data {

    CreateCVUserInfoData *model = data;

    if (model) {

        // Expend string height.
        model.normalStringHeight = 160 *Scale_Height;

        // One line height.
        model.noDataStringHeight = 70 *Scale_Height;
    }

    return 0.f;
}

@end
