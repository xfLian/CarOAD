//
//  VideoDetailsView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/26.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "VideoDetailsView.h"

#import "VideoListData.h"

@interface VideoDetailsView()
{

    AliyunVodPlayerEvent tmp_event;

}
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation VideoDetailsView

- (void) buildSubview {

    self.backgroundColor = [UIColor whiteColor];

    self.iconImageView              = [[UIImageView alloc] initWithFrame:CGRectMake(12 *Scale_Width, 10 *Scale_Height, 34 *Scale_Height, 34 *Scale_Height)];
    self.iconImageView.contentMode  = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"contact_off_gray"];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = self.iconImageView.width / 2;

    self.nameLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:101];
    [self addSubview:self.nameLabel];

    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@""
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:102];
    [self addSubview:self.dateLabel];

}

- (void) loadContent {

    VideoListData *model = self.data;

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

    NSDate * date = [formatter dateFromString:model.createDate];
    [formatter setDateFormat:@"MM-dd"];

    NSString *dateString = [formatter stringFromDate:date];

    if (dateString.length > 0) {

        self.dateLabel.text = dateString;

    } else {

        self.dateLabel.text = @"";

    }

    [self.nameLabel sizeToFit];

    self.nameLabel.frame = CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, self.iconImageView.y, self.nameLabel.width, self.iconImageView.height);

    [self.dateLabel sizeToFit];

    self.dateLabel.frame = CGRectMake(self.width - self.dateLabel.width - 12 *Scale_Width, self.iconImageView.y, self.dateLabel.width, self.iconImageView.height);

}

@end
