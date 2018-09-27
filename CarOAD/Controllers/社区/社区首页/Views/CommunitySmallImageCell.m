//
//  CommunitySmallImageCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunitySmallImageCell.h"

#import "ArticleListData.h"

#define Text_Back_Height 50 *Scale_Height

#define Image_One_Height (self.width - 24 *Scale_Width) / 3 *2

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface CommunitySmallImageCell()

@property (nonatomic, strong) UIView *otherBackView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *smallImageView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *carTypeLabel;

@property (nonatomic, strong) UILabel *answerNumberLabel;

@property (nonatomic, strong) UIView *h_lineView;
@property (nonatomic, strong) UIView *v_lineView;

@end

@implementation CommunitySmallImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubViews];
        
    }
    
    return self;
    
}

- (void) initSubViews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_20
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.smallImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.smallImageView.contentMode  = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.smallImageView];
    self.smallImageView.backgroundColor = BackGrayColor;
    
    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:102];
    [self.contentView addSubview:self.dateLabel];
    
    self.answerNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentRight
                                                       tag:104];
    [self.contentView addSubview:self.answerNumberLabel];
    
    self.h_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.h_lineView];
    
}

- (void) layoutSubviews {
    
    if (self.contentLabel.text.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 5;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_17, NSParagraphStyleAttributeName:style};
        
        CGFloat labelHeight = [self.contentLabel.text heightWithStringAttribute:attribute fixedWidth:self.width - 34 *Scale_Width - (self.width - 44 *Scale_Width) / 3];
        
        if (labelHeight > 50 *Scale_Height) {
            
            labelHeight = 50 *Scale_Height;
            
        }
        
        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 12 *Scale_Height, self.width - 34 *Scale_Width - (self.width - 44 *Scale_Width) / 3, labelHeight);
        
    } else {
        
        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 0, self.width - 24 *Scale_Width, 0);
        
    }
    
    self.smallImageView.frame = CGRectMake(self.width - 12 *Scale_Width - (self.width - 44 *Scale_Width) / 3, 20 *Scale_Height, (self.width - 44 *Scale_Width) / 3, Image_More_Height);
    
    [self.dateLabel sizeToFit];
    self.dateLabel.frame = CGRectMake(12 *Scale_Width, self.smallImageView.y + self.smallImageView.height - 15 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
    [self.answerNumberLabel sizeToFit];
    self.answerNumberLabel.frame = CGRectMake(self.smallImageView.x - self.answerNumberLabel.width - 12 *Scale_Width, self.dateLabel.y, self.answerNumberLabel.width, self.dateLabel.height);
    
    self.h_lineView.frame = CGRectMake(12 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 24 *Scale_Width, 0.5f);
    
}

- (void) loadContent {
    
    ArticleListData *model = self.data;

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
        [QTDownloadWebImage downloadImageForImageView:self.smallImageView
                                             imageUrl:downloudImageUrl
                                     placeholderImage:@"logo_back_image_small"
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {

                                             }
                                              success:^(UIImage *finishImage) {

                                              }];

    }

    if (model.articleInfo.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 5;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_17, NSParagraphStyleAttributeName:style};

        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:model.articleInfo attributes:attribute];

        self.contentLabel.attributedText = attrStr;

    } else {

        self.contentLabel.text = @"";

    }

    if (model.commentNum.length > 0) {

        self.answerNumberLabel.text = [NSString stringWithFormat:@"浏览%@次",model.commentNum];

    } else {

        self.answerNumberLabel.text = @"浏览0次";

    }
    
}

@end
