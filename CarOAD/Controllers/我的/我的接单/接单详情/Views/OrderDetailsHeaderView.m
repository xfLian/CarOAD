//
//  OrderDetailsHeaderView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OrderDetailsHeaderView.h"

#import "CutOutClearView.h"

#import "MyOrderDetailsData.h"
#import "MyOrderDetailsDemandImgList.h"

@interface OrderDetailsHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic, strong) UILabel  *countdownLabel;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *priceLabel;
@property (nonatomic, strong) UILabel  *numberLabel;
@property (nonatomic, strong) UILabel  *rushLabel;
@property (nonatomic, strong) UILabel  *publishDateLabel;
@property (nonatomic, strong) UILabel  *carTypeLabel;
@property (nonatomic, strong) UILabel  *faultTypeLabel;
@property (nonatomic, strong) UILabel  *endDateLabel;

@end

@implementation OrderDetailsHeaderView

- (void) buildSubview {
    
    [self registerNSNotificationCenter];
    
    self.backgroundColor = [UIColor whiteColor];
    
    SDCycleScrollView * cycleScrollView    = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, 187.5 *Scale_Height)
                                                                                delegate:nil
                                                                        placeholderImage:[UIImage imageNamed:@"img_home_default"]];
    cycleScrollView.autoScrollTimeInterval = 5;
    cycleScrollView.pageControlAliment     = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.titlesGroup            = nil;
    cycleScrollView.currentPageDotColor    = MainColor; // 自定义分页控件小圆标颜色
    cycleScrollView.delegate               = self;
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;
    
    //  倒计时view
    UIView *countdownBackView = [[UIView alloc] initWithFrame:CGRectMake(0, cycleScrollView.y + cycleScrollView.height, Screen_Width, 30 *Scale_Height)];
    countdownBackView.backgroundColor = MainColor;
    [self addSubview:countdownBackView];
    
    UILabel *countdownTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                       labelType:kLabelNormal
                                                            text:@"距离结束还有"
                                                            font:UIFont_15
                                                       textColor:[UIColor whiteColor]
                                                   textAlignment:NSTextAlignmentCenter
                                                             tag:103];
    [countdownBackView addSubview:countdownTitleLabel];
    [countdownTitleLabel sizeToFit];
    countdownTitleLabel.frame = CGRectMake(15 *Scale_Width, 0, countdownTitleLabel.width, countdownBackView.height);
    
    CGFloat gap = 2.f;
    CGFloat offset = 30.f;
    CGFloat pathStartX  = countdownTitleLabel.x + countdownTitleLabel.width + 15 *Scale_Width;
    CGFloat pathEndX  = Screen_Width - 15 *Scale_Width;
    
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(pathStartX, 0, pathEndX - pathStartX, countdownBackView.height)];
    labelView.backgroundColor = [UIColor whiteColor];
    labelView.layer.masksToBounds = YES;
    [countdownBackView addSubview:labelView];
    
    CutOutClearView *areaView = [[CutOutClearView alloc] initWithFrame:labelView.bounds];
    areaView.fillColor        = [UIColor clearColor];
    areaView.areaColor        = [UIColor whiteColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(offset, areaView.height)];
    [path addLineToPoint:CGPointMake(offset + gap, areaView.height)];
    [path addLineToPoint:CGPointMake(gap, 0)];
    [path addLineToPoint:CGPointMake(gap *2, 0)];
    [path addLineToPoint:CGPointMake(offset + gap *2, areaView.height)];
    [path addLineToPoint:CGPointMake(labelView.width - gap *2, areaView.height)];
    [path addLineToPoint:CGPointMake(labelView.width - offset - gap *2, 0)];
    [path addLineToPoint:CGPointMake(labelView.width - offset - gap, 0)];
    [path addLineToPoint:CGPointMake(labelView.width - gap, areaView.height)];
    [path addLineToPoint:CGPointMake(labelView.width, areaView.height)];
    [path addLineToPoint:CGPointMake(labelView.width - offset, 0)];
    [path closePath];
    areaView.paths = @[path];
    
    labelView.maskView = areaView;
    
    UILabel *countdownContentLabel = [UILabel createLabelWithFrame:labelView.bounds
                                                         labelType:kLabelNormal
                                                              text:@""
                                                              font:UIFont_15
                                                         textColor:MainColor
                                                     textAlignment:NSTextAlignmentCenter
                                                               tag:103];
    [labelView addSubview:countdownContentLabel];
    self.countdownLabel = countdownContentLabel;
    
    UIView *countdown_top_lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
    countdown_top_lineView.backgroundColor = LineColor;
    [countdownBackView addSubview:countdown_top_lineView];
    
    UIView *countdown_lineView = [[UIView alloc] initWithFrame:CGRectMake(0, countdownBackView.height - 0.5f, Screen_Width, 0.5)];
    countdown_lineView.backgroundColor = LineColor;
    [countdownBackView addSubview:countdown_lineView];
    
    UILabel *rushLabel = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"紧急"
                                                  font:UIFont_12
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:101];
    rushLabel.backgroundColor = CarOadColor(210, 33, 33);
    [self addSubview:rushLabel];
    [rushLabel sizeToFit];
    rushLabel.frame = CGRectMake(Screen_Width - 29 *Scale_Width - rushLabel.width, countdownBackView.y + countdownBackView.height + 11 *Scale_Height, rushLabel.width + 14 *Scale_Width, 18 *Scale_Height);
    rushLabel.layer.masksToBounds = YES;
    rushLabel.layer.cornerRadius  = 2.f *Scale_Width;
    self.rushLabel = rushLabel;
    self.rushLabel.hidden = YES;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, countdownBackView.y + countdownBackView.height + 10 *Scale_Height, rushLabel.x - 25 *Scale_Width, 20 *Scale_Height)
                                              labelType:kLabelNormal
                                                   text:@""
                                                   font:UIFont_16
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *priceLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, titleLabel.y + titleLabel.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 20 *Scale_Height)
                                              labelType:kLabelNormal
                                                   text:@"¥ 0"
                                                   font:UIFont_15
                                              textColor:[UIColor redColor]
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:103];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UIImageView *chackImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(priceLabel.x, priceLabel.y + priceLabel.height + 10 *Scale_Height, 20 *Scale_Height, 20 *Scale_Height)];
    chackImageView.contentMode   = UIViewContentModeScaleAspectFit;
    chackImageView.image         = [UIImage imageNamed:@"open_eyes_gray"];
    [self addSubview:chackImageView];
    
    UILabel *chackLabel = [UILabel createLabelWithFrame:CGRectMake(chackImageView.x + chackImageView.width + 5 *Scale_Width, chackImageView.y, 0, 0)
                                              labelType:kLabelNormal
                                                   text:@"0"
                                                   font:UIFont_13
                                              textColor:TextGrayColor
                                          textAlignment:NSTextAlignmentCenter
                                                    tag:101];
    [self addSubview:chackLabel];
    self.numberLabel = chackLabel;
    
    UILabel *publishDateLabel = [UILabel createLabelWithFrame:CGRectMake(chackLabel.x + chackLabel.width + 5 *Scale_Width, chackLabel.y, Screen_Width - (chackLabel.x + chackLabel.width + 20 *Scale_Width), 20 *Scale_Height)
                                                    labelType:kLabelNormal
                                                         text:@"发布于"
                                                         font:UIFont_15
                                                    textColor:TextBlackColor
                                                textAlignment:NSTextAlignmentRight
                                                          tag:103];
    [self addSubview:publishDateLabel];
    self.publishDateLabel = publishDateLabel;
    
    {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, chackImageView.y + chackImageView.height + 10 *Scale_Height, Screen_Width, 0.5)];
        lineView.backgroundColor = LineColor;
        [self addSubview:lineView];
        
        UILabel *carTypeLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:@"品牌车型："
                                                         font:UIFont_15
                                                    textColor:TextBlackColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:103];
        [self addSubview:carTypeLabel];
        [carTypeLabel sizeToFit];
        carTypeLabel.frame = CGRectMake(15 *Scale_Width, lineView.y + lineView.height + 10 *Scale_Height, carTypeLabel.width, 20 *Scale_Height);
        
        UILabel *carTypeContentLabel = [UILabel createLabelWithFrame:CGRectMake(carTypeLabel.x + carTypeLabel.width + 10 *Scale_Width, carTypeLabel.y, Screen_Width - (carTypeLabel.x + carTypeLabel.width + 25 *Scale_Width), 20 *Scale_Height)
                                                           labelType:kLabelNormal
                                                                text:@""
                                                                font:UIFont_15
                                                           textColor:TextGrayColor
                                                       textAlignment:NSTextAlignmentLeft
                                                                 tag:103];
        [self addSubview:carTypeContentLabel];
        self.carTypeLabel = carTypeContentLabel;
        
    }
    
    {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, chackImageView.y + chackImageView.height + 50 *Scale_Height, Screen_Width - 15 *Scale_Width, 0.5)];
        lineView.backgroundColor = LineColor;
        [self addSubview:lineView];
        
        UILabel *faultTypeTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                           labelType:kLabelNormal
                                                                text:@"故障类型："
                                                                font:UIFont_15
                                                           textColor:TextBlackColor
                                                       textAlignment:NSTextAlignmentLeft
                                                                 tag:103];
        [self addSubview:faultTypeTitleLabel];
        [faultTypeTitleLabel sizeToFit];
        faultTypeTitleLabel.frame = CGRectMake(15 *Scale_Width, lineView.y + lineView.height + 10 *Scale_Height, faultTypeTitleLabel.width, 20 *Scale_Height);
        
        UILabel *faultTypeContentLabel = [UILabel createLabelWithFrame:CGRectMake(faultTypeTitleLabel.x + faultTypeTitleLabel.width + 10 *Scale_Width, faultTypeTitleLabel.y, Screen_Width - (faultTypeTitleLabel.x + faultTypeTitleLabel.width + 25 *Scale_Width), 20 *Scale_Height)
                                                             labelType:kLabelNormal
                                                                  text:@""
                                                                  font:UIFont_15
                                                             textColor:TextGrayColor
                                                         textAlignment:NSTextAlignmentLeft
                                                                   tag:103];
        [self addSubview:faultTypeContentLabel];
        self.faultTypeLabel = faultTypeContentLabel;
        
    }
    
    {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, chackImageView.y + chackImageView.height + 90 *Scale_Height, Screen_Width - 15 *Scale_Width, 0.5)];
        lineView.backgroundColor = LineColor;
        [self addSubview:lineView];
        
        UILabel *endDateTitleLabel = [UILabel createLabelWithFrame:CGRectZero
                                                         labelType:kLabelNormal
                                                              text:@"结束时间："
                                                              font:UIFont_15
                                                         textColor:TextBlackColor
                                                     textAlignment:NSTextAlignmentLeft
                                                               tag:103];
        [self addSubview:endDateTitleLabel];
        [endDateTitleLabel sizeToFit];
        endDateTitleLabel.frame = CGRectMake(15 *Scale_Width, lineView.y + lineView.height + 10 *Scale_Height, endDateTitleLabel.width, 20 *Scale_Height);
        
        UILabel *endDateContentLabel = [UILabel createLabelWithFrame:CGRectMake(endDateTitleLabel.x + endDateTitleLabel.width + 10 *Scale_Width, endDateTitleLabel.y, Screen_Width - (endDateTitleLabel.x + endDateTitleLabel.width + 25 *Scale_Width), 20 *Scale_Height)
                                                           labelType:kLabelNormal
                                                                text:@""
                                                                font:UIFont_15
                                                           textColor:TextGrayColor
                                                       textAlignment:NSTextAlignmentLeft
                                                                 tag:103];
        [self addSubview:endDateContentLabel];
        self.endDateLabel = endDateContentLabel;
        
        self.frame = CGRectMake(0, 0, Screen_Width, endDateTitleLabel.y + endDateTitleLabel.height + 10 *Scale_Height);
        
    }
    
}

