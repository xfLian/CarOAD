//
//  ChooseNeedInfomationView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseNeedInfomationView.h"

#import "ChooseNeedInfomationCell.h"

@interface ChooseNeedInfomationView()<UITableViewDelegate, UITableViewDataSource, ChooseNeedInfomationCellDelegate>
{

    NSArray *originalDatasArray;
    NSArray *datasArray;

}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseNeedInfomationView

- (void)buildSubview {

    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 44 *Scale_Height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.tag             = 100;
    [self addSubview:tableView];
    self.tableView = tableView;

    [tableView registerClass:[ChooseNeedInfomationCell class] forCellReuseIdentifier:@"ChooseNeedInfomationCell"];

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, tableView.height, self.width / 2, 44 *Scale_Height)
                                                     title:@"重置"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.titleLabel.font = UIFont_16;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        [self addSubview:button];

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(self.width / 2, tableView.height, self.width / 2, 44 *Scale_Height)
                                                     title:@"确定"
                                           backgroundImage:nil
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.titleLabel.font = UIFont_16;
        button.backgroundColor = MainColor;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:button];

    }

    [self initialization];

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        datasArray = [originalDatasArray copy];
        [self.tableView reloadData];

    } else {

        NSMutableArray *salaryDataArray     = [NSMutableArray new];
        NSMutableArray *timeLimitDataArray  = [NSMutableArray new];
        NSMutableArray *occupationDataArray = [NSMutableArray new];
        NSMutableArray *jobTypeDataArray    = [NSMutableArray new];

        NSArray *tmpDatasArray = [datasArray mutableCopy];
        
        for (int i = 0; i < tmpDatasArray.count; i++) {

            NSDictionary *itemsModel = tmpDatasArray[i];
            NSArray *modelArray = itemsModel[@"item"];

            if (i == 0) {

                for (NSDictionary *model in modelArray) {

                    NSString *isSelected = model[@"isSelected"];
                    if ([isSelected integerValue] == 1) {

                        [salaryDataArray addObject:model];

                    }

                }

            } else if (i == 1) {

                for (NSDictionary *model in modelArray) {

                    NSString *isSelected = model[@"isSelected"];
                    if ([isSelected integerValue] == 1) {

                        [timeLimitDataArray addObject:model];

                    }

                }

            } else if (i == 2) {

                for (NSDictionary *model in modelArray) {

                    NSString *isSelected = model[@"isSelected"];
                    if ([isSelected integerValue] == 1) {

                        [occupationDataArray addObject:model];

                    }

                }

            } else if (i == 3) {

                for (NSDictionary *model in modelArray) {

                    NSString *isSelected = model[@"isSelected"];
                    if ([isSelected integerValue] == 1) {

                        [jobTypeDataArray addObject:model];

                    }

                }

            }

        }

        [_delegate selectedSalaryData:[salaryDataArray copy]
                        timeLimitData:[timeLimitDataArray copy]
                       occupationData:[occupationDataArray copy]
                          jobTypeData:[jobTypeDataArray copy]];

    }
    
}

