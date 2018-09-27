//
//  ChooseNeedTypeView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/4.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ChooseNeedTypeView.h"

#import "ChooseNeedTypeCell.h"

@interface ChooseNeedTypeView()<UITableViewDelegate, UITableViewDataSource>
{

    NSArray *datasArray;

}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseNeedTypeView

- (void)buildSubview {

    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    tableView.backgroundColor = BackGrayColor;
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.tag             = 100;
    [self addSubview:tableView];
    self.tableView = tableView;

    [tableView registerClass:[ChooseNeedTypeCell class] forCellReuseIdentifier:@"ChooseNeedTypeCell"];

}

- (void) loadContent {

    [self requestPost_getNeedTypeDataWithType];

}

- (void) requestPost_getNeedTypeDataWithType {

    NSString *urlString = MYPostClassUrl(CLASS_SHOPTECH, GET_DEMAND_TYPE);

    HttpTool *httpTool = [HttpTool sharedHttpTool];
    [httpTool cancelAllOperations];
    [httpTool lxfHttpPostWithURL:urlString params:nil success:^(id data) {

        NSString *result = [data valueForKey:@"result"];

        if ([result integerValue] == 1) {

            datasArray = data[@"data"];
            [self.tableView reloadData];

            NSDictionary *selectedData         = self.selectedData;
            NSDictionary *selectedNeedTypeData = selectedData[@"selectedNeedType"];
            NSString     *selectedTypeId       = selectedNeedTypeData[@"demandTyepId"];

            if (selectedTypeId.length > 0 && datasArray.count > 0) {

                for (int i = 0; i < datasArray.count; i++) {

                    NSDictionary *typeData = datasArray[i];
                    NSString     *typeId   = typeData[@"demandTyepId"];

                    if ([typeId isEqualToString:selectedTypeId]) {

                        NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.tableView selectRowAtIndexPath:selectedPath animated:YES scrollPosition:UITableViewScrollPositionNone];

                    }

                }

            }

        } else {


        }


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

    return datasArray.count;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChooseNeedTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseNeedTypeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (datasArray.count > 0) {

        NSDictionary *model = datasArray[indexPath.row];
        cell.data           = model;
        [cell loadContent];

    }
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [_delegate selectedDemandTypeData:datasArray[indexPath.row]];

}

@end