- (void)layoutSubviews {
    
    [self.numberLabel sizeToFit];
    CGRect frame = self.numberLabel.frame;
    frame.size.width = self.numberLabel.width;
    frame.size.height = 20 *Scale_Height;
    self.numberLabel.frame = frame;
    
    self.publishDateLabel.frame = CGRectMake(self.numberLabel.x + self.numberLabel.width + 5 *Scale_Width, self.numberLabel.y, Screen_Width - (self.numberLabel.x + self.numberLabel.width + 20 *Scale_Width), 20 *Scale_Height);
    
}

- (void)loadContent; {

    MyOrderDetailsData *model = self.data;
    NSArray *imageStringArray = [model.demandImgName componentsSeparatedByString:@","];
    
    NSMutableArray *tmpImageArray = [NSMutableArray array];
    
    for (NSString *imageString in imageStringArray) {
        
        if (imageString.length > 0) {
            
            [tmpImageArray addObject:imageString];
            
        }
        
    }
    
    self.cycleScrollView.imageURLStringsGroup = [tmpImageArray copy];
    
    if (model.demandTitle.length > 0) {
        
        self.titleLabel.text = model.demandTitle;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if ([model.URGLevel isEqualToString:@"Y"]) {
        
        self.rushLabel.hidden = NO;
        
    } else {
        
        self.rushLabel.hidden = YES;
        
    }
    
    if (model.price.length > 0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
        
    } else {
        
        self.priceLabel.text = @"¥ 0";
        
    }
    
    if (model.clickNum.length > 0) {
        
        self.numberLabel.text = model.clickNum;
        
    } else {
        
        self.numberLabel.text = @"";
        
    }
    
    if (model.publicDate.length > 0) {
        
        self.publishDateLabel.text = [NSString stringWithFormat:@"发布于 %@",model.publicDate];
        
    } else {
        
        self.publishDateLabel.text = @"发布于";
        
    }
    
    if (model.carType.length > 0) {
        
        self.carTypeLabel.text = model.carType;
        
    } else {
        
        self.carTypeLabel.text = @"";
        
    }
    
    if (model.demandType.length > 0) {
        
        self.faultTypeLabel.text = model.demandType;
        
    } else {
        
        self.faultTypeLabel.text = @"";
        
    }
    
    if (model.endDate.length > 0) {
        
        self.endDateLabel.text = model.endDate;
        
    } else {
        
        self.endDateLabel.text = @"";
        
    }
    
}

- (void)dealloc {
    
    [self removeNSNotificationCenter];
}

#pragma mark - SDCycleScrollViewDelegate
- (void) cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    MyOrderDetailsData *model = self.data;
    NSArray *imageStringArray = [model.demandImgName componentsSeparatedByString:@","];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (NSString *imageString in imageStringArray) {
        
        if (imageString.length > 0) {
            
            [imageArray addObject:imageString];
            
        }
        
    }
    
    if (imageArray.count > 0) {
        
        [_delegate clickChankImageWithImageArray:[imageArray copy] tag:index];
        
    }
    
}

#pragma mark - 通知中心
- (void)registerNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:NSNotificationDetailsCountDownTimeCell
                                               object:nil];
    
}

- (void)removeNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationDetailsCountDownTimeCell object:nil];
    
}

- (void)notificationCenterEvent:(id)sender {
    
    [self loadTimeContent];
    
}

- (void) loadTimeContent; {
    
    MyOrderDetailsData *model = self.data;
    self.countdownLabel.text  = [model currentTimeString];
    
}

@end
