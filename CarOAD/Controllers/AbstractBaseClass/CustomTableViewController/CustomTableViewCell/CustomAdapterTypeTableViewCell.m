//
//  CustomAdapterTypeTableViewCell.m
//  youIdea
//
//  Created by admin on 16/4/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@implementation CustomAdapterTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupCell];
        
        [self buildSubview];
    }
    
    return self;
}

- (void)setupCell {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

- (void)selectedEvent {

}

- (void)delegateEvent {

    if (self.delegate && [self.delegate respondsToSelector:@selector(customAdapterTypeCell:event:)]) {

        [self.delegate customAdapterTypeCell:self event:self.data];
    }
}

+ (CGFloat)cellHeightWithData:(id)data {

    return 0.f;
}

- (void)loadContentWithAdapter:(TableViewCellDataAdapter *)dataAdapter {

    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    [self loadContent];
}

- (void)loadContentWithAdapter:(TableViewCellDataAdapter *)dataAdapter
                     indexPath:(NSIndexPath *)indexPath {

    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    [self loadContent];
}

- (void)loadContentWithAdapter:(TableViewCellDataAdapter *)dataAdapter
                      delegate:(id <CustomAdapterTypeTableViewCellDelegate>)delegate
                     indexPath:(NSIndexPath *)indexPath {

    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    _delegate    = delegate;
    [self loadContent];
}

- (void)loadContentWithAdapter:(TableViewCellDataAdapter *)dataAdapter
                      delegate:(id <CustomAdapterTypeTableViewCellDelegate>)delegate
                     tableView:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath {

    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    _delegate    = delegate;
    _tableView   = tableView;
    [self loadContent];
}

#pragma mark - Normal type adapter.

+ (TableViewCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                                   type:(NSInteger)type {

    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellType:type];
}

+ (TableViewCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                              cellWidth:(CGFloat)cellWidth
                                                   type:(NSInteger)type {

    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellWidth:cellWidth cellType:type];
}

+ (TableViewCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {

    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height type:type];
}

+ (TableViewCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height {

    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height type:0];
}

+ (TableViewCellDataAdapter *)dataAdapterWithData:(id)data {

    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:0 type:0];
}

+ (TableViewCellDataAdapter *)dataAdapterWithCellHeight:(CGFloat)height {

    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:nil cellHeight:height type:0];
}

+ (TableViewCellDataAdapter *)fixedHeightTypeDataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                                  data:(id)data
                                                                  type:(NSInteger)type {

    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:[[self class] cellHeightWithData:data]
                                                          cellType:type];
}

+ (TableViewCellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data type:(NSInteger)type {

    return [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class])
                                                              data:data cellHeight:[[self class] cellHeightWithData:data]
                                                          cellType:type];
}

+ (TableViewCellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data {

    return [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class])
                                                              data:data cellHeight:[[self class] cellHeightWithData:data]
                                                          cellType:0];
}

+ (TableViewCellDataAdapter *)fixedHeightTypeDataAdapter {

    return [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:nil cellHeight:[[self class] cellHeightWithData:nil] cellType:0];
}

#pragma mark - Layout type adapter.

+ (TableViewCellDataAdapter *)layoutTypeAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {

    return [[self class] dataAdapterWithCellReuseIdentifier:reuseIdentifier data:data cellHeight:UITableViewAutomaticDimension type:type];
}

+ (TableViewCellDataAdapter *)layoutTypeAdapterWithData:(id)data type:(NSInteger)type {

    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:UITableViewAutomaticDimension type:type];
}

+ (TableViewCellDataAdapter *)layoutTypeAdapterWithData:(id)data {

    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:UITableViewAutomaticDimension type:0];
}

+ (TableViewCellDataAdapter *)layoutTypeAdapter {

    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:nil cellHeight:UITableViewAutomaticDimension type:0];
}

#pragma mark -

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated {

    if (_tableView && _dataAdapter) {

        if (animated) {

            _dataAdapter.cellHeight = height;
            [_tableView beginUpdates];
            [_tableView endUpdates];
            
        } else {

            _dataAdapter.cellHeight = height;
            [_tableView reloadData];
            
        }
    }
}

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {

    [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
}

+ (void)registerToTableView:(UITableView *)tableView {

    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

@end

@implementation UITableView (CustomCell)

- (CustomAdapterTypeTableViewCell *)dequeueReusableCellAndLoadDataWithAdapter:(TableViewCellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath {

    CustomAdapterTypeTableViewCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    [cell loadContentWithAdapter:adapter delegate:nil tableView:self indexPath:indexPath];

    return cell;
}

- (CustomAdapterTypeTableViewCell *)dequeueReusableCellAndLoadDataWithAdapter:(TableViewCellDataAdapter *)adapter
                                                 delegate:(id <CustomAdapterTypeTableViewCellDelegate>)delegate
                                                indexPath:(NSIndexPath *)indexPath {

    CustomAdapterTypeTableViewCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    [cell loadContentWithAdapter:adapter delegate:delegate tableView:self indexPath:indexPath];

    return cell;
}

- (CGFloat)cellHeightWithAdapter:(TableViewCellDataAdapter *)adapter {

    return adapter.cellHeight;
}

@end
