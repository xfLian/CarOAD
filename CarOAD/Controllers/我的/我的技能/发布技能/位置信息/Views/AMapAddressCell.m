//
//  AMapAddressCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AMapAddressCell.h"

#import "AMapAddressData.h"

@interface AMapAddressCell()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UIImageView *selectedImageView;

@end

@implementation AMapAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubViews];
        
    }
    
    return self;
    
}

- (void) initSubViews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_14
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.contentLabel];
    
    self.selectedImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.selectedImageView.contentMode   = UIViewContentModeScaleAspectFit;
    self.selectedImageView.image         = [UIImage imageNamed:@"selected_full"];
    [self.contentView addSubview:self.selectedImageView];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];
    
}

- (void) layoutSubviews {
    
    self.titleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.contentView.width - 60 *Scale_Width, 20 *Scale_Height);
    
    self.contentLabel.frame = CGRectMake(15 *Scale_Width, self.titleLabel.y + self.titleLabel.height + 5 *Scale_Height, self.titleLabel.width, 20 *Scale_Height);
    
    self.selectedImageView.frame = CGRectMake(self.contentView.width - 35 *Scale_Width, (self.contentView.height - 20 *Scale_Width) / 2, 20 *Scale_Width, 20 *Scale_Width);
    
    self.lineView.frame = CGRectMake(15 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 15 *Scale_Width, 0.5f);
    
}

- (void)loadContent {
    
    AMapAddressData *poi = self.data;
    
    if (poi.name.length > 0) {
        
        self.titleLabel.text = poi.name;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (poi.address.length > 0) {
        
        self.contentLabel.text = poi.address;
        
    } else {
        
        self.contentLabel.text = @"";
        
    }
    
    if (poi.isSelected == YES) {
        
        self.selectedImageView.hidden = NO;
        
    } else {
        
        self.selectedImageView.hidden = YES;
        
    }
    
}

@end
