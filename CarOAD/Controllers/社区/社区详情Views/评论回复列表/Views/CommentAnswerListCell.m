//
//  CommentAnswerListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommentAnswerListCell.h"

#import "CommunityAnswerListViewModel.h"

#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface CommentAnswerListCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIView      *otherBackView;
@property (nonatomic, strong) UIView      *answerBackView;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UILabel     *answerLabel;
@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UIButton    *chackButton;
@property (nonatomic, strong) UIView      *v_lineView;

@end

@implementation CommentAnswerListCell

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
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@""
                                                 font:UIFont_15
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    UIButton *chackButton = [UIButton createButtonWithFrame:CGRectZero
                                                 title:@"全文"
                                       backgroundImage:nil
                                                   tag:self.tag
                                                target:self
                                                action:@selector(buttonEvent:)];
    [chackButton setTitleColor:MainColor forState:UIControlStateNormal];
    [chackButton setTitleColor:MainColor forState:UIControlStateSelected];
    [chackButton setTitle:@"全文" forState:UIControlStateNormal];
    [chackButton setTitle:@"收起" forState:UIControlStateSelected];
    [self.contentView addSubview:chackButton];
    self.chackButton = chackButton;


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
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                                 title:@"回复"
                                       backgroundImage:nil
                                                   tag:self.tag + 1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    
    [self.otherBackView addSubview:button];
    self.button = button;

    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = TextGrayColor;
    [self.contentView addSubview:self.v_lineView];
    
}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag >= 1000) {

        CommunityAnswerListViewModel *model = self.data;

        [_delegate commentReplyWithData:model];

    } else {

        [_delegate clickChankAllMessageWithData:self.data];

    }

    
}

- (void) layoutSubviews {
    
    self.iconImageView.frame               = CGRectMake(12 *Scale_Width, 10 *Scale_Height, 30 *Scale_Height, 30 *Scale_Height);
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2;
    
    [self.answerLabel sizeToFit];

    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, 15 *Scale_Height, self.contentView.width - (self.iconImageView.x + self.iconImageView.width + 15 *Scale_Width), 20 *Scale_Height);
    
    if (self.contentLabel.text.length > 0) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 4;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        
        CGFloat labelHeight = [self.contentLabel.text heightWithStringAttribute:attribute fixedWidth:Screen_Width - 64 *Scale_Width];

        CarOadLog(@"labelHeight --- %f",labelHeight);
        
        if (labelHeight > 62 *Scale_Height) {

            self.chackButton.hidden = NO;
            
            CommunityAnswerListViewModel *model = self.data;
            
            if (model.isClickChackButton == YES) {
                

                
            } else {
                
                labelHeight = 62 *Scale_Height;

            }
            
            self.contentLabel.frame = CGRectMake(self.nameLabel.x, 50 *Scale_Height, self.width - 64 *Scale_Width, labelHeight);
            
            self.chackButton.frame = CGRectMake(self.nameLabel.x, self.contentLabel.y + self.contentLabel.height, 40 *Scale_Width, 30 *Scale_Height);
            
        } else {
            
            self.chackButton.hidden = YES;
            
            self.contentLabel.frame = CGRectMake(self.nameLabel.x, 50 *Scale_Height, self.width - 64 *Scale_Width, labelHeight);
            
            self.chackButton.frame = CGRectMake(self.nameLabel.x, self.contentLabel.y + self.contentLabel.height, self.width - self.nameLabel.x - 12 *Scale_Width, 0);
        }
        
    } else {
        
        self.contentLabel.frame = CGRectMake(self.nameLabel.x, 40 *Scale_Height, self.width - 64 *Scale_Width, 0);
        
        self.chackButton.frame = CGRectMake(self.nameLabel.x, self.contentLabel.y + self.contentLabel.height, self.width - self.nameLabel.x - 12 *Scale_Width, 0);
        
    }
    
    self.otherBackView.frame = CGRectMake(self.nameLabel.x, self.chackButton.y + self.chackButton.height, self.width - self.nameLabel.x - 12 *Scale_Width, 40 *Scale_Height);
    
    [self.dateLabel sizeToFit];
    
    self.dateLabel.frame = CGRectMake(0, 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);
    self.button.frame    = CGRectMake(self.dateLabel.x + self.dateLabel.width + 5, 0, 50, self.otherBackView.height);

    self.v_lineView.frame = CGRectMake(12 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 24 *Scale_Width, 0.5f);
    
}

- (void) loadContent {
    
    CommunityAnswerListViewModel *model = self.data;
    
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
    
    if (model.userImg.length > 0) {
        
        NSString *downloudImageUrlStr = model.userImg;
        
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
    
    if (model.userName.length > 0) {
        
        self.nameLabel.text = model.userName;
        
    } else {
        
        self.nameLabel.text = @"";
        
    }
    
    if (model.createDate.length > 0) {
        
        self.dateLabel.text = model.createDate;
        
    } else {
        
        self.dateLabel.text = @"";
        
    }

    if (model.isClickChackButton == YES) {

        self.chackButton.selected = YES;

    } else {

        self.chackButton.selected = NO;

    }
    
}

@end
