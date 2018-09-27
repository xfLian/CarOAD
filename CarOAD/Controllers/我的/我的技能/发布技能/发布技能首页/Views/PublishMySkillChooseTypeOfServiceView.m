//
//  PublishMySkillChooseTypeOfServiceView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "PublishMySkillChooseTypeOfServiceView.h"

@interface PublishMySkillChooseTypeOfServiceView()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    CGRect stareRect;
    CGRect endRect;
    
    NSString *selectedCategoryId;
    NSString *selectedCatenaId;
    
    NSInteger firstRow;
    NSInteger secondRow;
    NSInteger thirdRow;
    
}

@property (nonatomic, strong) NSArray *firstDatasArray;
@property (nonatomic, strong) NSArray *secondDatasArray;
@property (nonatomic, strong) NSArray *thirdDatasArray;
@property (nonatomic, strong) UIPickerView *pickView;

@end

@implementation PublishMySkillChooseTypeOfServiceView

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
    
    UIView *topLineView         = [[UIView alloc]initWithFrame:CGRectMake(0, pickView.height / 2 - 25 *Scale_Height, pickView.width, 0.7 *Scale_Width)];
    topLineView.backgroundColor = LineColor;
    [pickView addSubview:topLineView];
    
    UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, pickView.height / 2 + 25 *Scale_Height, pickView.width, 0.7 *Scale_Width)];
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
    [self requestPost_getTypeOfServiceDataWithType:1 typeId:nil];
    
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
        NSString     *title = model[@"category"];
        
        return title;
        
    } else if (component == 1) {
        
        NSDictionary *model = self.secondDatasArray[row];
        NSString     *title = model[@"catena"];
        
        return title;
        
    } else {
        
        NSDictionary *model = self.thirdDatasArray[row];
        NSString     *title = model[@"CategoryInfo"];
        
        return title;
        
    }
    
}

// 反回pickerView的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED; {
    
    return self.width / 3;
    
}

// 返回pickerView的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED; {
    
    return 50 *Scale_Height;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.frame = CGRectMake(0, 0, Screen_Width / 3 - 30 *Scale_Width, pickerView.height);
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.numberOfLines = 2;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:UIFont_15];
        pickerLabel.textColor = CarOadColor(20, 20, 20);
        pickerLabel.adjustsFontSizeToFitWidth = YES;
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
        NSString     *categoryId = model[@"categoryId"];
        selectedCategoryId = categoryId;
        
        [self requestPost_getTypeOfServiceDataWithType:2 typeId:categoryId];
        
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
        NSString     *catenaId = model[@"catenaId"];
        
        selectedCatenaId = catenaId;
        
        [self requestPost_getTypeOfServiceDataWithType:3 typeId:catenaId];
        
    } else {
        
        thirdRow = row;
        
        if (self.firstDatasArray.count > 0 && self.secondDatasArray.count > 0 && self.thirdDatasArray.count > 0) {
            
            [_delegate getSelectedCategoryData:self.firstDatasArray[firstRow]
                                      catenaData:self.secondDatasArray[secondRow]
                                      categoryInfoData:self.thirdDatasArray[thirdRow]];
            
        } else {
            
            [_delegate getSelectedCategoryData:self.firstDatasArray[firstRow]
                                      catenaData:nil
                                      categoryInfoData:nil];
            
        }
        
    }
    
}

- (void)requestPost_getTypeOfServiceDataWithType:(NSInteger)type typeId:(NSString *)typeId;
{
    
    if (type == 1) {
        
        [[ChooseTypeOfServiceTool new] getTypeOfServiceDataWithType:1 categoryId:nil catenaId:nil success:^(id info, NSInteger count) {
            
            self.firstDatasArray = info;
            [self.pickView reloadComponent:0];
            
            NSDictionary *model      = self.firstDatasArray[0];
            NSString     *categoryId = model[@"categoryId"];
            
            selectedCategoryId = categoryId;
            [self requestPost_getTypeOfServiceDataWithType:2 typeId:categoryId];
            
        } error:^(NSString *errorMessage) {
            
        } failure:^(NSError *error) {
            
        }];
        
    } else if (type == 2) {
        
        [[ChooseTypeOfServiceTool new] getTypeOfServiceDataWithType:2 categoryId:typeId catenaId:nil success:^(id info, NSInteger count) {
            
            self.secondDatasArray = info;
            [self.pickView reloadComponent:1];
            
            NSDictionary *model  = self.secondDatasArray[0];
            NSString     *catenaId = model[@"catenaId"];
            
            selectedCatenaId = catenaId;
            
            [self requestPost_getTypeOfServiceDataWithType:3 typeId:catenaId];
            
        } error:^(NSString *errorMessage) {
            
        } failure:^(NSError *error) {
            
        }];
        
    } else if (type == 3) {

        [[ChooseTypeOfServiceTool new] getTypeOfServiceDataWithType:3 categoryId:selectedCategoryId catenaId:typeId success:^(id info, NSInteger count) {
            
            self.thirdDatasArray = info;
            [self.pickView reloadComponent:2];
            
            if (self.firstDatasArray.count > 0 && self.secondDatasArray.count > 0 && self.thirdDatasArray.count > 0) {
                
                [_delegate getSelectedCategoryData:self.firstDatasArray[firstRow]
                                          catenaData:self.secondDatasArray[secondRow]
                                          categoryInfoData:self.thirdDatasArray[thirdRow]];
                
            } else {
                
                [_delegate getSelectedCategoryData:self.firstDatasArray[firstRow]
                                          catenaData:nil
                                          categoryInfoData:nil];
                
            }
            
        } error:^(NSString *errorMessage) {
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}

@end
