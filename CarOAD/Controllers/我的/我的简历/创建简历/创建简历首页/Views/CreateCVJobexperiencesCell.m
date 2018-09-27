//
//  CreateCVJobexperiencesCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CreateCVJobexperiencesCell.h"

#import "CreateCVJobexperiencesData.h"
#import "NSString+LabelWidthAndHeight.h"

@interface CreateCVJobexperiencesCell()
{
    
    BOOL isChangeUI;
    
}
@property (nonatomic, strong) UIView  *noDataBackView;
@property (nonatomic, strong) UIView  *normalBackView;
@property (nonatomic, strong) UIView  *expendBackView;

@property (nonatomic, strong) UILabel *noDataTitleLabel;
@property (nonatomic, strong) UILabel *noDataContentLabel;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *skillPostLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView  *v_lineView;
@property (nonatomic, strong) UIView  *bottom_v_lineView;

@property (nonatomic, strong) UIView  *top_h_lineView;
@property (nonatomic, strong) UIView  *circle_view;
@property (nonatomic, strong) UIView  *bottom_h_lineView;

@end

@implementation CreateCVJobexperiencesCell

- (void)setupCell {

    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

}

- (void)buildSubview {

    self.noDataBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height)];
    self.noDataBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.noDataBackView];
    self.noDataBackView.hidden = YES;

    self.normalBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 *Scale_Height)];
    self.normalBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.normalBackView];

    self.expendBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, self.normalBackView.y + self.normalBackView.height, Screen_Width, 0)];
    self.expendBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expendBackView];

    {

        self.noDataTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:@"尚未添加工作经验"
                                                         font:UIFont_15
                                                    textColor:TextBlackColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:100];
        [self.noDataBackView addSubview:self.noDataTitleLabel];
        [self.noDataTitleLabel sizeToFit];
        self.noDataTitleLabel.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, self.noDataTitleLabel.width, 20 *Scale_Height);

        self.noDataContentLabel = [UILabel createLabelWithFrame:CGRectZero
                                                      labelType:kLabelNormal
                                                           text:@"请从最近一份工作填起"
                                                           font:UIFont_14
                                                      textColor:TextGrayColor
                                                  textAlignment:NSTextAlignmentLeft
                                                            tag:101];
        [self.noDataBackView addSubview:self.noDataContentLabel];
        [self.noDataContentLabel sizeToFit];
        self.noDataContentLabel.frame = CGRectMake(15 *Scale_Width, self.noDataTitleLabel.y + self.noDataTitleLabel.height + 10 *Scale_Height, self.noDataContentLabel.width, 20 *Scale_Height);

    }

    self.dateLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@""
                                                       font:UIFont_14
                                                  textColor:TextGrayColor
                                              textAlignment:NSTextAlignmentLeft
                                                        tag:100];
    [self.normalBackView addSubview:self.dateLabel];
    self.dateLabel.frame = CGRectMake(35 *Scale_Width, 10 *Scale_Height, self.normalBackView.width - 50 *Scale_Width, 20 *Scale_Height);

    self.shopNameLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@""
                                                       font:UIFont_15
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentLeft
                                                        tag:100];
    [self.normalBackView addSubview:self.shopNameLabel];
    self.shopNameLabel.frame = CGRectMake(35 *Scale_Width, self.dateLabel.y + self.dateLabel.height + 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);

    self.skillPostLabel = [UILabel createLabelWithFrame:CGRectZero
                                                  labelType:kLabelNormal
                                                       text:@""
                                                       font:UIFont_14
                                                  textColor:TextBlackColor
                                              textAlignment:NSTextAlignmentLeft
                                                        tag:100];
    [self.normalBackView addSubview:self.skillPostLabel];
    self.skillPostLabel.frame = CGRectMake(35 *Scale_Width, self.shopNameLabel.y + self.shopNameLabel.height + 10 *Scale_Height, self.dateLabel.width, 20 *Scale_Height);

    self.v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.v_lineView.backgroundColor = LineColor;
    [self.expendBackView addSubview:self.v_lineView];

    self.contentLabel = [UILabel createLabelWithFrame:CGRectZero
                                           labelType:kLabelNormal
                                                text:@""
                                                font:UIFont_14
                                           textColor:TextGrayColor
                                       textAlignment:NSTextAlignmentLeft
                                                 tag:102];
    self.contentLabel.numberOfLines = 0;
    [self.expendBackView addSubview:self.contentLabel];

    self.circle_view                 = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, self.dateLabel.y + 3 *Scale_Height, 14 *Scale_Height, 14 *Scale_Height)];
    self.circle_view.backgroundColor = [UIColor clearColor];
    self.circle_view.layer.masksToBounds = YES;
    self.circle_view.layer.cornerRadius  = self.circle_view.width / 2;
    self.circle_view.layer.borderColor   = MainColor.CGColor;
    self.circle_view.layer.borderWidth   = 1.5f;
    [self.contentView addSubview:self.circle_view];

    self.top_h_lineView             = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width + self.circle_view.width / 2 - 0.5f, 0, 0.5f, self.circle_view.y)];
    self.top_h_lineView.backgroundColor = MainColor;
    [self.contentView addSubview:self.top_h_lineView];

    self.bottom_h_lineView          = [[UIView alloc] initWithFrame:CGRectMake(self.top_h_lineView.x, self.circle_view.y + self.circle_view.height, 0.5f, self.contentView.height - (self.circle_view.y + self.circle_view.height))];
    self.bottom_h_lineView.backgroundColor = MainColor;
    [self.contentView addSubview:self.bottom_h_lineView];
    
    self.bottom_v_lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottom_v_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.bottom_v_lineView];

}

