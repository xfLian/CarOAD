//
//  CommunityVideoCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityVideoCell.h"

#import "VideoListData.h"

#define Text_Back_Height  50 *Scale_Height
#define Image_One_Height  (self.width - 24 *Scale_Width) / 3 *2
#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface CommunityVideoCell()

@property (nonatomic, strong) UIView  *contentBackView;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView      *playerBackView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIImageView *playImageView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *carTypeLabel;
@property (nonatomic, strong) UILabel *praiseNumberLabel;
@property (nonatomic, strong) UILabel *answerNumberLabel;

@property (nonatomic, strong) UIView *h_lineView;
@property (nonatomic, strong) UIView *v_lineView;

@end

@implementation CommunityVideoCell

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

    self.iconImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode  = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    [self.contentBackView addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"contact_off_gray"];
    self.iconImageView.backgroundColor = BackGrayColor;

    self.nameLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:101];
    [self.contentBackView addSubview:self.nameLabel];

    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:102];
    [self.contentBackView addSubview:self.dateLabel];

    self.playerBackView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.playerBackView.backgroundColor = [UIColor whiteColor];
    [self.contentBackView addSubview:self.playerBackView];
    
    self.videoImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.videoImageView.contentMode  = UIViewContentModeScaleAspectFill;
    [self.playerBackView addSubview:self.videoImageView];
    self.videoImageView.image = [UIImage imageNamed:@"logo_back_image_big"];
    self.videoImageView.backgroundColor = BackGrayColor;
    
    self.playImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.playImageView.contentMode  = UIViewContentModeScaleAspectFit;
    [self.playerBackView addSubview:self.playImageView];
    self.playImageView.image = [UIImage imageNamed:@"play_button_full"];

    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_17
                                            textColor:[UIColor whiteColor]
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.playerBackView addSubview:self.contentLabel];

    self.carTypeLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_14
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentCenter
                                                  tag:103];
    [self.contentBackView addSubview:self.carTypeLabel];
    
    self.praiseNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentRight
                                                       tag:104];
    [self.contentBackView addSubview:self.praiseNumberLabel];
    
    self.answerNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@""
                                                      font:UIFont_14
                                                 textColor:TextGrayColor
                                             textAlignment:NSTextAlignmentRight
                                                       tag:104];
    [self.contentBackView addSubview:self.answerNumberLabel];
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = TextGrayColor;
    [self.contentBackView addSubview:self.v_lineView];
    
}

- (void) layoutSubviews {

    self.contentBackView.frame = CGRectMake(0, 10 *Scale_Height, Screen_Width, self.contentView.height - 10 *Scale_Height);

    self.iconImageView.frame = CGRectMake(12 *Scale_Width, 12 *Scale_Height, 30 *Scale_Height, 30 *Scale_Height);

    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2;

    [self.nameLabel sizeToFit];

    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y, self.nameLabel.width, self.iconImageView.height);

    [self.dateLabel sizeToFit];

    self.dateLabel.frame = CGRectMake(self.width - self.dateLabel.width - 12 *Scale_Width, self.iconImageView.y, self.dateLabel.width, self.iconImageView.height);

    self.playerBackView.frame  = CGRectMake(0, 54 *Scale_Height, self.width, self.width *9 / 16);
    self.videoImageView.frame  = self.playerBackView.bounds;
    
    self.playImageView.frame  = CGRectMake((self.playerBackView.width - 50 *Scale_Width) / 2, (self.playerBackView.height - 50 *Scale_Width) / 2, 50 *Scale_Width, 50 *Scale_Width);

    if (self.contentLabel.text.length > 0) {

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_16, NSParagraphStyleAttributeName:style};

        CGFloat labelHeight = [self.contentLabel.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];
        
        if (labelHeight > 66 *Scale_Height) {
            
            labelHeight = 66 *Scale_Height;
            
        }
        
        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 10 *Scale_Height, self.width - 24 *Scale_Width, labelHeight);
        
    } else {
        
        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 0, self.width - 24 *Scale_Width, 0);
        
    }

    [self.answerNumberLabel sizeToFit];
    self.answerNumberLabel.frame = CGRectMake(self.width - self.answerNumberLabel.width - 12 *Scale_Width, self.playerBackView.y + self.playerBackView.height + 10 *Scale_Height, self.answerNumberLabel.width, 20 *Scale_Height);
    
    [self.praiseNumberLabel sizeToFit];
    self.praiseNumberLabel.frame = CGRectMake(self.answerNumberLabel.x - self.praiseNumberLabel.width - 10 *Scale_Width, self.answerNumberLabel.y, self.praiseNumberLabel.width, 20 *Scale_Height);
    
    self.v_lineView.frame = CGRectMake(self.answerNumberLabel.x - 6 *Scale_Width, self.answerNumberLabel.y + 2 *Scale_Height, 1.f, 16 *Scale_Height);
    
    [self.carTypeLabel sizeToFit];
    self.carTypeLabel.frame = CGRectMake(12 *Scale_Width, self.answerNumberLabel.y, self.carTypeLabel.width + 10 *Scale_Width, 20 *Scale_Height);
    self.carTypeLabel.layer.masksToBounds = YES;
    self.carTypeLabel.layer.borderWidth   = 0.7f;
    self.carTypeLabel.layer.borderColor   = TextGrayColor.CGColor;
    self.carTypeLabel.layer.cornerRadius  = 3.f *Scale_Width;

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

    if (model.createrImg.length > 0) {

        NSString *downloudImageUrlStr = model.createrImg;

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

    if (model.createrName.length > 0) {

        self.nameLabel.text = model.createrName;

    } else {

        self.nameLabel.text = @"";
        
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [formatter dateFromString:model.createDate];
    [formatter setDateFormat:@"MM-dd"];
    
    NSString *dateString = [formatter stringFromDate:date];

    if (dateString.length > 0) {

        self.dateLabel.text = dateString;

    } else {

        self.dateLabel.text = @"";

    }

    if (model.commentNum.length > 0) {

        self.answerNumberLabel.text = [NSString stringWithFormat:@"%@条评论",model.commentNum];

    } else {

        self.answerNumberLabel.text = @"0条评论";

    }
    
    if (model.likeNum.length > 0) {
        
        self.praiseNumberLabel.text = [NSString stringWithFormat:@"%@个赞",model.likeNum];
        
    } else {
        
        self.praiseNumberLabel.text = @"0个赞";
        
    }

    if (model.carBrand.length > 0) {

        self.carTypeLabel.text = model.carBrand;
        self.carTypeLabel.hidden = NO;

    } else {

        self.carTypeLabel.text = @"";
        self.carTypeLabel.hidden = YES;

    }

}

@end
