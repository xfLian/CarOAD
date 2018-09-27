//
//  CommunityNotImageCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityNotImageCell.h"

#import "QuestionAndAnswerModel.h"

#define Text_Back_Height 50 *Scale_Height

#define Image_One_Height (self.width - 24 *Scale_Width) / 3 *2

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface CommunityNotImageCell()

@property (nonatomic, strong) UIView *imageBackView;
@property (nonatomic, strong) UIView *otherBackView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *carTypeLabel;

@property (nonatomic, strong) UILabel *answerNumberLabel;

@property (nonatomic, strong) UIView *h_lineView;
@property (nonatomic, strong) UIView *v_lineView;

@end

@implementation CommunityNotImageCell

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
                                                 font:UIFont_15
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.otherBackView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.otherBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.otherBackView];
    
    self.iconImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode  = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    [self.otherBackView addSubview:self.iconImageView];
    self.iconImageView.backgroundColor = BackGrayColor;
    
    self.nameLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:101];
    [self.otherBackView addSubview:self.nameLabel];
    
    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:102];
    [self.otherBackView addSubview:self.dateLabel];
    
    self.carTypeLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_14
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentRight
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
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = TextGrayColor;
    [self.otherBackView addSubview:self.v_lineView];
    
    self.h_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.h_lineView];
    
}

- (void) layoutSubviews {
    
    if (self.contentLabel.text.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        
        CGFloat labelHeight = [self.contentLabel.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];
        
        if (labelHeight > 66 *Scale_Height) {
            
            labelHeight = 66 *Scale_Height;
            
        }
        
        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 10 *Scale_Height, self.width - 24 *Scale_Width, labelHeight);
        
    } else {
        
        self.contentLabel.frame = CGRectMake(12 *Scale_Width, 0, self.width - 24 *Scale_Width, 0);
        
    }
    
    self.otherBackView.frame = CGRectMake(12 *Scale_Width, self.contentLabel.y + self.contentLabel.height, self.width - 24 *Scale_Width, 60 *Scale_Height);
    
    self.iconImageView.frame = CGRectMake(0, (self.otherBackView.height - 30 *Scale_Height) / 2, 30 *Scale_Height, 30 *Scale_Height);
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2;
    
    [self.nameLabel sizeToFit];
    
    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y, self.nameLabel.width, self.iconImageView.height);
    
    [self.dateLabel sizeToFit];
    
    self.dateLabel.frame = CGRectMake(self.nameLabel.x + self.nameLabel.width + 5 *Scale_Width, self.iconImageView.y, self.dateLabel.width, self.iconImageView.height);
    
    [self.answerNumberLabel sizeToFit];
    
    self.answerNumberLabel.frame = CGRectMake(self.otherBackView.width - self.answerNumberLabel.width, self.iconImageView.y, self.answerNumberLabel.width, self.iconImageView.height);
    
    self.v_lineView.frame = CGRectMake(self.answerNumberLabel.x - 6 *Scale_Width, 22 *Scale_Height, 1.f, 16 *Scale_Height);
    
    CGFloat carTypeLabelWidth = self.v_lineView.x - 5 *Scale_Width - (self.dateLabel.x + self.dateLabel.width + 10 *Scale_Width);
    
    self.carTypeLabel.frame = CGRectMake(self.dateLabel.x + self.dateLabel.width + 10 *Scale_Width, self.iconImageView.y, carTypeLabelWidth, self.iconImageView.height);
    
    self.h_lineView.frame = CGRectMake(12 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 24 *Scale_Width, 0.5f);
    
}

- (void) loadContent {
    
    QuestionAndAnswerModel *model = self.data;
    
    if (model.text.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        
        NSAttributedString *attrStr =[[NSAttributedString alloc] initWithString:model.text attributes:attribute];
        
        self.contentLabel.attributedText = attrStr;
        
    } else {
        
        self.contentLabel.text = @"";
        
    }
    
    if (model.iconImageString.length > 0) {
        
        NSString *downloudImageUrlStr = model.iconImageString;
        
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
    
    if (model.name.length > 0) {
        
        self.nameLabel.text = model.name;
        
    } else {
        
        self.nameLabel.text = @"";
        
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date = [formatter dateFromString:model.date];
    [formatter setDateFormat:@"MM-dd"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    if (dateString.length > 0) {
        
        self.dateLabel.text = dateString;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }
    
    if (model.number.length > 0) {
        
        self.answerNumberLabel.text = [NSString stringWithFormat:@"%@个回答",model.number];
        
    } else {
        
        self.answerNumberLabel.text = @"0个回答";
        
    }
    
    if (model.carType.length > 0) {
        
        self.carTypeLabel.text = model.carType;
        self.v_lineView.hidden = NO;

    } else {

        self.carTypeLabel.text = @"";
        self.v_lineView.hidden = YES;

    }
    
}

@end
