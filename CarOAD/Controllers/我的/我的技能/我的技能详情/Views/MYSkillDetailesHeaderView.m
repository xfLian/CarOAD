//
//  MYSkillDetailesHeaderView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MYSkillDetailesHeaderView.h"

#import "MYSkillDetailesData.h"

@implementation MYSkillDetailesHeaderView

- (MYSkillDetailesHeaderView *) createHeaderView; {
    
    MYSkillDetailesData *model = self.data;
    
    MYSkillDetailesHeaderView *headerView = [[MYSkillDetailesHeaderView alloc] initWithFrame:CGRectZero];
    
    headerView.data = model;
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width / 2)];
    iconImageView.contentMode   = UIViewContentModeScaleAspectFill;
    iconImageView.clipsToBounds = YES;
    iconImageView.backgroundColor = TextGrayColor;
    [headerView addSubview:iconImageView];
    if (model.skillImgName.length > 0) {
        
        [QTDownloadWebImage downloadImageForImageView:iconImageView
                                             imageUrl:[NSURL URLWithString:model.skillImgName]
                                     placeholderImage:carPlaceholderImageString
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } else {
        
        iconImageView.image = [UIImage imageNamed:@"carPlaceholderImageString"];
        
    }
    
    UIButton *button = [UIButton createButtonWithFrame:iconImageView.frame
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [headerView addSubview:button];
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, iconImageView.y + iconImageView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 20 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    titleLabel.numberOfLines = 2;
    [headerView addSubview:titleLabel];
    
    if (model.skillTitle.length > 0) {
        
        titleLabel.text = model.skillTitle;
        
        CGFloat totalStringHeight = [model.skillTitle heightWithStringFont:UIFont_16 fixedWidth:Width - 30 *Scale_Width];
        
        if (totalStringHeight <= 20 *Scale_Height) {
            
            titleLabel.frame = CGRectMake(15 *Scale_Width, iconImageView.y + iconImageView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 20 *Scale_Height);
            
        } else {
            
            titleLabel.frame = CGRectMake(15 *Scale_Width, iconImageView.y + iconImageView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height);
            
        }
        
    } else {
        
        titleLabel.text = @"";
    
    }

    UILabel *priceLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, titleLabel.y + titleLabel.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 20 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@"¥0/"
                                               font:UIFont_15
                                          textColor:[UIColor redColor]
                                      textAlignment:NSTextAlignmentLeft
                                                tag:103];
    [headerView addSubview:priceLabel];
    
    if (model.price.length > 0) {
        
        priceLabel.text = [NSString stringWithFormat:@"¥%@/%@",model.price,model.unit];
        
    } else {
        
        priceLabel.text = [NSString stringWithFormat:@"¥0/%@",model.unit];
        
    }
    
    {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, priceLabel.y + priceLabel.height + 10 *Scale_Height, Screen_Width, 0.5)];
        lineView.backgroundColor = LineColor;
        [headerView addSubview:lineView];
        
        UILabel *typeTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@"服务类型："
                                                       font:UIFont_15
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentLeft
                                                        tag:103];
        [headerView addSubview:typeTitleLabel];
        [typeTitleLabel sizeToFit];
        typeTitleLabel.frame = CGRectMake(15 *Scale_Width, lineView.y + lineView.height + 10 *Scale_Height, typeTitleLabel.width, 20 *Scale_Height);
        
        UILabel *typeContentLabel = [UILabel createLabelWithFrame:CGRectMake(typeTitleLabel.x + typeTitleLabel.width + 10 *Scale_Width, typeTitleLabel.y, Screen_Width - (typeTitleLabel.x + typeTitleLabel.width + 25 *Scale_Width), 20 *Scale_Height)
                                                      labelType:kLabelNormal
                                                           text:@""
                                                           font:UIFont_15
                                                      textColor:TextGrayColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:103];
        [headerView addSubview:typeContentLabel];
        
        if (model.skillType.length > 0) {
            
            typeContentLabel.text = model.skillType;
            
        } else {
            
            typeContentLabel.text = @"";
            
        }
        
    }
    
    {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, priceLabel.y + priceLabel.height + 50 *Scale_Height, Screen_Width - 15 *Scale_Width, 0.5)];
        lineView.backgroundColor = LineColor;
        [headerView addSubview:lineView];
        
        UILabel *servereAreaTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@"服务范围："
                                                           font:UIFont_15
                                                      textColor:TextBlackColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:103];
        [headerView addSubview:servereAreaTitleLabel];
        [servereAreaTitleLabel sizeToFit];
        servereAreaTitleLabel.frame = CGRectMake(15 *Scale_Width, lineView.y + lineView.height + 10 *Scale_Height, servereAreaTitleLabel.width, 20 *Scale_Height);
        
        UILabel *servereAreaContentLabel = [UILabel createLabelWithFrame:CGRectMake(servereAreaTitleLabel.x + servereAreaTitleLabel.width + 10 *Scale_Width, servereAreaTitleLabel.y, Screen_Width - (servereAreaTitleLabel.x + servereAreaTitleLabel.width + 25 *Scale_Width), 20 *Scale_Height)
                                                        labelType:kLabelNormal
                                                             text:@""
                                                             font:UIFont_15
                                                        textColor:TextGrayColor
                                                    textAlignment:NSTextAlignmentLeft
                                                              tag:103];
        [headerView addSubview:servereAreaContentLabel];
        
        if (model.servereArea.length > 0) {
            
            servereAreaContentLabel.text = model.servereArea;
            
        } else {
            
            servereAreaContentLabel.text = @"";
            
        }
        
    }
    
    {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, priceLabel.y + priceLabel.height + 90 *Scale_Height, Screen_Width - 15 *Scale_Width, 0.5)];
        lineView.backgroundColor = LineColor;
        [headerView addSubview:lineView];
        
        UILabel *publicDateTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@"发布时间："
                                                           font:UIFont_15
                                                      textColor:TextBlackColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:103];
        [headerView addSubview:publicDateTitleLabel];
        [publicDateTitleLabel sizeToFit];
        publicDateTitleLabel.frame = CGRectMake(15 *Scale_Width, lineView.y + lineView.height + 10 *Scale_Height, publicDateTitleLabel.width, 20 *Scale_Height);
        
        UILabel *publicDateContentLabel = [UILabel createLabelWithFrame:CGRectMake(publicDateTitleLabel.x + publicDateTitleLabel.width + 10 *Scale_Width, publicDateTitleLabel.y, Screen_Width - (publicDateTitleLabel.x + publicDateTitleLabel.width + 25 *Scale_Width), 20 *Scale_Height)
                                                        labelType:kLabelNormal
                                                             text:@""
                                                             font:UIFont_15
                                                        textColor:TextGrayColor
                                                    textAlignment:NSTextAlignmentLeft
                                                              tag:103];
        [headerView addSubview:publicDateContentLabel];
        
        if (model.publicDate.length > 0) {
            
            publicDateContentLabel.text = model.publicDate;
            
        } else {
            
            publicDateContentLabel.text = @"";
            
        }
        
        headerView.frame = CGRectMake(0, 0, Screen_Width, publicDateContentLabel.y + publicDateContentLabel.height + 10 *Scale_Height);
        
    }
    
    return headerView;
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    MYSkillDetailesData *model = self.data;
    
    if (model.skillImgName.length > 0) {
        
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        [imageArray addObject:model.skillImgName];
        
        [_delegate clickChankImageWithImageArray:[imageArray copy] tag:0];
        
    }
    
}

@end