- (void)layoutSubviews {

    CGFloat totalStringHeight = [self.contentLabel.text heightWithStringFont:UIFont_14 fixedWidth:Width - 50 *Scale_Width];
    self.contentLabel.frame   = CGRectMake(35 *Scale_Width, 10 *Scale_Height, Screen_Width - 50 *Scale_Width, totalStringHeight);
    self.expendBackView.frame = CGRectMake(0, self.normalBackView.y + self.normalBackView.height, Screen_Width, 20 *Scale_Height + totalStringHeight);
    self.v_lineView.frame = CGRectMake(35 *Scale_Width, 0, self.expendBackView.width - 50 *Scale_Width, 0.5f);

    self.bottom_h_lineView.frame = CGRectMake(self.top_h_lineView.x, self.circle_view.y + self.circle_view.height, 0.5f, self.contentView.height - (self.circle_view.y + self.circle_view.height));
 
    self.bottom_v_lineView.frame = CGRectMake(35 *Scale_Width, self.contentView.height - 0.5f, self.contentView.width - 35 *Scale_Width, 0.5f);
    
}

- (void)changeState {

    isChangeUI = YES;
    
    CreateCVJobexperiencesData *model   = self.dataAdapter.data;
    TableViewCellDataAdapter   *adapter = self.dataAdapter;

    if (adapter.cellType == kCreateCVJobexperiencesCellNormalType) {

        [self updateWithNewCellHeight:model.expendStringHeight animated:NO];
        [self expendState];
        adapter.cellType = kCreateCVJobexperiencesCellExpendType;

    } else {

        [self updateWithNewCellHeight:model.normalStringHeight animated:NO];
        [self normalState];
        adapter.cellType = kCreateCVJobexperiencesCellNormalType;
        
    }

}

- (void) changeUI {

    TableViewCellDataAdapter *adapter = self.dataAdapter;

    if (adapter.cellType == kCreateCVJobexperiencesCellNoDataType) {

        [self noDataState];

    } else if (adapter.cellType == kCreateCVJobexperiencesCellNormalType) {

        [self normalState];
        
    } else if (adapter.cellType == kCreateCVJobexperiencesCellExpendType) {
        
        [self expendState];
        
    }

}

- (void) noDataState {

    self.noDataBackView.hidden = NO;
    self.normalBackView.hidden = YES;
    self.expendBackView.hidden = YES;

    self.circle_view.hidden = YES;
    self.top_h_lineView.hidden = YES;
    self.bottom_h_lineView.hidden = YES;

}

