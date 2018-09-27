//
//  CommunityArticleCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityArticleCell.h"

#import "ArticleListData.h"

#define Text_Back_Height 50 *Scale_Height

#define Image_One_Height (self.width - 24 *Scale_Width) *3 / 8

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface CommunityArticleCell()

@property (nonatomic, strong) UIView *otherBackView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *praiseNumberLabel;
@property (nonatomic, strong) UILabel *answerNumberLabel;

@property (nonatomic, strong) UIView *h_lineView;
@property (nonatomic, strong) UIView *v_lineView;

@end

@implementation CommunityArticleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    if (self) {

        [self initSubViews];

    }

    return self;

}

- (void) initSubViews {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.iconImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode  = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"contact_off_gray"];
    self.iconImageView.backgroundColor = BackGrayColor;
    
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

    self.bigImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bigImageView.contentMode  = UIViewContentModeScaleAspectFill;
    self.bigImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.bigImageView];
    self.bigImageView.image = [UIImage imageNamed:@"logo_back_image_big"];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_20
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];

    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_16
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];

    self.otherBackView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.otherBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.otherBackView];

    self.typeLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_14
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentCenter
                                                  tag:103];
    [self.otherBackView addSubview:self.typeLabel];

    self.praiseNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentRight
                                                       tag:104];
    [self.otherBackView addSubview:self.praiseNumberLabel];

    self.answerNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentRight
                                                       tag:104];
    [self.otherBackView addSubview:self.answerNumberLabel];

    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = TextGrayColor;
    [self.otherBackView addSubview:self.v_lineView];

    self.h_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.h_lineView];

}

- (void) layoutSubviews {

    self.iconImageView.frame = CGRectMake(12 *Scale_Width, 15 *Scale_Height, 30 *Scale_Height, 30 *Scale_Height);
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2;

    [self.nameLabel sizeToFit];

    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y, self.nameLabel.width, self.iconImageView.height);
    
    [self.dateLabel sizeToFit];

    self.dateLabel.frame = CGRectMake(self.width - self.dateLabel.width - 12 *Scale_Width, self.iconImageView.y, self.dateLabel.width, self.iconImageView.height);

    ArticleListData *model = self.data;

    if (model.artCoverImg.length > 0) {

        self.bigImageView.frame = CGRectMake(12 *Scale_Width, self.iconImageView.y + self.iconImageView.height + 15 *Scale_Height, self.width - 24 *Scale_Width, Image_One_Height);

    } else {

        self.bigImageView.frame = CGRectMake(12 *Scale_Width, self.iconImageView.y + self.iconImageView.height, self.width - 24 *Scale_Width, 0);

    }

    if (self.titleLabel.text.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 10;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_20, NSParagraphStyleAttributeName:style};

        CGFloat labelHeight = [self.titleLabel.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];

        if (labelHeight > 66 *Scale_Height) {

            labelHeight = 66 *Scale_Height;

        }

        self.titleLabel.frame = CGRectMake(12 *Scale_Width, self.bigImageView.y + self.bigImageView.height + 15 *Scale_Height, self.width - 24 *Scale_Width, labelHeight);

    } else {

        self.titleLabel.frame = CGRectMake(12 *Scale_Width, self.bigImageView.y + self.bigImageView.height, self.width - 24 *Scale_Width, 0);

    }


    if (self.contentLabel.text.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 6;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_16, NSParagraphStyleAttributeName:style};

        CGFloat labelHeight = [self.contentLabel.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];

        if (labelHeight > 50 *Scale_Height) {

            labelHeight = 50 *Scale_Height;

        }

        self.contentLabel.frame = CGRectMake(12 *Scale_Width, self.titleLabel.y + self.titleLabel.height + 15 *Scale_Height, self.width - 24 *Scale_Width, labelHeight);

    } else {

        self.contentLabel.frame = CGRectMake(12 *Scale_Width, self.titleLabel.y + self.titleLabel.height, self.width - 24 *Scale_Width, 0);

    }

    self.otherBackView.frame = CGRectMake(12 *Scale_Width, self.contentLabel.y + self.contentLabel.height, self.width - 24 *Scale_Width, 50 *Scale_Height);

    [self.answerNumberLabel sizeToFit];

    self.answerNumberLabel.frame = CGRectMake(self.otherBackView.width - self.answerNumberLabel.width, 15 *Scale_Height, self.answerNumberLabel.width, 20 *Scale_Height);

    [self.praiseNumberLabel sizeToFit];

    self.praiseNumberLabel.frame = CGRectMake(self.answerNumberLabel.x - self.praiseNumberLabel.width - 10 *Scale_Width, self.answerNumberLabel.y, self.praiseNumberLabel.width, 20 *Scale_Height);

    self.v_lineView.frame = CGRectMake(self.answerNumberLabel.x - 6 *Scale_Width, 17 *Scale_Height, 1.f, 16 *Scale_Height);

    [self.typeLabel sizeToFit];

    self.typeLabel.frame = CGRectMake(0, 15 *Scale_Height, self.typeLabel.width + 10 *Scale_Width, 20 *Scale_Height);
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.layer.borderWidth   = 0.7f;
    self.typeLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.typeLabel.layer.cornerRadius  = 3.f *Scale_Width;

    self.h_lineView.frame = CGRectMake(12 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 24 *Scale_Width, 0.5f);

}

