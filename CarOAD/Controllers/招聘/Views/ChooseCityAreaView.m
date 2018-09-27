//
//  ChooseCityAreaView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseCityAreaView.h"

#import "ChooseCityAreaCell.h"

@interface ChooseCityAreaView()<UITableViewDelegate, UITableViewDataSource>
{

    NSInteger firstRow;
    NSInteger secondRow;
    NSInteger thirdRow;

    NSString *tmp_selectedProvinceId;
    NSString *tmp_selectedCityId;

}
@property (nonatomic, strong) UITableView *firstTableView;
@property (nonatomic, strong) UITableView *secondTableView;
@property (nonatomic, strong) UITableView *thirdTableView;

@property (nonatomic, strong) NSArray *firstDatasArray;
@property (nonatomic, strong) NSArray *secondDatasArray;
@property (nonatomic, strong) NSArray *thirdDatasArray;

@end

@implementation ChooseCityAreaView

- (void)buildSubview {
    
    UITableView *firstTableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width / 3, self.height) style:UITableViewStylePlain];
    firstTableView.backgroundColor = [UIColor whiteColor];
    firstTableView.delegate        = self;
    firstTableView.dataSource      = self;
    firstTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    firstTableView.tag             = 100;
    [self addSubview:firstTableView];
    self.firstTableView = firstTableView;

    UITableView *secondTableView    = [[UITableView alloc] initWithFrame:CGRectMake(self.width / 3, 0, self.width / 3, self.height) style:UITableViewStylePlain];
    secondTableView.backgroundColor = [UIColor whiteColor];
    secondTableView.delegate        = self;
    secondTableView.dataSource      = self;
    secondTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    secondTableView.tag             = 101;
    [self addSubview:secondTableView];
    self.secondTableView = secondTableView;
    
    UITableView *thirdTableView    = [[UITableView alloc] initWithFrame:CGRectMake(self.width / 3 *2, 0, self.width / 3, self.height) style:UITableViewStylePlain];
    thirdTableView.backgroundColor = [UIColor whiteColor];
    thirdTableView.delegate        = self;
    thirdTableView.dataSource      = self;
    thirdTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    thirdTableView.tag             = 102;
    [self addSubview:thirdTableView];
    self.thirdTableView = thirdTableView;

    [firstTableView registerClass:[ChooseCityAreaCell class] forCellReuseIdentifier:@"FirstChooseCityAreaCell"];
    [secondTableView registerClass:[ChooseCityAreaCell class] forCellReuseIdentifier:@"SecondChooseCityAreaCell"];
    [thirdTableView registerClass:[ChooseCityAreaCell class] forCellReuseIdentifier:@"ThirdChooseCityAreaCell"];

    UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(self.width / 3, 0, 0.5f, self.height)];
    leftLineView.backgroundColor = LineColor;
    [self addSubview:leftLineView];

    UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectMake(self.width / 3 *2, 0, 0.5f, self.height)];
    rightLineView.backgroundColor = LineColor;
    [self addSubview:rightLineView];

}

- (void)loadContent {

    firstRow  = 0;
    secondRow = 0;
    thirdRow  = 0;

    [self requestPost_getCityAreaDataWithType:1 cityId:nil];
    
}

