//
//  MYSkillListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MYSkillListCell.h"
#import "MYSkillListData.h"

#define Image_More_Height 85 *Scale_Height

@interface MYSkillListCell()

@property (nonatomic, strong) UIImageView *smallImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIImageView *chackImageView;
@property (nonatomic, strong) UILabel *chackLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIButton *edi_button;
@property (nonatomic, strong) UIButton *delete_button;
@property (nonatomic, strong) UIButton *change_state_button;
@property (nonatomic, strong) UIButton *handle_button;

@property (nonatomic, strong) UIView *v_lineView;

@end

@implementation MYSkillListCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.smallImageView               = [[UIImageView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Image_More_Height, Image_More_Height)];
    self.smallImageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.smallImageView.clipsToBounds = YES;
    self.smallImageView.image         = [UIImage imageNamed:carPlaceholderImageString];
    [self.contentView addSubview:self.smallImageView];
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(self.smallImageView.x + self.smallImageView.width + 10 *Scale_Width, self.smallImageView.y, Screen_Width - (self.smallImageView.x + self.smallImageView.width + 25 *Scale_Width), 45 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    self.titleLabel.numberOfLines = 2;
    [self.contentView addSubview:self.titleLabel];
    
    self.priceLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"¥0/小时"
                                               font:UIFont_14
                                          textColor:[UIColor redColor]
                                      textAlignment:NSTextAlignmentRight
                                                tag:103];
    [self.contentView addSubview:self.priceLabel];
    
    self.chackImageView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.chackImageView.contentMode   = UIViewContentModeScaleAspectFit;
    self.chackImageView.image         = [UIImage imageNamed:@"open_eyes_gray"];
    [self.contentView addSubview:self.chackImageView];
    
    self.chackLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@"0"
                                                 font:UIFont_13
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentCenter
                                                  tag:101];
    [self.contentView addSubview:self.chackLabel];
    
    
    self.numberLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"接单0个"
                                                  font:UIFont_13
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:101];
    [self.contentView addSubview:self.numberLabel];
    
    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, self.smallImageView.y + self.smallImageView.height + 10 *Scale_Height, Screen_Width, 0.5f)];
    self.v_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.v_lineView];
    
    NSArray *buttonTitleArray = @[@"编辑",@"删除",@"暂停服务",@"去处理"];
    
    self.edi_button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, self.v_lineView.y + self.v_lineView.height + 10 *Scale_Height, (Screen_Width - 90 *Scale_Width) / 4, 25 *Scale_Height)
                                                 title:buttonTitleArray[0]
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    self.edi_button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:13.f *Scale_Width];
    [self.contentView addSubview:self.edi_button];
    self.edi_button.layer.masksToBounds = YES;
    self.edi_button.layer.borderWidth   = 0.7f;
    self.edi_button.layer.borderColor   = TextGrayColor.CGColor;
    self.edi_button.layer.cornerRadius  = 3.f *Scale_Width;
    
    self.delete_button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width + (Screen_Width - 90 *Scale_Width) / 4 + 20 *Scale_Width, self.v_lineView.y + self.v_lineView.height + 10 *Scale_Height, (Screen_Width - 90 *Scale_Width) / 4, 25 *Scale_Height)
                                                title:buttonTitleArray[1]
                                      backgroundImage:nil
                                                  tag:1001
                                               target:self
                                               action:@selector(buttonEvent:)];
    self.delete_button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:13.f *Scale_Width];
    [self.contentView addSubview:self.delete_button];
    self.delete_button.layer.masksToBounds = YES;
    self.delete_button.layer.borderWidth   = 0.7f;
    self.delete_button.layer.borderColor   = TextGrayColor.CGColor;
    self.delete_button.layer.cornerRadius  = 3.f *Scale_Width;
    
    self.change_state_button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width + ((Screen_Width - 90 *Scale_Width) / 4 + 20 *Scale_Width) *2, self.v_lineView.y + self.v_lineView.height + 10 *Scale_Height, (Screen_Width - 90 *Scale_Width) / 4, 25 *Scale_Height)
                                                title:buttonTitleArray[2]
                                      backgroundImage:nil
                                                  tag:1002
                                               target:self
                                               action:@selector(buttonEvent:)];
    self.change_state_button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:13.f *Scale_Width];
    [self.contentView addSubview:self.change_state_button];
    self.change_state_button.layer.masksToBounds = YES;
    self.change_state_button.layer.borderWidth   = 0.7f;
    self.change_state_button.layer.borderColor   = TextGrayColor.CGColor;
    self.change_state_button.layer.cornerRadius  = 3.f *Scale_Width;
    
    self.handle_button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width + ((Screen_Width - 90 *Scale_Width) / 4 + 20 *Scale_Width) *3, self.v_lineView.y + self.v_lineView.height + 10 *Scale_Height, (Screen_Width - 90 *Scale_Width) / 4, 25 *Scale_Height)
                                                title:buttonTitleArray[3]
                                      backgroundImage:nil
                                                  tag:1003
                                               target:self
                                               action:@selector(buttonEvent:)];
    self.handle_button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:13.f *Scale_Width];
    [self.contentView addSubview:self.handle_button];
    self.handle_button.layer.masksToBounds = YES;
    self.handle_button.layer.borderWidth   = 0.7f;
    self.handle_button.layer.borderColor   = TextGrayColor.CGColor;
    self.handle_button.layer.cornerRadius  = 3.f *Scale_Width;
    
}

