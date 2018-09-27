//
//  ChooseNeedInfomationCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseNeedInfomationCell.h"

#import "ChooseNeedInfomationItemCell.h"

@interface ChooseNeedInfomationCell()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, strong) UIView           *lineView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *datasArray;

@end

@implementation ChooseNeedInfomationCell

- (NSMutableArray *)datasArray {

    if (_datasArray == nil) {

        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    if (self) {

        [self initSubViews];

    }

    return self;

}

- (void) initSubViews {

    self.contentView.backgroundColor = [UIColor whiteColor];

    // 初始化布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset                = UIEdgeInsetsMake(10 *Scale_Height, 12 *Scale_Width, 10 *Scale_Height, 12 *Scale_Width);
    layout.minimumLineSpacing          = 10 *Scale_Height;
    layout.minimumInteritemSpacing     = 0;
    layout.scrollDirection             = UICollectionViewScrollDirectionVertical;

    // 初始化collectionView
    self.collectionView               = \
    [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 90)
                       collectionViewLayout:layout];

    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.dataSource       = self;
    self.collectionView.delegate         = self;
    self.collectionView.backgroundColor  = [UIColor whiteColor];
    self.collectionView.scrollEnabled    = NO;
    [self.contentView addSubview:self.collectionView];

    // 注册cell
    [self.collectionView registerClass:[ChooseNeedInfomationItemCell class] forCellWithReuseIdentifier:@"ChooseNeedInfomationItemCell"];

}

- (void) layoutSubviews {

    [super layoutSubviews];
    
    self.collectionView.frame = self.contentView.bounds;

}

- (void) loadContent {

    NSDictionary *modelArray = self.data;

    self.datasArray = modelArray[@"item"];

    [self.collectionView reloadData];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {

    return self.datasArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ChooseNeedInfomationItemCell *cell = \
    [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseNeedInfomationItemCell"
                                              forIndexPath:indexPath];
    cell.data = self.datasArray[indexPath.item];
    [cell loadContent];

    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake((Screen_Width - 54 *Scale_Width) / 4, 24 *Scale_Height);

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *model    = self.data;
    NSString     *cell_tag = model[@"cell_tag"];
    [_delegate selectedItemsWithItem:indexPath.item cell_tag:[cell_tag integerValue]];

}

@end
