//
//  QADetailsCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QADetailsCell.h"

#import "QuestionAndAnswerModel.h"

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface QADetailsCell()

@property (nonatomic, strong) UIView *imageBackView;
@property (nonatomic, strong) UIView *otherBackView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) NSMutableArray *imageViewArray;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *carTypeLabel;

@property (nonatomic, strong) UILabel *answerNumberLabel;

@property (nonatomic, strong) UIButton *button;

@end

@implementation QADetailsCell

- (NSMutableArray *)imageViewArray {
    
    if (!_imageViewArray) {
        
        _imageViewArray = [[NSMutableArray alloc] init];
        
    }
    
    return _imageViewArray;
    
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubViews];
        
    }
    
    return self;
    
}

- (void) initSubViews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.iconImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:101];
    [self.contentView addSubview:self.nameLabel];
    
    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:102];
    [self.contentView addSubview:self.dateLabel];
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_15
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.imageBackView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.imageBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.imageBackView];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode  = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.imageBackView addSubview:imageView];
        [self.imageViewArray addObject:imageView];

        UIButton *button = [UIButton createButtonWithFrame:imageView.bounds
                                                     title:nil
                                           backgroundImage:nil
                                                       tag:2000 + i
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [self.imageBackView addSubview:button];

    }
    
    self.otherBackView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.otherBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.otherBackView];
    
    self.carTypeLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_14
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentCenter
                                                  tag:103];
    [self.otherBackView addSubview:self.carTypeLabel];
    
    self.answerNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentRight
                                                       tag:104];
    [self.otherBackView addSubview:self.answerNumberLabel];
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                            buttonType:kButtonSize
                                                 title:nil
                                                 image:[UIImage imageNamed:@"点赞灰"]
                                              higImage:[UIImage imageNamed:@"点赞蓝"]
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [self.otherBackView addSubview:button];
    self.button = button;
    
}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        if (sender.selected == NO) {

            [_delegate clickDetailsLikeButton];

        }

    } else {

        QuestionAndAnswerModel *model = self.data;
        [_delegate clickChankImageWithImageArray:model.imageArray tag:sender.tag];
        
    }

}

- (void) layoutSubviews {
    
    self.iconImageView.frame = CGRectMake(12 *Scale_Width, 10 *Scale_Height, 40 *Scale_Height, 40 *Scale_Height);
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2;
    
    [self.dateLabel sizeToFit];
    
    self.dateLabel.frame = CGRectMake(self.width - self.dateLabel.width - 12 *Scale_Width, self.iconImageView.y, self.dateLabel.width, self.iconImageView.height);
    
    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y, self.dateLabel.x - (self.iconImageView.x + self.iconImageView.width + 15 *Scale_Width), self.iconImageView.height);
    
    if (self.contentLabel.text.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        
        CGFloat labelHeight = [self.contentLabel.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];
        
        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 60 *Scale_Height, self.width - 24 *Scale_Width, labelHeight);
        
    } else {
        
        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 50 *Scale_Height, self.width - 24 *Scale_Width, 0);
        
    }
    
    QuestionAndAnswerModel *model = self.data;
    
    if (model.imageArray.count > 0) {
        
        self.imageBackView.frame = CGRectMake(12 *Scale_Width, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, self.width - 24 *Scale_Width, Image_More_Height);
        
        for (int i = 0; i < model.imageArray.count; i++) {
            
            UIImageView *imageView = self.imageViewArray[i];
            
            imageView.frame = CGRectMake(i *((self.width - 44 *Scale_Width) / 3 + 10 *Scale_Width), 0, (self.width - 44 *Scale_Width) / 3, self.imageBackView.height);

            for (UIView *view in self.imageBackView.subviews) {

                if ([view isKindOfClass:[UIButton class]] && view.tag - 2000 == i) {

                    view.frame = imageView.frame;

                }

            }
            
        }
        
    } else {
        
        self.imageBackView.frame = CGRectMake(12 *Scale_Width, self.contentLabel.y + self.contentLabel.height, self.width - 24 *Scale_Width, 0);
        
    }
    
    self.otherBackView.frame = CGRectMake(12 *Scale_Width, self.imageBackView.y + self.imageBackView.height + 10 *Scale_Height, self.width - 24 *Scale_Width, 40 *Scale_Height);
    
    [self.carTypeLabel sizeToFit];
    
    self.carTypeLabel.frame = CGRectMake(0, 10 *Scale_Height, self.carTypeLabel.width + 10 *Scale_Width, 20 *Scale_Height);
    self.carTypeLabel.layer.masksToBounds = YES;
    self.carTypeLabel.layer.borderWidth   = 0.7f;
    self.carTypeLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.carTypeLabel.layer.cornerRadius  = 3.f *Scale_Width;
    
    self.button.frame = CGRectMake(self.otherBackView.width - 24 *Scale_Width, 6 *Scale_Height, 24 *Scale_Height, 24 *Scale_Height);
    
    [self.answerNumberLabel sizeToFit];
        
    self.answerNumberLabel.frame = CGRectMake(self.otherBackView.width - self.button.width - self.answerNumberLabel.width - 5 *Scale_Width, 10 *Scale_Height, self.answerNumberLabel.width, 20 *Scale_Height);
    
}