- (void) layoutSubviews {
    
    CGFloat totalStringHeight = [self.titleLabel.text heightWithStringFont:UIFont_16 fixedWidth:self.titleLabel.width];
    
    if (totalStringHeight > 30 *Scale_Height) {
        
        self.titleLabel.frame = CGRectMake(self.smallImageView.x + self.smallImageView.width + 10 *Scale_Width, self.smallImageView.y, Screen_Width - (self.smallImageView.x + self.smallImageView.width + 25 *Scale_Width), 45 *Scale_Height);
        
    } else {
        
        self.titleLabel.frame = CGRectMake(self.smallImageView.x + self.smallImageView.width + 10 *Scale_Width, self.smallImageView.y, Screen_Width - (self.smallImageView.x + self.smallImageView.width + 25 *Scale_Width), 20 *Scale_Height);
        
    }
    
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(self.titleLabel.x, self.smallImageView.y + self.smallImageView.height - 40 *Scale_Height, self.priceLabel.width, 20 *Scale_Height);

    self.chackImageView.frame = CGRectMake(self.titleLabel.x, self.smallImageView.y + self.smallImageView.height - 20 *Scale_Height, 20 *Scale_Height, 20 *Scale_Height);
    [self.chackLabel sizeToFit];
    self.chackLabel.frame = CGRectMake(self.chackImageView.x + self.chackImageView.width + 5 *Scale_Width, self.chackImageView.y, self.chackLabel.width, 20 *Scale_Height);
    
    [self.numberLabel sizeToFit];
    self.numberLabel.frame = CGRectMake(self.contentView.width - 15 *Scale_Width - self.numberLabel.width, self.chackImageView.y, self.numberLabel.width, 20 *Scale_Height);
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        
        [self.delegate clickEdiSkillWithData:self.data];
        
    } else if (sender.tag == 1001) {
        
        [self.delegate clickDeleteSkillWithData:self.data];
        
    } else if (sender.tag == 1002) {
        
        [self.delegate clickChangeStateSkillWithData:self.data];
        
    } else if (sender.tag == 1003) {
        
        [self.delegate clickHandleSkillWithData:self.data];
        
    }
    
}

- (void) loadContent {
    
    MYSkillListData *model = self.data;
    
    if (model.skillImg.length > 0) {
        
        [QTDownloadWebImage downloadImageForImageView:self.smallImageView
                                             imageUrl:[NSURL URLWithString:model.skillImg]
                                     placeholderImage:carPlaceholderImageString
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 
                                             }
                                              success:^(UIImage *finishImage) {
                                                  
                                              }];
        
    } else {
        
        self.smallImageView.image = [UIImage imageNamed:carPlaceholderImageString];
        
    }
    
    if (model.skillTitle.length > 0) {
        
        self.titleLabel.text = model.skillTitle;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (model.skillPrice.length > 0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %@/%@",model.skillPrice,model.unit];
        
    } else {
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥ 0/%@",model.unit];
        
    }
    
    if (model.clickNum.length > 0) {
        
        self.chackLabel.text = model.clickNum;
        
    } else {
        
        self.chackLabel.text = @"";
        
    }
    
    if (model.makeOrder.length > 0) {
        
        self.numberLabel.text = [NSString stringWithFormat:@"接单%@人",model.makeOrder];
        
    } else {
        
        self.numberLabel.text = @"接单0人";
        
    }
    
    
    if (model.skillState.length > 0 && [model.skillState isEqualToString:@"Y"]) {
        
        self.edi_button.hidden = YES;
        self.delete_button.hidden = YES;
        
        [self.change_state_button setTitle:@"暂停服务" forState:UIControlStateNormal];
        
    } else {
        
        self.edi_button.hidden = NO;
        self.delete_button.hidden = NO;
        
        [self.change_state_button setTitle:@"恢复服务" forState:UIControlStateNormal];
        
    }
    
}

@end
