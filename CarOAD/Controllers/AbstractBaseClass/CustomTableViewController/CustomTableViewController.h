//
//  CustomTableViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/16.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "QTWithItemViewController.h"

#import "CustomAdapterTypeTableViewCell.h"

@interface CustomTableViewController : QTWithItemViewController<UITableViewDelegate, UITableViewDataSource, CustomAdapterTypeTableViewCellDelegate>

@property (nonatomic, strong) UITableView                                 *tableView;
@property (nonatomic, strong) NSMutableArray <TableViewCellDataAdapter *> *adapters;

- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event;
- (void)registerCellsWithTableView:(UITableView *)tableView;

@end