- (void) loadContent {

    ArticleListData *model = self.data;

    if (model.createrImg.length > 0) {

        NSString *downloudImageUrlStr = model.createrImg;

        NSURL    *downloudImageUrl    = [NSURL URLWithString:downloudImageUrlStr];

        //  下载图片
        [QTDownloadWebImage downloadImageForImageView:self.iconImageView
                                             imageUrl:downloudImageUrl
                                     placeholderImage:@"照片"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {

                                             }
                                              success:^(UIImage *finishImage) {

                                              }];


    } else {

        self.iconImageView.image = [UIImage imageNamed:@"照片"];

    }

    if (model.createrName.length > 0) {

        self.nameLabel.text = model.createrName;

    } else {

        self.nameLabel.text = @"";

    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate * date = [formatter dateFromString:model.createDate];
    [formatter setDateFormat:@"MM-dd"];

    NSString *dateString = [formatter stringFromDate:date];

    if (dateString.length > 0) {

        self.dateLabel.text = dateString;

    } else {

        self.dateLabel.text = @"";

    }

    if (model.artCoverImg.length > 0) {

        NSURL *downloudImageUrl = [NSURL URLWithString:model.artCoverImg];

        //  下载图片
        [QTDownloadWebImage downloadImageForImageView:self.bigImageView
                                             imageUrl:downloudImageUrl
                                     placeholderImage:@"照片"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {

                                             }
                                              success:^(UIImage *finishImage) {

                                              }];

    }
    
    if (model.title.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 10;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_20, NSParagraphStyleAttributeName:style};

        NSAttributedString *attrStr =[[NSAttributedString alloc] initWithString:model.title attributes:attribute];

        self.titleLabel.attributedText = attrStr;

    } else {

        self.titleLabel.text = @"";

    }

    if (model.articleInfo.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 6;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_16, NSParagraphStyleAttributeName:style};

        NSAttributedString *attrStr =[[NSAttributedString alloc] initWithString:model.articleInfo attributes:attribute];

        self.contentLabel.attributedText = attrStr;

    } else {

        self.contentLabel.text = @"";

    }

    if (model.commentNum.length > 0) {

        self.answerNumberLabel.text = [NSString stringWithFormat:@"%@条评论",model.commentNum];

    } else {

        self.answerNumberLabel.text = @"%@条评论";

    }

    if (model.likeNum.length > 0) {

        self.praiseNumberLabel.text = [NSString stringWithFormat:@"%@个赞",model.likeNum];

    } else {

        self.praiseNumberLabel.text = @"0个赞";

    }

    if (model.tag.length > 0) {

        self.typeLabel.text = model.tag;

    } else {

        self.typeLabel.text = @"";

    }

}

@end
