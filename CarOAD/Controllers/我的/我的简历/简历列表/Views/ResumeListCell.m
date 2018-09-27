//
//  ResumeListCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ResumeListCell.h"

#import "ResumeListData.h"

#import "ProgressBarLineView.h"
#import "ResumeListLabel.h"

@interface ResumeListCell ()

@property (nonatomic, strong) ProgressBarLineView  *progressBarLineView;
@property (nonatomic, strong) ResumeListLabel      *integrityRungsNumberLabel;

@property (nonatomic, strong) UIView  *normalBackView;
@property (nonatomic, strong) UIView  *expendBackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) UILabel *confidentialityLabel;
@property (nonatomic, strong) UILabel *integrityRungsLabel;
@property (nonatomic, strong) UIView  *integrityRungsBackView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIView  *line;

@end

@implementation ResumeListCell

@dynamic delegate;

- (void)setupCell {

    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;

}

- (void)buildSubview {

    self.normalBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Height, Screen_Width, 100 *Scale_Height)];
    self.normalBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.normalBackView];

    self.expendBackView                 = [[UIView alloc] initWithFrame:CGRectMake(0, self.normalBackView.y + self.normalBackView.height, Screen_Width, 60 *Scale_Height)];
    self.expendBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expendBackView];

    self.defaultLabel = [UILabel createLabelWithFrame:CGRectZero
                                            labelType:kLabelNormal
                                                 text:@"默认"
                                                 font:UIFont_13
                                            textColor:[UIColor whiteColor]
                                        textAlignment:NSTextAlignmentCenter
                                                  tag:101];
    self.defaultLabel.backgroundColor = CarOadColor(210, 33, 33);
    [self.normalBackView addSubview:self.defaultLabel];
    [self.defaultLabel sizeToFit];
    self.defaultLabel.frame = CGRectMake(self.normalBackView.width - 29 *Scale_Width - self.defaultLabel.width, 10 *Scale_Height, self.defaultLabel.width + 14 *Scale_Width, 18 *Scale_Height);
    self.defaultLabel.layer.masksToBounds = YES;
    self.defaultLabel.layer.cornerRadius  = 2.f *Scale_Width;

    self.confidentialityLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:@"保密"
                                                         font:UIFont_14
                                                    textColor:TextGrayColor
                                                textAlignment:NSTextAlignmentRight
                                                          tag:101];
    [self.normalBackView addSubview:self.confidentialityLabel];
    [self.confidentialityLabel sizeToFit];
    self.confidentialityLabel.frame = CGRectMake(self.normalBackView.width - 25 *Scale_Width - self.confidentialityLabel.width, self.defaultLabel.y + self.defaultLabel.height + 10 *Scale_Height, self.confidentialityLabel.width + 10 *Scale_Width, 20 *Scale_Height);

    self.typeLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@"全职简历"
                                              font:UIFont_14
                                         textColor:TextGrayColor
                                     textAlignment:NSTextAlignmentRight
                                               tag:101];
    [self.normalBackView addSubview:self.typeLabel];
    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(self.normalBackView.width - 25 *Scale_Width - self.typeLabel.width, self.confidentialityLabel.y + self.confidentialityLabel.height + 10 *Scale_Height, self.typeLabel.width + 10 *Scale_Width, 20 *Scale_Height);

    self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, self.defaultLabel.y, self.defaultLabel.x - 25 *Scale_Width, 20 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@"凯路登"
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.normalBackView addSubview:self.titleLabel];

    self.dateLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, self.confidentialityLabel.y, self.confidentialityLabel.x - 15 *Scale_Width, 20 *Scale_Height)
                                          labelType:kLabelNormal
                                               text:@"更新日期"
                                               font:UIFont_14
                                          textColor:TextGrayColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:103];
    [self.normalBackView addSubview:self.dateLabel];

    self.integrityRungsLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"完整度"
                                                  font:UIFont_14
                                             textColor:TextGrayColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:101];
    [self.normalBackView addSubview:self.integrityRungsLabel];
    [self.integrityRungsLabel sizeToFit];
    self.integrityRungsLabel.frame = CGRectMake(15 *Scale_Width, self.typeLabel.y, self.integrityRungsLabel.width + 10 *Scale_Width, 20 *Scale_Height);

    self.integrityRungsBackView                 = [[UIView alloc] initWithFrame:CGRectMake(self.integrityRungsLabel.x + self.integrityRungsLabel.width, self.integrityRungsLabel.y + 3 *Scale_Height, 100 *Scale_Width, 14 *Scale_Height)];
    self.integrityRungsBackView.backgroundColor = BackGrayColor;
    [self.normalBackView addSubview:self.integrityRungsBackView];
    
    //  显示进度条控件
    self.progressBarLineView = [ProgressBarLineView createDefaultViewWithFrame:self.integrityRungsBackView.bounds];
    [self.progressBarLineView buildView];
    [self.integrityRungsBackView addSubview:self.progressBarLineView];

    self.integrityRungsNumberLabel = [[ResumeListLabel alloc] initWithFrame:CGRectMake(self.integrityRungsBackView.x + self.integrityRungsBackView.width + 10 *Scale_Width, self.integrityRungsLabel.y, 80 *Scale_Width, 20 *Scale_Height)];
    self.integrityRungsNumberLabel.backgroundColor = [UIColor clearColor];
    [self.normalBackView addSubview:self.integrityRungsNumberLabel];

    NSArray *buttonTitleArray = @[@"预览",@"刷新",@"编辑",@"删除"];
    NSArray *buttonImageArray = @[@"cv_preview",@"cv_refurbish",@"cv_edit",@"cv_delete"];

    for (int i = 0; i < 4; i++) {

        UIButton *button = [UIButton createWithTopAndButtomButtonForResumeListWithFrame:CGRectMake(Screen_Width / 4 *i, 0, Screen_Width / 4, self.expendBackView.height)
                                                                     title:buttonTitleArray[i]
                                                                     image:[UIImage imageNamed:buttonImageArray[i]]
                                                                       tag:0
                                                                    target:self
                                                                    action:@selector(buttonEvent:)];
        [self.expendBackView addSubview:button];

    }

    self.line                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5f)];
    self.line.backgroundColor = LineColor;
    [self.expendBackView addSubview:self.line];

    self.expendBackView.alpha  = 0.f;
    self.expendBackView.hidden = YES;

}

