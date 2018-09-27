//
//  HomePageBulletinCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "HomePageBulletinCell.h"

@interface HomePageBulletinCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIImageView       *iconImageView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIImageView       *moreImageView;

@property (nonatomic, strong) UIView *left_h_lineView;
@property (nonatomic, strong) UIView *right_h_lineView;

@end

@implementation HomePageBulletinCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.iconImageView              = [[UIImageView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 0, 80 *Scale_Width, 40 *Scale_Height)];
    self.iconImageView.contentMode  = UIViewContentModeScaleAspectFit;
    self.iconImageView.image        = [UIImage imageNamed:@"letters_logo"];
    [self.contentView addSubview:self.iconImageView];

    self.left_h_lineView                 = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.x + self.iconImageView.width + 10 *Scale_Width, 10 *Scale_Height, 1.f, 40 *Scale_Height - 20 *Scale_Height)];
    self.left_h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.left_h_lineView];

    self.moreImageView              = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 18 *Scale_Height - 16 *Scale_Width, 17.5 *Scale_Height, 18 *Scale_Height, 5 *Scale_Height)];
    self.moreImageView.contentMode  = UIViewContentModeScaleAspectFit;
    self.moreImageView.image        = [UIImage imageNamed:@"more_button"];
    [self.contentView addSubview:self.moreImageView];

    self.right_h_lineView                 = [[UIView alloc] initWithFrame:CGRectMake(self.moreImageView.x - 16 *Scale_Width, 10 *Scale_Height, 1.f, 40 *Scale_Height - 20 *Scale_Height)];
    self.right_h_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.right_h_lineView];

    SDCycleScrollView * cycleScrollView       = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(self.left_h_lineView.x + self.left_h_lineView.width + 5 *Scale_Width, 0, self.right_h_lineView.x - (self.left_h_lineView.x + self.left_h_lineView.width + 10 *Scale_Width), 40 *Scale_Height)];
    cycleScrollView.delegate                  = self;
    cycleScrollView.backgroundColor           = [UIColor clearColor];
    cycleScrollView.showPageControl           = NO;
    cycleScrollView.onlyDisplayText           = YES;
    cycleScrollView.autoScrollTimeInterval    = 4;
    cycleScrollView.titleLabelTextColor       = TextBlackColor;
    cycleScrollView.titleLabelTextFont        = UIFont_14;
    cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
    cycleScrollView.titleLabelTextAlignment   = NSTextAlignmentLeft;
    cycleScrollView.scrollDirection           = UICollectionViewScrollDirectionVertical;
    [self.contentView addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;

}

- (void) loadContent {
    
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];

    NSArray *dataArray = self.data;

    for (NSDictionary *model in dataArray) {

        NSString *title = model[@"infoTitle"];

        if (title.length > 0) {
            
            [titleArray addObject:title];
            
        }
        
    }
    
    self.cycleScrollView.titlesGroup = [titleArray copy];
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void) cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSArray *dataArray = self.data;
    NSDictionary *model = dataArray[index];
    
    [self.delegate clickChankBulletinDetailsWithData:model];
    
}

@end
