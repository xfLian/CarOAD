//
//  CustomTableViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/16.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

@interface CustomTableViewController ()

@end

@implementation CustomTableViewController

- (NSMutableArray<TableViewCellDataAdapter *> *)adapters {
    
    if (!_adapters) {
        
        _adapters = [[NSMutableArray alloc] init];
        
    }
    
    return _adapters;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)setNavigationController {
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    
    // Register cells
    [self registerCellsWithTableView:self.tableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCellDataAdapter *adapter = self.adapters[indexPath.row];
    
    CustomAdapterTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter = adapter;
    cell.data        = adapter.data;
    cell.tableView   = tableView;
    cell.indexPath   = indexPath;
    cell.delegate    = self;
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomAdapterTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedEvent];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.adapters[indexPath.row].cellHeight;
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
}

#pragma mark - Overwrite by subClass

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
}

@end