- (void)requestPost_getCityAreaDataWithType:(NSInteger)type cityId:(NSString *)cityId;
{

    if (type == 1) {
        
        [[ChooseCityAreaTool new] getCityAreaDataWithType:1 provinceId:nil cityId:nil success:^(id info, NSInteger count) {

            self.firstDatasArray = info;
            [self.firstTableView reloadData];

            NSDictionary *selectedData         = self.selectedData;
            NSDictionary *selectedProvinceData = selectedData[@"selectedProvince"];
            NSString     *selectedProvinceId   = selectedProvinceData[@"provinceid"];

            if (selectedProvinceId.length > 0 && self.firstDatasArray.count > 0) {

                for (int i = 0; i < self.firstDatasArray.count; i++) {

                    NSDictionary *provinceData = self.firstDatasArray[i];
                    NSString     *provinceId = provinceData[@"provinceid"];

                    if ([provinceId isEqualToString:selectedProvinceId]) {
                        
                        firstRow = i;

                        NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.firstTableView selectRowAtIndexPath:selectedPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                        
                        tmp_selectedProvinceId = selectedProvinceId;
                        
                        [self requestPost_getCityAreaDataWithType:2 cityId:selectedProvinceId];

                    }

                }

            }

        } error:^(NSString *errorMessage) {

        } failure:^(NSError *error) {

        }];

    } else if (type == 2) {

        [[ChooseCityAreaTool new] getCityAreaDataWithType:2 provinceId:cityId cityId:nil success:^(id info, NSInteger count) {

            NSArray *tmpSecondDatasArray = info;

            self.secondDatasArray = tmpSecondDatasArray;
            [self.secondTableView reloadData];

            NSDictionary *selectedData     = self.selectedData;
            NSDictionary *selectedCityData = selectedData[@"selectedCity"];
            NSString     *selectedCityId   = selectedCityData[@"cityid"];

            if (selectedCityId.length > 0 && self.secondDatasArray.count > 0) {

                for (int i = 0; i < self.secondDatasArray.count; i++) {

                    NSDictionary *cityData = self.secondDatasArray[i];
                    NSString     *cityId   = cityData[@"cityid"];

                    if ([cityId isEqualToString:selectedCityId]) {
                        
                        secondRow = i;

                        NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.secondTableView selectRowAtIndexPath:selectedPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                        
                        tmp_selectedCityId = selectedCityId;
                        
                        [self requestPost_getCityAreaDataWithType:3 cityId:selectedCityId];

                    }

                }

            }

        } error:^(NSString *errorMessage) {

        } failure:^(NSError *error) {

        }];

    } else if (type == 3) {

        [[ChooseCityAreaTool new] getCityAreaDataWithType:3 provinceId:tmp_selectedProvinceId cityId:tmp_selectedCityId success:^(id info, NSInteger count) {

            NSArray *tmpThirdDatasArray = info;

            self.thirdDatasArray = tmpThirdDatasArray;
            [self.thirdTableView reloadData];

            NSDictionary *selectedData     = self.selectedData;
            NSDictionary *selectedAreaData = selectedData[@"selectedArea"];
            NSString     *selectedAreaId   = selectedAreaData[@"areaId"];

            if (selectedAreaId.length > 0 && self.thirdDatasArray.count > 0) {

                for (int i = 0; i < self.thirdDatasArray.count; i++) {

                    NSDictionary *areaData = self.thirdDatasArray[i];
                    NSString     *areaId   = areaData[@"areaId"];

                    if ([areaId isEqualToString:selectedAreaId]) {
                        
                        thirdRow = i;

                        NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.thirdTableView selectRowAtIndexPath:selectedPath animated:YES scrollPosition:UITableViewScrollPositionNone];

                    }

                }

            }

        } error:^(NSString *errorMessage) {

        } failure:^(NSError *error) {

        }];

    }

}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView.tag == 100) {

        return self.firstDatasArray.count;

    } else if (tableView.tag == 101) {

        return self.secondDatasArray.count;

    } else {

        return self.thirdDatasArray.count;

    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView.tag == 100) {

        ChooseCityAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstChooseCityAreaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (self.firstDatasArray.count > 0) {

            NSDictionary *model = self.firstDatasArray[indexPath.row];
            cell.data = model[@"province"];
            [cell loadContent];

        }
        return cell;

    } else if (tableView.tag == 101) {

        ChooseCityAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondChooseCityAreaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (self.secondDatasArray.count > 0) {
            NSDictionary *model = self.secondDatasArray[indexPath.row];
            cell.data = model[@"city"];
            [cell loadContent];

        }
        return cell;

    } else {

        ChooseCityAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdChooseCityAreaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (self.thirdDatasArray.count > 0) {
            NSDictionary *model = self.thirdDatasArray[indexPath.row];
            cell.data = model[@"area"];
            [cell loadContent];

        }
        return cell;

    }

}

//  cell的点击方法
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView.tag == 100) {

        firstRow = indexPath.row;

        {

            NSMutableArray *tmpSecondDatasArray = [[NSMutableArray alloc] init];
            tmpSecondDatasArray                 = [self.secondDatasArray mutableCopy];
            [tmpSecondDatasArray removeAllObjects];
            self.secondDatasArray               = [tmpSecondDatasArray copy];
            [self.secondTableView reloadData];

        }

        {

            NSMutableArray *tmpThirdDatasArray = [[NSMutableArray alloc] init];
            tmpThirdDatasArray                 = [self.thirdDatasArray mutableCopy];
            [tmpThirdDatasArray removeAllObjects];
            self.thirdDatasArray               = [tmpThirdDatasArray copy];
            [self.thirdTableView reloadData];

        }

        NSDictionary *model = self.firstDatasArray[indexPath.row];
        NSString *provinceId = model[@"provinceid"];
        
        tmp_selectedProvinceId = provinceId;
        [self requestPost_getCityAreaDataWithType:2 cityId:provinceId];

    } else if (tableView.tag == 101) {

        secondRow = indexPath.row;
        
        {

            NSMutableArray *tmpThirdDatasArray = [[NSMutableArray alloc] init];
            tmpThirdDatasArray                 = [self.thirdDatasArray mutableCopy];
            [tmpThirdDatasArray removeAllObjects];
            self.thirdDatasArray               = [tmpThirdDatasArray copy];
            [self.thirdTableView reloadData];

        }

        NSDictionary *model = self.secondDatasArray[indexPath.row];
        NSString *cityId = model[@"cityid"];
        
        tmp_selectedCityId = cityId;
        [self requestPost_getCityAreaDataWithType:3 cityId:cityId];

    } else {

        thirdRow = indexPath.row;
        NSDictionary *provinceData = self.firstDatasArray[firstRow];
        NSDictionary *cityData     = self.secondDatasArray[secondRow];
        NSDictionary *areaData     = self.thirdDatasArray[thirdRow];

        [_delegate choosedProvinceData:provinceData cityData:cityData areaData:areaData];
        
    }

}

@end
