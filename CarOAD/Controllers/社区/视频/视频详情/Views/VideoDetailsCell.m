//
//  VideoDetailsCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "VideoDetailsCell.h"

#import "VideoListData.h"

#define Text_Back_Height 50 *Scale_Height

#define Image_One_Height (self.width - 24 *Scale_Width) / 3 *2

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface VideoDetailsCell()

@property (nonatomic, strong) UIView  *contentBackView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *carTypeLabel;
@property (nonatomic, strong) UILabel *answerNumberLabel;

@property (nonatomic, strong) UIButton *button;

@end

@implementation VideoDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    if (self) {

        [self initSubViews];

    }

    return self;

}

- (void) initSubViews {

    self.contentView.backgroundColor = BackGrayColor;

    self.contentBackView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.contentBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.contentBackView];

    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_16
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.contentBackView addSubview:self.contentLabel];

    self.carTypeLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_14
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentCenter
                                                  tag:103];
    [self.contentBackView addSubview:self.carTypeLabel];

    self.answerNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentRight
                                                       tag:104];
    [self.contentBackView addSubview:self.answerNumberLabel];

    UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                            buttonType:kButtonSize
                                                 title:nil
                                                 image:[UIImage imageNamed:@"点赞灰"]
                                              higImage:[UIImage imageNamed:@"点赞蓝"]
                                                   tag:2000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [self.contentBackView addSubview:button];
    self.button = button;

}

- (void) layoutSubviews {

    self.contentBackView.frame = CGRectMake(0, 0, Screen_Width, self.contentView.height);

    if (self.contentLabel.text.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_16, NSParagraphStyleAttributeName:style};

        CGFloat labelHeight = [self.contentLabel.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];

        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 0, self.width - 24 *Scale_Width, labelHeight);

    } else {

        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 0, self.width - 24 *Scale_Width, 0);

    }

    [self.carTypeLabel sizeToFit];

    self.carTypeLabel.frame = CGRectMake(12 *Scale_Width, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, self.carTypeLabel.width + 10 *Scale_Width, 20 *Scale_Height);
    self.carTypeLabel.layer.masksToBounds = YES;
    self.carTypeLabel.layer.borderWidth   = 0.7f;
    self.carTypeLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.carTypeLabel.layer.cornerRadius  = 3.f *Scale_Width;

    self.button.frame = CGRectMake(self.width - 36 *Scale_Width, self.contentLabel.y + self.contentLabel.height + 6 *Scale_Height, 24 *Scale_Height, 24 *Scale_Height);

    [self.answerNumberLabel sizeToFit];

    self.answerNumberLabel.frame = CGRectMake(self.width - self.button.width - self.answerNumberLabel.width - 17 *Scale_Width, self.button.y + 4 *Scale_Height, self.answerNumberLabel.width, 20 *Scale_Height);

}

- (void) loadContent {

    VideoListData *model = self.data;

    if (model.title.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_16, NSParagraphStyleAttributeName:style};

        NSAttributedString *attrStr =[[NSAttributedString alloc] initWithString:model.title attributes:attribute];

        self.contentLabel.attributedText = attrStr;

    } else {

        self.contentLabel.text = @"";

    }

    if (model.commentNum.length > 0) {

        self.answerNumberLabel.text = [NSString stringWithFormat:@"%@个评论",model.commentNum];

    } else {

        self.answerNumberLabel.text = @"";

    }

    if (model.carBrand.length > 0) {

        self.carTypeLabel.text = model.carBrand;

    } else {

        self.carTypeLabel.text = @"";

    }

    if ([model.isLike isEqualToString:@"1"]) {

        self.button.selected = YES;

        if (model.likeNum.length > 0) {

            self.answerNumberLabel.text = model.likeNum;

        } else {

            self.answerNumberLabel.text = @"";

        }

    } else {

        BOOL isLike = [[PreserveLikeData initPreserveLikeData] isLikeThisDetailsWithType:@"2" detailsId:model.videoId];

        if (isLike == YES) {

            self.button.selected = YES;

            NSInteger totalLikeNum = [model.likeNum integerValue];
            totalLikeNum ++;
            self.answerNumberLabel.text = [NSString stringWithFormat:@"%ld",totalLikeNum];

        } else {

            if (model.likeNum.length > 0) {

                self.answerNumberLabel.text = model.likeNum;

            } else {

                self.answerNumberLabel.text = @"0";

            }

        }

    }

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.selected == NO) {

        [_delegate clickDetailsLikeButton];

    }

}

@end
