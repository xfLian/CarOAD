//
//  CreateCVSkillsCertificateCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CreateCVSkillsCertificateCell.h"

#import "CreateCVSkillsCertificateData.h"

@interface CreateCVSkillsCertificateCell()

@property (nonatomic, strong) UIView  *normalBackView;
@property (nonatomic, strong) UIView  *expendBackView;

@property (nonatomic, strong) UILabel *noDataTitleLabel;
@property (nonatomic, strong) UILabel *noDataContentLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView  *imageBackView;
@property (nonatomic, strong) UIView  *bottom_v_lineView;

@end

@implementation CreateCVSkillsCertificateCell

- (void)setupCell {

    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

}

- (void)buildSubview {

    self.normalBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height)];
    self.normalBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.normalBackView];

    self.expendBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50 *Scale_Height + (Screen_Width - 50 *Scale_Width) / 3)];
    self.expendBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expendBackView];

    {

        self.noDataTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:@"尚未添加技能证书"
                                                         font:UIFont_15
                                                    textColor:TextBlackColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:100];
        [self.normalBackView addSubview:self.noDataTitleLabel];
        [self.noDataTitleLabel sizeToFit];
        self.noDataTitleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.noDataTitleLabel.width, 20 *Scale_Height);

        self.noDataContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@"请添加主要的技能证书"
                                                           font:UIFont_14
                                                      textColor:TextGrayColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:101];
        [self.normalBackView addSubview:self.noDataContentLabel];
        [self.noDataContentLabel sizeToFit];
        self.noDataContentLabel.frame = CGRectMake(15 *Scale_Width, self.noDataTitleLabel.y + self.noDataTitleLabel.height + 10 *Scale_Height, self.noDataContentLabel.width, 20 *Scale_Height);

    }

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

        self.imageBackView                 = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 40 *Scale_Height, Screen_Width - 30 *Scale_Width, (Screen_Width - 50 *Scale_Width) / 3)];
        self.imageBackView.backgroundColor = [UIColor clearColor];
        [self.expendBackView addSubview:self.imageBackView];

    }
    
    self.bottom_v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottom_v_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.bottom_v_lineView];

}

- (void)layoutSubviews {

    self.bottom_v_lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);

}

- (void)changeState {

    TableViewCellDataAdapter *adapter = self.dataAdapter;
    if (adapter.cellType == kCreateCVSkillsCertificateCellNoDataType) {

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

    for (UIView *subView in self.imageBackView.subviews) {

        if (subView) {

            [subView removeFromSuperview];

        }

    }

    CreateCVSkillsCertificateData *model = self.dataAdapter.data;

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
    self.dateLabel.frame = CGRectMake(Screen_Width - 15 *Scale_Width - self.dateLabel.width, 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height,  self.dateLabel.x - 25 *Scale_Width, 20 *Scale_Height);

    if (model.certImg.length > 0) {

        NSArray *imageStringArray = [model.certImg componentsSeparatedByString:@","];
        
        for (int i = 0; i < imageStringArray.count; i++) {
            
            UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(((Screen_Width - 50 *Scale_Width) / 3 + 10 *Scale_Width) *i, 5 *Scale_Height, (Screen_Width - 50 *Scale_Width) / 3 - 10 *Scale_Height, (Screen_Width - 50 *Scale_Width) / 3 - 10 *Scale_Height)];
            imageView.image         = [UIImage imageNamed:@"logo_back_image_small"];
            imageView.contentMode   = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = BackGrayColor;
            [self.imageBackView addSubview:imageView];
            
            NSString *imageString = imageStringArray[i];
            
            if (imageString.length > 0) {
                
                [QTDownloadWebImage downloadImageForImageView:imageView
                                                     imageUrl:[NSURL URLWithString:imageStringArray[i]]
                                             placeholderImage:@"logo_back_image_small"
                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                         
                                                     }
                                                      success:^(UIImage *finishImage) {
                                                          
                                                      }];
                
            } else {
                
                imageView.image = [UIImage imageNamed:@"logo_back_image_small"];
                
            }
            
            UIButton *button = [UIButton createButtonWithFrame:imageView.frame
                                                         title:nil
                                               backgroundImage:nil
                                                           tag:1000 + i
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            [self.imageBackView addSubview:button];

        }

    }

    [self changeState];

}

- (void) buttonEvent:(UIButton *)sender {
    
    CreateCVSkillsCertificateData *model = self.dataAdapter.data;
    NSArray *imageStringArray = [model.certImg componentsSeparatedByString:@","];
    
    [_subCellDelegate clickChankImageWithImageArray:imageStringArray tag:sender.tag];
    
}

- (void)selectedEvent {


}

+ (CGFloat)cellHeightWithData:(id)data {

    CreateCVSkillsCertificateData *model = data;

    if (model) {

        // Expend string height.
        model.normalStringHeight = 50 *Scale_Height + (Screen_Width - 50 *Scale_Width) / 3;

        // One line height.
        model.noDataStringHeight = 70 *Scale_Height;
    }

    return 0.f;
}

@end
