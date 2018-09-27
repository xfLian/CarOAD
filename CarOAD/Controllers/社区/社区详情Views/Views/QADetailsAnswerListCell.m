//
//  QADetailsAnswerListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QADetailsAnswerListCell.h"

#import "DetailsCommunityViewModel.h"

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface QADetailsAnswerListCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *answerNumberLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UIView      *otherBackView;
@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIView      *answerBackView;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *answerLabel;
@property (nonatomic, strong) UIView      *v_lineView;

@end

@implementation QADetailsAnswerListCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.iconImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode  = UIViewContentModeScaleAspectFit;
    self.iconImageView.backgroundColor = BackGrayColor;
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:101];
    [self.contentView addSubview:self.nameLabel];
    
    self.answerLabel = [UILabel createLabelWithFrame:CGRectZero
                                           labelType:kLabelNormal
                                                text:@""
                                                font:UIFont_14
                                           textColor:TextGrayColor
                                       textAlignment:NSTextAlignmentRight
                                                 tag:103];
    [self.contentView addSubview:self.answerLabel];
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                            buttonType:kButtonSize
                                                 title:nil
                                                 image:[UIImage imageNamed:@"点赞灰"]
                                              higImage:[UIImage imageNamed:@"点赞蓝"]
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [self.contentView addSubview:button];
    self.button = button;
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_15
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.bigImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bigImageView.contentMode  = UIViewContentModeScaleAspectFill;
    self.bigImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.bigImageView];
    self.bigImageView.image = [UIImage imageNamed:@"照片"];
    
    self.otherBackView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.otherBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.otherBackView];
    
    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:102];
    [self.otherBackView addSubview:self.dateLabel];
    
    self.answerNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:[UIColor whiteColor]
                                             textAlignment:NSTextAlignmentCenter
                                                       tag:104];
    self.answerNumberLabel.backgroundColor = TextGrayColor;
    [self.otherBackView addSubview:self.answerNumberLabel];
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = TextGrayColor;
    [self.contentView addSubview:self.v_lineView];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    [self.delegate clickDetailsListLikeButtonForData:self.data];
    
}

- (void) layoutSubviews {
    
    self.iconImageView.frame               = CGRectMake(12 *Scale_Width, 10 *Scale_Height, 30 *Scale_Height, 30 *Scale_Height);
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2;
    
    [self.answerLabel sizeToFit];
    
    self.answerLabel.frame = CGRectMake(self.width - 41 *Scale_Width - self.answerLabel.width, 15 *Scale_Height, self.answerLabel.width, 20 *Scale_Height);
    self.button.frame = CGRectMake(self.width - 36 *Scale_Width, 11 *Scale_Height, 24 *Scale_Height, 24 *Scale_Height);
    
    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, 15 *Scale_Height, self.answerLabel.x - (self.iconImageView.x + self.iconImageView.width + 15 *Scale_Width), 20 *Scale_Height);
    
    if (self.contentLabel.text.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        
        CGFloat labelHeight = [self.contentLabel.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 64 *Scale_Width - 10];
        
        if (labelHeight > 66 *Scale_Height) {
            
            labelHeight = 66 *Scale_Height;
            
        }
        
        self.contentLabel.frame = CGRectMake(self.nameLabel.x, 50 *Scale_Height, self.width - 64 *Scale_Width, labelHeight);
        
    } else {
        
        self.contentLabel.frame = CGRectMake(self.nameLabel.x, 40 *Scale_Height, self.width - 64 *Scale_Width, 0);
        
    }
    
    DetailsCommunityViewModel *model = self.data;
    
    if (model.reImgURL.length > 0) {
        
        self.bigImageView.frame = CGRectMake(self.contentLabel.x, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, Image_More_Height, Image_More_Height);
        
    } else {
        
        self.bigImageView.frame = CGRectMake(self.contentLabel.x, self.contentLabel.y + self.contentLabel.height, Image_More_Height, 0);
        
    }
    
    self.otherBackView.frame = CGRectMake(self.nameLabel.x, self.bigImageView.y + self.bigImageView.height, self.width - self.nameLabel.x - 12 *Scale_Width, 40 *Scale_Height);
    
    [self.dateLabel sizeToFit];
    
    self.dateLabel.frame = CGRectMake(0, 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    [self.answerNumberLabel sizeToFit];
    
    self.answerNumberLabel.frame = CGRectMake(self.otherBackView.width - self.answerNumberLabel.width - 14 *Scale_Width, 10 *Scale_Height, self.answerNumberLabel.width + 14 *Scale_Width, 20 *Scale_Height);
    self.answerNumberLabel.layer.masksToBounds = YES;
    self.answerNumberLabel.layer.cornerRadius  = self.answerNumberLabel.height / 2;
        
    self.v_lineView.frame = CGRectMake(12 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 24 *Scale_Width, 0.5f);
    
}

- (void) loadContent {
    
    DetailsCommunityViewModel *model = self.data;

    if (model.ansContent.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        
        NSAttributedString *attrStr =[[NSAttributedString alloc] initWithString:model.ansContent attributes:attribute];
        
        self.contentLabel.attributedText = attrStr;

    } else {

        self.contentLabel.text = @"";

    }

    if (model.ansCreaterImg.length > 0) {
        
        NSString *downloudImageUrlStr = model.ansCreaterImg;
        
        NSURL    *downloudImageUrl    = [NSURL URLWithString:downloudImageUrlStr];
        
        //  下载图片
        [QTDownloadWebImage downloadImageForImageView:self.iconImageView
                                             imageUrl:downloudImageUrl
                                     placeholderImage:@"contact_off_gray"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } 
    
    CarOadLog(@"reImgURL --- %@",model.reImgURL);
    NSArray *array = [model.reImgURL componentsSeparatedByString:@","];
    
    if (array.count > 0) {
        
        NSString *downloudImageUrlStr = array[0];
        NSURL    *downloudImageUrl    = [NSURL URLWithString:downloudImageUrlStr];
                
        //  下载图片
        [QTDownloadWebImage downloadImageForImageView:self.bigImageView
                                             imageUrl:downloudImageUrl
                                     placeholderImage:@"logo_back_image_small"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    }
    
    if (model.ansCreaterName.length > 0) {
        
        self.nameLabel.text = model.ansCreaterName;
        
    } else {
        
        self.nameLabel.text = @"";
        
    }
    
    if (model.ansCreateDate.length > 0) {
        
        self.dateLabel.text = model.ansCreateDate;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    if (model.ansNum.length > 0) {
        
        self.answerNumberLabel.text = [NSString stringWithFormat:@"%@ 回复",model.ansNum];
        
    } else {
        
        self.answerNumberLabel.text = @"0 回复";
        
    }

    if ([model.isLike isEqualToString:@"1"]) {

        self.button.selected = YES;

    } else {

        NSString *type = nil;

        if ([model.type isEqualToString:@"问答"]) {

            type = @"1";

        } else if ([model.type isEqualToString:@"视频"]) {

            type = @"2";

        } else if ([model.type isEqualToString:@"文章"]) {

            type = @"3";

        } else if ([model.type isEqualToString:@"资讯"]) {

            type = @"4";

        } else if ([model.type isEqualToString:@"新闻"]) {

            type = @"5";

        }

        BOOL isLike = [[PreserveLikeData initPreserveLikeData] isLikeThisCommunityWithType:type detailsId:model.typeId communityId:model.answerId];

        if (isLike == YES) {

            self.button.selected = YES;

        } else {

            self.button.selected = NO;

        }

    }
    
}

@end