- (void)normalState {
    
    CreateCVJobexperiencesData *model = self.dataAdapter.data;
    
    self.circle_view.hidden = NO;
    self.noDataBackView.hidden = YES;
    self.normalBackView.hidden = NO;
    
    CGRect bottomRect = self.bottom_h_lineView.frame;
    bottomRect.size.height = model.normalStringHeight - bottomRect.origin.y;
    self.bottom_h_lineView.frame = bottomRect;
    
    CGRect frame      = self.expendBackView.frame;
    frame.size.height = 0;
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.expendBackView.frame = frame;
        self.expendBackView.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.expendBackView.hidden = YES;
        
    }];
    
}

- (void)expendState {

    self.circle_view.hidden    = NO;
    self.noDataBackView.hidden = YES;
    self.normalBackView.hidden = NO;
    
    CreateCVJobexperiencesData *model = self.dataAdapter.data;
    
    CGRect bottomRect            = self.bottom_h_lineView.frame;
    bottomRect.size.height       = model.expendStringHeight + model.normalStringHeight - bottomRect.origin.y;
    self.bottom_h_lineView.frame = bottomRect;
    
    CGRect frame      = self.expendBackView.frame;
    frame.size.height = model.expendStringHeight - model.normalStringHeight;

    self.expendBackView.hidden = NO;
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.expendBackView.frame = frame;
        self.expendBackView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        self.expendBackView.hidden = NO;
        self.expendBackView.alpha = 1.f;
        
    }];

}

- (void)loadContent {

    CreateCVJobexperiencesData *model = self.dataAdapter.data;
    TableViewCellDataAdapter   *adapter = self.dataAdapter;

    if (model.entryDate.length > 0 && model.quitDate.length > 0) {
        
        NSDate *quitDate = nil;
        NSString *quitDateString = nil;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *entryDate = [dateFormatter dateFromString:model.entryDate];
        
        if (![model.quitDate isEqualToString:@"至今"]) {
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            quitDate  = [dateFormatter dateFromString:model.quitDate];
            quitDateString  = [dateFormatter stringFromDate:quitDate];
            
        } else {
            
            quitDateString = model.quitDate;
            
        }
        
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        NSString *entryDateString = [dateFormatter stringFromDate:entryDate];

        self.dateLabel.text = [NSString stringWithFormat:@"%@-%@",entryDateString,quitDateString];

    } else {

        self.dateLabel.text = @"";

    }

    if (model.shopName.length > 0) {

        self.shopNameLabel.text = model.shopName;

    } else {

        self.shopNameLabel.text = @"";

    }

    if (model.skillPostExp.length > 0) {

        self.skillPostLabel.text = model.skillPostExp;

    } else {

        self.skillPostLabel.text = @"";

    }

    if (model.workContent.length > 0) {

        self.contentLabel.text = model.workContent;

    } else {

        self.contentLabel.text = @"";

    }

    if (adapter.indexPath.row == 0) {

        self.top_h_lineView.hidden = YES;

    } else {

        self.top_h_lineView.hidden = NO;

    }

    if (adapter.isHideBottomView == YES) {

        self.bottom_h_lineView.hidden = YES;
        self.bottom_v_lineView.hidden = YES;

    } else {

        self.bottom_h_lineView.hidden = NO;
        self.bottom_v_lineView.hidden = NO;
        
    }
    
    CarOadLog(@"isChangeUI --- %d",isChangeUI);
    
    [self changeUI];

}

- (void)selectedEvent {

    TableViewCellDataAdapter *adapter = self.dataAdapter;
    
    if (adapter.cellType != kCreateCVJobexperiencesCellNoDataType) {
        
        [self changeState];
        
    }
    
}

+ (CGFloat)cellHeightWithData:(id)data {

    CreateCVJobexperiencesData *model = data;

    if (model) {

        CGFloat totalStringHeight = [model.workContent heightWithStringFont:UIFont_14 fixedWidth:Width - 50 *Scale_Width];

        // Expend string height.
        model.expendStringHeight = 120 *Scale_Height + totalStringHeight;

        // One line height.
        model.normalStringHeight = 100 *Scale_Height;

        model.noDataStringHeight = 70 *Scale_Height;

    }

    return 0.f;
}

@end