- (void) initialization {

    originalDatasArray = @[@{
                               @"type" : @"月薪范围",
                               @"cell_tag" : @"0",
                               @"item":@[@{@"title":@"面议",
                                           @"titleId":@"1",
                                           @"isSelected":@"1"}
                                         ,@{@"title":@"1千-3千",
                                            @"titleId":@"2",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"3千-5千",
                                            @"titleId":@"3",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"5千-8千",
                                            @"titleId":@"4",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"8千-1万",
                                            @"titleId":@"5",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"1万以上",
                                            @"titleId":@"6",
                                            @"isSelected":@"0"}]

                               },
                           @{
                               @"type" : @"工作年限",
                               @"cell_tag" : @"1",
                               @"item":@[@{@"title":@"不限",
                                           @"titleId":@"1",
                                           @"isSelected":@"1"}
                                         ,@{@"title":@"应届生",
                                            @"titleId":@"2",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"1年以内",
                                            @"titleId":@"3",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"1-3年",
                                            @"titleId":@"4",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"3-5年",
                                            @"titleId":@"5",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"5-10年",
                                            @"titleId":@"6",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"10年以上",
                                            @"titleId":@"7",
                                            @"isSelected":@"0"}]

                               },
                           @{
                               @"type" : @"技术工种",
                               @"cell_tag" : @"2",
                               @"item":@[@{@"title":@"不限",
                                           @"titleId":@"1",
                                           @"isSelected":@"1"}
                                         ,@{@"title":@"洗车工",
                                            @"titleId":@"2",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"美容工",
                                            @"titleId":@"3",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"维修工",
                                            @"titleId":@"4",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"钣金工",
                                            @"titleId":@"5",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"喷漆工",
                                            @"titleId":@"6",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"机电工",
                                            @"titleId":@"7",
                                            @"isSelected":@"0"}]

                               },
                           @{
                               @"type" : @"工作性质",
                               @"cell_tag" : @"3",
                               @"item":@[@{@"title":@"不限",
                                           @"titleId":@"1",
                                           @"isSelected":@"1"}
                                         ,@{@"title":@"全职",
                                            @"titleId":@"2",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"兼职",
                                            @"titleId":@"3",
                                            @"isSelected":@"0"}
                                         ,@{@"title":@"实习",
                                            @"titleId":@"4",
                                            @"isSelected":@"0"}]

                               }];

}

- (NSArray *) loadSelectedDataWithSelectedDataArray:(NSArray *)selectedDataArray nextDatasArray:(NSArray *)nextDatasArray tag:(NSInteger)tag {

    NSMutableArray *tmpDatasArray = [NSMutableArray new];
    tmpDatasArray                 = [nextDatasArray mutableCopy];

    if (selectedDataArray.count > 0) {

        NSMutableDictionary *itemModel = [NSMutableDictionary new];
        itemModel                      = [tmpDatasArray[tag] mutableCopy];

        NSArray       *itemDatasArray     = itemModel[@"item"];
        NSMutableArray *tmpItemDatasArray = [NSMutableArray new];
        tmpItemDatasArray                 = [itemDatasArray mutableCopy];

        for (int i = 0; i < tmpItemDatasArray.count; i++) {

            NSMutableDictionary *model = [NSMutableDictionary new];
            model                      = [tmpItemDatasArray[i] mutableCopy];

            [model setValue:@"0" forKey:@"isSelected"];

            for (int j = 0; j < selectedDataArray.count; j++) {

                NSDictionary *selectedModel = selectedDataArray[j];

                if ([[model valueForKey:@"titleId"] isEqualToString:[selectedModel valueForKey:@"titleId"]]) {

                    [model setValue:@"1" forKey:@"isSelected"];

                }

            }

            [tmpItemDatasArray replaceObjectAtIndex:i withObject:model];

        }

        [itemModel setValue:[tmpItemDatasArray copy] forKey:@"item"];
        [tmpDatasArray replaceObjectAtIndex:tag withObject:itemModel];

    }

    return [tmpDatasArray copy];

}

- (void) loadContent {

    NSDictionary *contentDic = self.selectedData;

    NSArray *salaryDataArray     = contentDic[@"salary"];
    NSArray *timeLimitDataArray  = contentDic[@"timeLimit"];
    NSArray *occupationDataArray = contentDic[@"occupation"];
    NSArray *jobTypeDataArray    = contentDic[@"jobType"];

    NSMutableArray *tmpDatasArray = [NSMutableArray new];
    tmpDatasArray                 = [originalDatasArray mutableCopy];

    NSArray *firstSectionDataArray = [self loadSelectedDataWithSelectedDataArray:salaryDataArray
                                                                  nextDatasArray:tmpDatasArray
                                                                             tag:0];
    NSArray *secondSectionDataArray = [self loadSelectedDataWithSelectedDataArray:timeLimitDataArray
                                                                   nextDatasArray:firstSectionDataArray
                                                                              tag:1];
    NSArray *thirdSectionDataArray = [self loadSelectedDataWithSelectedDataArray:occupationDataArray
                                                                  nextDatasArray:secondSectionDataArray
                                                                             tag:2];
    NSArray *forthSectionDataArray = [self loadSelectedDataWithSelectedDataArray:jobTypeDataArray
                                                                  nextDatasArray:thirdSectionDataArray
                                                                             tag:3];

    datasArray = [forthSectionDataArray copy];
    [self.tableView reloadData];

}