- (void) loadContent {
    
    QuestionAndAnswerModel *model = self.data;
    
    if (model.text.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        [style setFirstLineHeadIndent:5];
        [style setHeadIndent:5];
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        
        NSAttributedString *attrStr =[[NSAttributedString alloc] initWithString:model.text attributes:attribute];
        
        self.contentLabel.attributedText = attrStr;
        
    } else {

        self.contentLabel.text = @"";

    }

    if (model.imageArray.count > 0) {
        
        for (int i = 0; i < model.imageArray.count; i++) {
            
            if (i < 3) {
                
                UIImageView *imageView = self.imageViewArray[i];
                
                NSString *downloudImageUrlStr = model.imageArray[i];
                NSURL    *downloudImageUrl    = [NSURL URLWithString:downloudImageUrlStr];
                
                //  下载图片
                [QTDownloadWebImage downloadImageForImageView:imageView
                                                     imageUrl:downloudImageUrl
                                             placeholderImage:@"logo_back_image_small"
                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                         
                                                     }
                                                      success:^(UIImage *finishImage) {
                                                          
                                                      }];
                
            }
            
        }
        
    }
    
    if (model.iconImageString.length > 0) {
        
        NSString *downloudImageUrlStr = model.iconImageString;
        NSURL    *downloudImageUrl    = [NSURL URLWithString:downloudImageUrlStr];
        
        //  下载图片
        [QTDownloadWebImage downloadImageForImageView:self.iconImageView
                                             imageUrl:downloudImageUrl
                                     placeholderImage:@"contact_off_gray"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } else {
        
        self.iconImageView.image = [UIImage imageNamed:@"contact_off_gray"];
        
    }
    
    if (model.name.length > 0) {

        self.nameLabel.text = model.name;

    } else {

        self.nameLabel.text = @"";

    }
    
    if (model.date.length > 0) {
        
        self.dateLabel.text = model.date;

    } else {

        self.dateLabel.text = @"";

    }

    if (model.carType.length > 0) {

        self.carTypeLabel.text = model.carType;
        self.carTypeLabel.hidden = NO;
    } else {

        self.carTypeLabel.text = @"";
        self.carTypeLabel.hidden = YES;

    }

    if ([model.isLike isEqualToString:@"1"]) {

        self.button.selected = YES;

        if (model.totalLikeNum.length > 0) {

            self.answerNumberLabel.text = model.totalLikeNum;

        } else {

            self.answerNumberLabel.text = @"";

        }

    } else {

        BOOL isLike = [[PreserveLikeData initPreserveLikeData] isLikeThisDetailsWithType:@"1" detailsId:model.qAId];

        if (isLike == YES) {

            self.button.selected = YES;

            NSInteger totalLikeNum = [model.totalLikeNum integerValue];
            totalLikeNum ++;
            self.answerNumberLabel.text = [NSString stringWithFormat:@"%ld",totalLikeNum];

        } else {

            self.button.selected = NO;

            if (model.totalLikeNum.length > 0) {

                self.answerNumberLabel.text = model.totalLikeNum;

            } else {

                self.answerNumberLabel.text = @"0";

            }

        }

    }
    
}

@end
