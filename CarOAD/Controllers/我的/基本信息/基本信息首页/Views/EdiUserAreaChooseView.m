//
//  EdiUserAreaChooseView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "EdiUserAreaChooseView.h"

@interface EdiUserAreaChooseView()<UIPickerViewDelegate, UIPickerViewDataSource>
{

    CGRect stareRect;
    CGRect endRect;

    NSString *selectedProvinceId;
    NSString *selectedCityId;

    NSInteger firstRow;
    NSInteger secondRow;
    NSInteger thirdRow;

}

@property (nonatomic, strong) NSArray *firstDatasArray;
@property (nonatomic, strong) NSArray *secondDatasArray;
@property (nonatomic, strong) NSArray *thirdDatasArray;
@property (nonatomic, strong) UIPickerView *pickView;

@end

@implementation EdiUserAreaChooseView

- (void)buildsubview {
    
    UIPickerView *pickView           = [[UIPickerView alloc] initWithFrame:self.bounds];
    pickView.showsSelectionIndicator = YES;
    pickView.backgroundColor         = [UIColor whiteColor];
    pickView.alpha                   = 1.f;
    pickView.delegate                = self;
    pickView.dataSource              = self;
    [self addSubview:pickView];
    [pickView reloadAllComponents];
    self.pickView = pickView;

    UIView *topLineView         = [[UIView alloc]initWithFrame:CGRectMake(0, pickView.height / 2 - 20 *Scale_Height, pickView.width, 0.7 *Scale_Width)];
    topLineView.backgroundColor = LineColor;
    [pickView addSubview:topLineView];

    UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, pickView.height / 2 + 20 *Scale_Height, pickView.width, 0.7 *Scale_Width)];
    lineView.backgroundColor = LineColor;
    [pickView addSubview:lineView];

    endRect = pickView.frame;

    CGRect frame   = pickView.frame;
    frame.origin.y = self.height;
    pickView.frame = frame;
    stareRect      = frame;

    firstRow  = 0;
    secondRow = 0;
    thirdRow  = 0;
    [self requestPost_getCityAreaDataWithType:1 cityId:nil];

}

- (void) showWithDuration:(CGFloat)duration animations:(BOOL)animations; {

    [UIView animateWithDuration:duration animations:^{

        self.pickView.frame = endRect;

    } completion:^(BOOL finished) {

    }];

}

- (void) hideWithDuration:(CGFloat)duration animations:(BOOL)animations; {

    [UIView animateWithDuration:duration animations:^{

        self.pickView.frame = stareRect;

    } completion:^(BOOL finished) {

    }];

}

// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; {

    return 3;

}

// 返回每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {

    if (component == 0) {

        return self.firstDatasArray.count;

    } else if (component == 1) {

        return self.secondDatasArray.count;

    } else {

        return self.thirdDatasArray.count;

    }

}

// 返回每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if (component == 0) {

        NSDictionary *model = self.firstDatasArray[row];
        NSString     *title = model[@"province"];

        return title;

    } else if (component == 1) {

        NSDictionary *model = self.secondDatasArray[row];
        NSString     *title = model[@"city"];

        return title;

    } else {

        NSDictionary *model = self.thirdDatasArray[row];
        NSString     *title = model[@"area"];

        return title;

    }

}

// 反回pickerView的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED; {

    return self.width / 3;

}

// 返回pickerView的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED; {

    return 40 *Scale_Height;

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:UIFont_17];
        pickerLabel.textColor = TextBlackColor;
    }

    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

// 选中行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED; {

    if (component == 0) {

        firstRow = row;
        secondRow = 0;
        thirdRow  = 0;

        {

            NSMutableArray *tmpSecondDatasArray = [[NSMutableArray alloc] init];
            tmpSecondDatasArray                 = [self.secondDatasArray mutableCopy];
            [tmpSecondDatasArray removeAllObjects];
            self.secondDatasArray               = [tmpSecondDatasArray copy];
            [self.pickView reloadComponent:1];

        }

        {

            NSMutableArray *tmpThirdDatasArray = [[NSMutableArray alloc] init];
            tmpThirdDatasArray                 = [self.thirdDatasArray mutableCopy];
            [tmpThirdDatasArray removeAllObjects];
            self.thirdDatasArray               = [tmpThirdDatasArray copy];
            [self.pickView reloadComponent:2];

        }

        NSDictionary *model      = self.firstDatasArray[row];
        NSString     *provinceId = model[@"provinceid"];
        selectedProvinceId = provinceId;

        [self requestPost_getCityAreaDataWithType:2 cityId:provinceId];

    } else if (component == 1) {

        secondRow = row;
        thirdRow  = 0;

        {

            NSMutableArray *tmpThirdDatasArray = [[NSMutableArray alloc] init];
            tmpThirdDatasArray                 = [self.thirdDatasArray mutableCopy];
            [tmpThirdDatasArray removeAllObjects];
            self.thirdDatasArray               = [tmpThirdDatasArray copy];
            [self.pickView reloadComponent:2];

        }

        NSDictionary *model  = self.secondDatasArray[row];
        NSString     *cityId = model[@"cityid"];

        selectedCityId = cityId;

        [self requestPost_getCityAreaDataWithType:3 cityId:cityId];

    } else {

        thirdRow = row;

        if (self.firstDatasArray.count > 0 && self.secondDatasArray.count > 0 && self.thirdDatasArray.count > 0) {

            [_delegate getSelectedProvinceData:self.firstDatasArray[firstRow]
                                      cityData:self.secondDatasArray[secondRow]
                                      areaData:self.thirdDatasArray[thirdRow]];

        } else {

            [_delegate getSelectedProvinceData:self.firstDatasArray[firstRow]
                                      cityData:nil
                                      areaData:nil];

        }

    }

}

