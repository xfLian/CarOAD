//
//  ChooseTimeSortTypeView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/4.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseTimeSortTypeView.h"

#import "ChooseTimeSortTypeCell.h"

@interface ChooseTimeSortTypeView()<UITableViewDelegate, UITableViewDataSource>
{

    NSArray *datasArray;

}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseTimeSortTypeView

- (void)buildSubview {

    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    tableView.backgroundColor = BackGrayColor;
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.tag             = 100;
    [self addSubview:tableView];
    self.tableView = tableView;

    [tableView registerClass:[ChooseTimeSortTypeCell class] forCellReuseIdentifier:@"ChooseTimeSortTypeCell"];

}

- (void) loadContent {

    datasArray = @[@{@"title":@"按时间升序排序",
                     @"titleId":@"1"}
                   ,@{@"title":@"按时间降序排序",
                      @"titleId":@"2"}];

    [self.tableView reloadData];

    NSDictionary *selectedData         = self.selectedData;
    NSDictionary *selectedTimeSortData = selectedData[@"selectedTimeSort"];
    NSString     *selectedTypeId       = selectedTimeSortData[@"titleId"];

    if (selectedTypeId.length > 0 && datasArray.count > 0) {

        for (int i = 0; i < datasArray.count; i++) {

            NSDictionary *typeData = datasArray[i];
            NSString     *typeId   = typeData[@"titleId"];

            if ([typeId isEqualToString:selectedTypeId]) {

                NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView selectRowAtIndexPath:selectedPath animated:YES scrollPosition:UITableViewScrollPositionNone];

            }

        }

    }

}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;

}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return datasArray.count;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChooseTimeSortTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseTimeSortTypeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (datasArray.count > 0) {

        NSDictionary *model = datasArray[indexPath.row];
        cell.data           = model;
        [cell loadContent];

    }
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [_delegate selectedTimeSortTypeData:datasArray[indexPath.row]];

}

@end
