//
//  EdiJobStatusChooseView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "EdiJobStatusChooseView.h"

@interface EdiJobStatusChooseView()<UIPickerViewDelegate, UIPickerViewDataSource>
{

    NSArray *datasArray;
    NSArray *dataTitlesArray;
    CGRect stareRect;
    CGRect endRect;

}

@property (nonatomic, strong) UIPickerView *pickView;

@end

@implementation EdiJobStatusChooseView

- (void)buildsubview {

    datasArray = self.data;

    NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];

    for (NSDictionary *model in datasArray) {

        NSString *title = model[@"title"];

        [tmpDataArray addObject:title];

    }
    dataTitlesArray = [tmpDataArray copy];

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

    NSDictionary *titleDic = datasArray[0];
    [_delegate getSelectedData:titleDic];

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

    return 1;

}

// 返回每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {

    return dataTitlesArray.count;

}

// 返回每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return dataTitlesArray[row];
}

// 反回pickerView的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED; {

    return self.width;

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
        [pickerLabel setFont:UIFont_18];
        pickerLabel.textColor = TextBlackColor;
    }

    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

// 选中行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED; {

    NSDictionary *titleDic = datasArray[row];

    [_delegate getSelectedData:titleDic];

}

@end