- (void)requestPost_getCityAreaDataWithType:(NSInteger)type cityId:(NSString *)cityId;
{

    if (type == 1) {

        [[ChooseCityAreaTool new] getCityAreaDataWithType:1 provinceId:nil cityId:nil success:^(id info, NSInteger count) {

            NSMutableArray *tmp_datasArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *model in info) {
                
                [tmp_datasArray addObject:model];
                
            }
            
            NSDictionary *tmp_model      = tmp_datasArray[0];
            NSString     *tmp_provinceId = tmp_model[@"provinceid"];
            
            if ([tmp_provinceId integerValue] == 0) {
                
                [tmp_datasArray removeObjectAtIndex:0];
                
            }
            
            self.firstDatasArray = [tmp_datasArray copy];
            [self.pickView reloadComponent:0];

            NSDictionary *model      = self.firstDatasArray[0];
            NSString     *provinceId = model[@"provinceid"];
            
            selectedProvinceId = provinceId;
            
            [self requestPost_getCityAreaDataWithType:2 cityId:provinceId];
            
        } error:^(NSString *errorMessage) {

        } failure:^(NSError *error) {

        }];

    } else if (type == 2) {

        [[ChooseCityAreaTool new] getCityAreaDataWithType:2 provinceId:cityId cityId:nil success:^(id info, NSInteger count) {
            
            NSMutableArray *tmp_datasArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *model in info) {
                
                [tmp_datasArray addObject:model];
                
            }
            
            NSDictionary *tmp_model  = tmp_datasArray[0];
            NSString     *tmp_cityId = tmp_model[@"cityid"];
            
            if ([tmp_cityId integerValue] == 0) {
                
                [tmp_datasArray removeObjectAtIndex:0];
                
            }
            
            self.secondDatasArray = [tmp_datasArray copy];
            [self.pickView reloadComponent:1];

            NSDictionary *model  = self.secondDatasArray[0];
            NSString     *cityId = model[@"cityid"];

            selectedCityId = cityId;

            [self requestPost_getCityAreaDataWithType:3 cityId:cityId];

        } error:^(NSString *errorMessage) {

        } failure:^(NSError *error) {

        }];

    } else if (type == 3) {
        
        [[ChooseCityAreaTool new] getCityAreaDataWithType:3 provinceId:selectedProvinceId cityId:cityId success:^(id info, NSInteger count) {
            
            NSMutableArray *tmp_datasArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *model in info) {
                
                [tmp_datasArray addObject:model];
                
            }
            
            NSDictionary *tmp_model  = tmp_datasArray[0];
            NSString     *tmp_areaId = tmp_model[@"areaId"];
            
            if ([tmp_areaId integerValue] == 0) {
                
                [tmp_datasArray removeObjectAtIndex:0];
                
            }
            
            self.thirdDatasArray = [tmp_datasArray copy];
            [self.pickView reloadComponent:2];

            if (self.firstDatasArray.count > 0 && self.secondDatasArray.count > 0 && self.thirdDatasArray.count > 0) {

                [_delegate getSelectedProvinceData:self.firstDatasArray[firstRow]
                                          cityData:self.secondDatasArray[secondRow]
                                          areaData:self.thirdDatasArray[thirdRow]];

            } else {

                [_delegate getSelectedProvinceData:self.firstDatasArray[firstRow]
                                          cityData:nil
                                          areaData:nil];

            }

        } error:^(NSString *errorMessage) {

        } failure:^(NSError *error) {

        }];

    }

}

@end