#pragma mark - TableViewDelegate
//设置头分区
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {

        return [self createSectionHeaderViewWithLineColor:MainColor title:@"月薪范围" ];

    } else if (section == 1) {

        return [self createSectionHeaderViewWithLineColor:MainColor title:@"工作年限" ];

    } else if (section == 2) {

        return [self createSectionHeaderViewWithLineColor:[UIColor redColor] title:@"技术工种"];

    } else {

        return [self createSectionHeaderViewWithLineColor:[UIColor orangeColor] title:@"工作性质"];

    }

}

- (UIView *) createSectionHeaderViewWithLineColor:(UIColor *)color title:(NSString *)title {

    UIView *backView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30 *Scale_Height)];
    backView.backgroundColor = [UIColor whiteColor];

    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(12 *Scale_Width, (backView.height - 20 *Scale_Height) / 2, 200 *Scale_Width, 20 *Scale_Height)
                                              labelType:kLabelNormal
                                                   text:title
                                                   font:UIFont_14
                                              textColor:TextBlackColor
                                          textAlignment:NSTextAlignmentLeft
                                                    tag:100];
    [backView addSubview:titleLabel];

    UIView *h_lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height - 0.7f, backView.width, 0.7f)];
    h_lineView.backgroundColor = LineColor;
    [backView addSubview:h_lineView];

    return backView;

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30 *Scale_Height;

}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10 *Scale_Height;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return nil;

}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return datasArray.count;

}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *model = datasArray[indexPath.section];
    NSArray *itemDatasArray = model[@"item"];
    NSInteger x = itemDatasArray.count / 4;
    NSInteger y = itemDatasArray.count % 4;

    if (y > 0) {

        x++;

    }

    return 20 *Scale_Height + (x - 1) *10 *Scale_Height + x *24 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChooseNeedInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseNeedInfomationCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate       = self;
    if (datasArray.count > 0) {

        cell.data = datasArray[indexPath.section];
        [cell loadContent];

    }
    return cell;

}

- (void) selectedItemsWithItem:(NSInteger)item cell_tag:(NSInteger)cell_tag; {

    NSMutableArray *tmpDatasArray = [NSMutableArray new];
    tmpDatasArray                 = [datasArray mutableCopy];

    NSMutableDictionary *itemModel = [NSMutableDictionary new];
    itemModel                      = [tmpDatasArray[cell_tag] mutableCopy];

    NSArray       *itemDatasArray     = itemModel[@"item"];
    NSMutableArray *tmpItemDatasArray = [NSMutableArray new];
    tmpItemDatasArray                 = [itemDatasArray mutableCopy];

    if (item == 0) {

        for (int i = 0; i < tmpItemDatasArray.count; i++) {

            NSMutableDictionary *model = [NSMutableDictionary new];
            model                      = [tmpItemDatasArray[i] mutableCopy];

            if (i == 0) {

                [model setValue:@"1" forKey:@"isSelected"];

            } else {

                [model setValue:@"0" forKey:@"isSelected"];

            }

            [tmpItemDatasArray replaceObjectAtIndex:i withObject:model];

        }

        [itemModel setValue:[tmpItemDatasArray copy] forKey:@"item"];
        [tmpDatasArray replaceObjectAtIndex:cell_tag withObject:itemModel];

    } else {

        for (int i = 0; i < tmpItemDatasArray.count; i++) {

            NSMutableDictionary *model = [NSMutableDictionary new];
            model                      = [tmpItemDatasArray[i] mutableCopy];

            if (i == 0) {

                [model setValue:@"0" forKey:@"isSelected"];

            } else {

                if (i == item) {

                    [model setValue:@"1" forKey:@"isSelected"];

                }

            }

            [tmpItemDatasArray replaceObjectAtIndex:i withObject:model];

        }

        [itemModel setValue:[tmpItemDatasArray copy] forKey:@"item"];
        [tmpDatasArray replaceObjectAtIndex:cell_tag withObject:itemModel];

    }

    datasArray = [tmpDatasArray copy];

    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:cell_tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

}

@end