- (void) buttonEvent:(UIButton *)sender {

    TableViewCellDataAdapter *adapter = self.dataAdapter;

    if (sender.tag == adapter.indexPath.row) {

        [self.delegate clickCheckPreviewCVWithRow:adapter.indexPath.row];

    } else if (sender.tag == adapter.indexPath.row + 1) {

        [self.delegate clickRefreshCVWithRow:adapter.indexPath.row];

    } else if (sender.tag == adapter.indexPath.row + 2) {

        [self.delegate clickEdiCVWithRow:adapter.indexPath.row];

    } else if (sender.tag == adapter.indexPath.row + 3) {

        [self.delegate clickDeleteCVWithRow:adapter.indexPath.row];

    }

}

- (void)changeState {

    ResumeListData           *model   = self.dataAdapter.data;
    TableViewCellDataAdapter *adapter = self.dataAdapter;

    if (adapter.cellType == kShowButtonCellNormalType) {

        adapter.cellType = kShowButtonCellExpendType;
        [self updateWithNewCellHeight:model.expendStringHeight animated:YES];
        [self expendState];
        
    } else {

        adapter.cellType = kShowButtonCellNormalType;
        [self updateWithNewCellHeight:model.normalStringHeight animated:YES];
        [self normalState];
        
    }
    
}

- (void)normalState {

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

    CGRect frame      = self.expendBackView.frame;
    frame.size.height = 60 *Scale_Height;

    self.expendBackView.hidden = NO;

    [UIView animateWithDuration:0.25f animations:^{

        self.expendBackView.frame = frame;
        self.expendBackView.alpha = 1.f;

    }];

}

- (void)loadContent {

    [self.progressBarLineView strokeEnd:0 animated:NO duration:0];
    [self.progressBarLineView strokeStart:0 animated:NO duration:0];

    ResumeListData           *model   = self.dataAdapter.data;
    TableViewCellDataAdapter *adapter = self.dataAdapter;

    if (model.skillPost.length > 0) {

        self.titleLabel.text = model.skillPost;

    } else {

        self.titleLabel.text = @"";

    }

    if (model.isDefault.length > 0 && [model.isDefault integerValue] == 1) {

        self.defaultLabel.hidden = NO;

    } else {

        self.defaultLabel.hidden = YES;

    }

    if (model.uodateDate.length > 0) {

        self.dateLabel.text = [NSString stringWithFormat:@"更新日期 %@",model.uodateDate];

    } else {

        self.dateLabel.text = @"更新日期";

    }

    if (model.isOpen.length > 0 && [model.isOpen integerValue] == 1) {

        self.confidentialityLabel.text = @"公开";

    } else {

        self.confidentialityLabel.text = @"保密";

    }

    if (model.workNature.length > 0) {

        self.typeLabel.text = model.workNature;

    } else {

        self.typeLabel.text = @"";

    }


    if (model.integrity.length > 0) {

        NSString *integrity  = [model.integrity stringByReplacingOccurrencesOfString:@"%" withString:@""];
        self.integrityRungsNumberLabel.toValue = [integrity integerValue];

        [self.integrityRungsNumberLabel showDuration:1.25f];
        [self.progressBarLineView strokeEnd:self.integrityRungsNumberLabel.toValue / 100 animated:YES duration:1.25f];

    } else {

        self.integrityRungsNumberLabel.toValue = 0;
        [self.progressBarLineView strokeEnd:0 animated:YES duration:1.25f];

    }

    for (int i = 0; i < self.expendBackView.subviews.count; i++) {

        UIView *subView = self.expendBackView.subviews[i];

        if ([subView isKindOfClass:[UIButton class]]) {

            UIButton *button = (UIButton *)subView;
            button.tag       = adapter.indexPath.row + i;

        }

    }
    
    self.expendBackView.hidden = YES;

}

- (void)selectedEvent {

    [self changeState];
}

+ (CGFloat)cellHeightWithData:(id)data {

    ResumeListData *model = data;

    if (model) {

        // Expend string height.
        model.expendStringHeight = 170 *Scale_Height;

        // One line height.
        model.normalStringHeight = 110 *Scale_Height;
    }

    return 0.f;
}

@end
