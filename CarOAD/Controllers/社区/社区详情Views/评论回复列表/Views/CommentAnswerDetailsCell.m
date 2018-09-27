//
//  CommentAnswerDetailsCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommentAnswerDetailsCell.h"

#import "DetailsCommunityViewModel.h"

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface CommentAnswerDetailsCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UIView      *otherBackView;
@property (nonatomic, strong) UIView      *answerBackView;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *answerLabel;
@property (nonatomic, strong) UIView      *v_lineView;

@end

@implementation CommentAnswerDetailsCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubViews];
        
    }
    
    return self;
    
}

- (void) initSubViews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.iconImageView              = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImageView.contentMode  = UIViewContentModeScaleAspectFit;
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
    
    {

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

    }
    
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

    UIButton *button = [UIButton createButtonWithFrame:self.bigImageView.frame
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:2000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [self.contentView addSubview:button];
    
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
    
}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        if (sender.selected == NO) {

            [_delegate clickDetailsLikeButton];

        }

    } else {

        DetailsCommunityViewModel *model = self.data;

        NSArray *imageUrlArray = @[model.reImgURL];
        
        [_delegate clickChankImageWithImageArray:imageUrlArray tag:sender.tag];

    }
    
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
        
        self.contentLabel.frame = CGRectMake(self.nameLabel.x, 50 *Scale_Height, self.width - 64 *Scale_Width, labelHeight);
        
    } else {
        
        self.contentLabel.frame = CGRectMake(self.nameLabel.x, 40 *Scale_Height, self.width - 64 *Scale_Width, 0);
        
    }
    
    DetailsCommunityViewModel *model = self.data;
    
    if (model.reImgURL.length > 0) {
        
        self.bigImageView.frame = CGRectMake(self.contentLabel.x, self.contentLabel.y + self.contentLabel.height + 10 *Scale_Height, Image_More_Height, Image_More_Height);

        for (UIView *view in self.contentView.subviews) {

            if ([view isKindOfClass:[UIButton class]] && view.tag == 2000) {

                view.frame = self.bigImageView.frame;

            }

        }
        
    } else {
        
        self.bigImageView.frame = CGRectMake(self.contentLabel.x, self.contentLabel.y + self.contentLabel.height, Image_More_Height, 0);
        
    }
    
    self.otherBackView.frame = CGRectMake(self.nameLabel.x, self.bigImageView.y + self.bigImageView.height, self.width - self.nameLabel.x - 12 *Scale_Width, 40 *Scale_Height);
    
    [self.dateLabel sizeToFit];
    
    self.dateLabel.frame = CGRectMake(0, 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    
}

- (void) loadContent {
    
    DetailsCommunityViewModel *model = self.data;
    
    if (model.ansContent.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:model.ansContent attributes:attribute];
        
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
    
    NSArray *array = [model.reImgURL componentsSeparatedByString:@","];
    
    if (array.count > 0) {
        
        NSString *downloudImageUrlStr = array[0];
        NSURL    *downloudImageUrl    = [NSURL URLWithString:downloudImageUrlStr];
        
        //  下载图片
        [QTDownloadWebImage downloadImageForImageView:self.bigImageView
                                             imageUrl:downloudImageUrl
                                     placeholderImage:@"照片"
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
