//
//  ChooseTimeLimitView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseTimeLimitView.h"

#import "ChooseTimeLimitCell.h"

@interface ChooseTimeLimitView()<UITableViewDelegate, UITableViewDataSource>
{

    NSArray *datasArray;

}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseTimeLimitView

- (void)buildSubview {

    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    tableView.backgroundColor = BackGrayColor;
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.tag             = 100;
    [self addSubview:tableView];
    self.tableView = tableView;

    [tableView registerClass:[ChooseTimeLimitCell class] forCellReuseIdentifier:@"ChooseTimeLimitCell"];

}

- (void) loadContent {

    datasArray = @[@{@"title":@"不限",
                     @"titleId":@"0"}
                   ,@{@"title":@"一日内",
                      @"titleId":@"1"}
                   ,@{@"title":@"三日内",
                      @"titleId":@"2"}
                   ,@{@"title":@"一周内",
                      @"titleId":@"3"}
                   ,@{@"title":@"一月内",
                      @"titleId":@"4"}];

    [self.tableView reloadData];

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

    return 40 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChooseTimeLimitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseTimeLimitCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (datasArray.count > 0) {

        NSDictionary *model = datasArray[indexPath.row];
        cell.data = model[@"title"];
        [cell loadContent];

    }
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [_delegate selectedTimeLimitData:datasArray[indexPath.row]];

}

@end
