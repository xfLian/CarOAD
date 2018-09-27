//
//  OADChooseCarTypeViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/7.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "OADChooseCarTypeViewController.h"

#import "ChooseCarTypeLeftCell.h"
#import "ChooseCarTypeRightCell.h"

@interface OADChooseCarTypeViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
    NSArray *firstDatasArray;
    NSArray *secondDatasArray;
    
    NSInteger firstRow;
    NSInteger secondRow;
    
    NSString *selectedBrandId;
    
}
@property (nonatomic, strong) UITableView *firstTableView;
@property (nonatomic, strong) UITableView *secondTableView;

@end

@implementation OADChooseCarTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void)setNavigationController {
    
    self.navTitle = @"选择车辆品牌";
    
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    UITableView *firstTableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width *2 / 5, self.contentView.height) style:UITableViewStylePlain];
    firstTableView.backgroundColor = [UIColor whiteColor];
    firstTableView.delegate        = self;
    firstTableView.dataSource      = self;
    firstTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    firstTableView.tag             = 100;
    [self.contentView addSubview:firstTableView];
    self.firstTableView = firstTableView;
    
    UITableView *secondTableView    = [[UITableView alloc] initWithFrame:CGRectMake(self.contentView.width *2 / 5, 0, self.contentView.width *3 / 5, self.contentView.height) style:UITableViewStylePlain];
    secondTableView.backgroundColor = [UIColor whiteColor];
    secondTableView.delegate        = self;
    secondTableView.dataSource      = self;
    secondTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    secondTableView.tag             = 101;
    [self.contentView addSubview:secondTableView];
    self.secondTableView = secondTableView;
    
    [firstTableView registerClass:[ChooseCarTypeLeftCell class] forCellReuseIdentifier:@"ChooseCarTypeLeftCell"];
    [secondTableView registerClass:[ChooseCarTypeRightCell class] forCellReuseIdentifier:@"ChooseCarTypeRightCell"];
    
    UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.width *2 / 5, 0, 0.5f, self.contentView.height)];
    leftLineView.backgroundColor = LineColor;
    [self.contentView addSubview:leftLineView];
    
}

- (void)initialization {
    
    firstRow  = 0;
    secondRow = 0;
    
    [self requestPost_getCarDataWithType:1 brandId:nil];
    
}

- (void) requestPost_getCarDataWithType:(NSInteger)type brandId:(NSString *)brandId {
    
    [[ChooseCarBrandOrTypeTool new] getCarBrandOrTypeDataWithType:type brandId:brandId success:^(id info, NSInteger count) {
        
        if (type == 1) {
            
            firstDatasArray = info;
            [self.firstTableView reloadData];
            
            NSDictionary *selectedData      = self.selectedData;
            NSDictionary *selectedBrandData = selectedData[@"selectedCarBrand"];
            NSString     *selectedBrandId   = selectedBrandData[@"brandId"];
            
            if (selectedBrandId.length > 0 && firstDatasArray.count > 0) {
                
                for (int i = 0; i < firstDatasArray.count; i++) {
                    
                    NSDictionary *brandData = firstDatasArray[i];
                    NSString     *brandId   = brandData[@"brandId"];
                    
                    if ([brandId isEqualToString:selectedBrandId]) {
                        
                        firstRow = i;
                        
                        NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.firstTableView selectRowAtIndexPath:selectedPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                        
                        [self requestPost_getCarDataWithType:2 brandId:selectedBrandId];
                        
                        selectedBrandId = selectedBrandId;
                        
                    }
                    
                }
                
            }
            
        } else if (type == 2) {
            
            secondDatasArray = info;
            [self.secondTableView reloadData];
            
            NSDictionary *selectedData     = self.selectedData;
            NSDictionary *selectedTypeData = selectedData[@"selectedCarType"];
            NSString     *selectedTypeId   = selectedTypeData[@"carTypeId"];
            
            if (selectedTypeId.length > 0 && secondDatasArray.count > 0) {
                
                for (int i = 0; i < secondDatasArray.count; i++) {
                    
                    NSDictionary *typeData = secondDatasArray[i];
                    NSString     *typeId   = typeData[@"carTypeId"];
                    
                    if ([typeId isEqualToString:selectedTypeId]) {
                        
                        NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.secondTableView selectRowAtIndexPath:selectedPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                        
                    }
                    
                }
                
            }
            
        }
        
    } error:^(NSString *errorMessage) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 100) {
        
        return firstDatasArray.count;
        
    } else {
        
        return secondDatasArray.count;
        
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 100) {
        
        return 40 *Scale_Height;
        
    } else {
        
        return 40 *Scale_Height;
        
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 100) {
        
        ChooseCarTypeLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseCarTypeLeftCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (firstDatasArray.count > 0) {
            
            NSDictionary *model = firstDatasArray[indexPath.row];
            cell.data = model;
            [cell loadContent];
            
        }
        return cell;
        
    } else {
        
        ChooseCarTypeRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseCarTypeRightCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (secondDatasArray.count > 0) {
            NSDictionary *model = secondDatasArray[indexPath.row];
            cell.data = model;
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
            tmpSecondDatasArray                 = [secondDatasArray mutableCopy];
            [tmpSecondDatasArray removeAllObjects];
            secondDatasArray                    = [tmpSecondDatasArray copy];
            [self.secondTableView reloadData];
            
        }
        
        NSDictionary *model   = firstDatasArray[indexPath.row];
        NSString     *brandId = model[@"brandId"];
        [self requestPost_getCarDataWithType:2 brandId:brandId];
        
        selectedBrandId = brandId;
        
    } else if (tableView.tag == 101) {
        
        secondRow = indexPath.row;

        NSDictionary *carBrandData = firstDatasArray[firstRow];
        NSDictionary *carTypeData  = secondDatasArray[secondRow];
        
        self.carTypeInfoBlock(carBrandData,carTypeData);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

@end
