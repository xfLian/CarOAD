//
//  CustomAdapterTypeTableViewCell.h
//  youIdea
//
//  Created by admin on 16/4/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDataAdapter.h"

@class CustomAdapterTypeTableViewCell;

@protocol CustomAdapterTypeTableViewCellDelegate <NSObject>

@optional

/**
 *  CustomCell's event.
 *
 *  @param cell  CustomAdapterTypeTableViewCell type class.
 *  @param event Event data.
 */
- (void)customAdapterTypeCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event;

@end

@interface CustomAdapterTypeTableViewCell : UITableViewCell

#pragma mark - Propeties.

/**
 *  CustomCell's delegate.
 */
@property (nonatomic, weak) id <CustomAdapterTypeTableViewCellDelegate> delegate;

/**
 *  CustomCell's data.
 */
@property (nonatomic, weak) id data;

/**
 *  CustomCell's dataAdapter.
 */
@property (nonatomic, weak) TableViewCellDataAdapter    *dataAdapter;

/**
 *  CustomCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath                 *indexPath;

/**
 *  TableView.
 */
@property (nonatomic, weak) UITableView                 *tableView;

/**
 *  Controller.
 */
@property (nonatomic, weak) UIViewController            *controller;

/**
 *  Cell is showed or not, you can set this property in UITableView's method 'tableView:willDisplayCell:forRowAtIndexPath:' & 'tableView:didEndDisplayingCell:forRowAtIndexPath:' at runtime.
 */
@property (nonatomic)       BOOL                     display;

#pragma mark - Useful method.

/**
 *  Setup cell, override by subclass.
 */
- (void)setupCell;

/**
 *  Build subview, override by subclass.
 */
- (void)buildSubview;

/**
 *  Load content, override by subclass.
 */
- (void)loadContent;

/**
 *  Calculate the cell's from data, overwrite by subclass.
 *
 *  @param data Data.
 *
 *  @return Cell's height.
 */
+ (CGFloat)cellHeightWithData:(id)data;

#pragma mark - Useful method.

/**
 *  Update the cell's height with animated or not, before you use this method, you should have the weak reference 'tableView' and 'dataAdapter', and this method will update the weak reference dataAdapter's property cellHeight.
 *
 *  @param height   The new cell height.
 *  @param animated Animated or not.
 */
- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated;

/**
 *  Selected event, you should use this method in 'tableView:didSelectRowAtIndexPath:' to make it effective.
 */
- (void)selectedEvent;

/**
 *  Used for delegate event.
 */
- (void)delegateEvent;

#pragma mark - Constructor method.

/**
 *  Create the cell's dataAdapter.
 *
 *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
 *  @param data            Cell's data, can be nil.
 *  @param height          Cell's height.
 *  @param type            Cell's type.
 *
 *  @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height type:(NSInteger)type;

/**
 *  Create the cell's dataAdapter.
 *
 *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
 *  @param data            Cell's data, can be nil.
 *  @param height          Cell's height.
 *  @param cellWidth       Cell's width.
 *  @param type            Cell's type.
 *
 *  @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height cellWidth:(CGFloat)cellWidth
                                                   type:(NSInteger)type;

/**
 *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
 *
 *  @param data            Cell's data, can be nil.
 *  @param height          Cell's height.
 *  @param type            Cell's type.
 *
 *  @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type;

/**
 *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
 *
 *  @param data            Cell's data, can be nil.
 *  @param height          Cell's height.
 *
 *  @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height;

/**
 *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
 *
 *  @param data            Cell's data, can be nil.
 *
 *  @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)dataAdapterWithData:(id)data;

/**
 Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.

 @param height Cell's height.
 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)dataAdapterWithCellHeight:(CGFloat)height;

/**
 [= Must over write class method 'cellHeightWithData:' to get the height =]

 Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.

 @param reuseIdentifier Cell reuseIdentifier, can be nil.
 @param data Cell's data, can be nil.
 @param type Cell's type.
 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)fixedHeightTypeDataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type;

/**
 [= Must over write class method 'cellHeightWithData:' to get the height =]

 Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.

 @param data Cell's data, can be nil.
 @param type Cell's type.
 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data type:(NSInteger)type;

/**
 [= Must over write class method 'cellHeightWithData:' to get the height =]

 Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.

 @param data Cell's data, can be nil.
 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data;

/**
 [= Must over write class method 'cellHeightWithData:' to get the height =]

 Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)fixedHeightTypeDataAdapter;

/**
 Create the layout type cell's dataAdapter, the CellReuseIdentifier is the cell's class string.

 @param reuseIdentifier Cell reuseIdentifier, can be nil.
 @param data Cell's data, can be nil.
 @param type Cell's type.
 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)layoutTypeAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type;

/**
 Create the layout type cell's dataAdapter.

 @param data Cell's data, can be nil.
 @param type Cell's type.
 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)layoutTypeAdapterWithData:(id)data type:(NSInteger)type;

/**
 Create the layout type cell's dataAdapter.

 @param data Cell's data, can be nil.
 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)layoutTypeAdapterWithData:(id)data;

/**
 Create the layout type cell's dataAdapter.

 @return Cell's dataAdapter.
 */
+ (TableViewCellDataAdapter *)layoutTypeAdapter;

/**
 Set the dataAdapter and load content.

 @param dataAdapter The CellDataAdapter.
 @param indexPath The indexPath.
 */
- (void)loadContentWithAdapter:(TableViewCellDataAdapter *)dataAdapter indexPath:(NSIndexPath *)indexPath;

/**
 Set the dataAdapter and load content.

 @param dataAdapter The CellDataAdapter.
 */
- (void)loadContentWithAdapter:(TableViewCellDataAdapter *)dataAdapter;

/**
 Set the dataAdapter and load content.

 @param dataAdapter The CellDataAdapter.
 @param delegate The delegate
 @param indexPath The indexPath.
 */
- (void)loadContentWithAdapter:(TableViewCellDataAdapter *)dataAdapter delegate:(id <CustomAdapterTypeTableViewCellDelegate>)delegate indexPath:(NSIndexPath *)indexPath;

/**
 Set the dataAdapter and load content.

 @param dataAdapter The CellDataAdapter.
 @param delegate The delegate.
 @param tableView The tableView.
 @param indexPath The indexPath.
 */
- (void)loadContentWithAdapter:(TableViewCellDataAdapter *)dataAdapter delegate:(id <CustomAdapterTypeTableViewCellDelegate>)delegate tableView:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath;

/**
 *  Register to tableView with the reuseIdentifier you specified.
 *
 *  @param tableView       TableView.
 *  @param reuseIdentifier The cell reuseIdentifier.
 */
+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *  Register to tableView with the The class name.
 *
 *  @param tableView       TableView.
 */
+ (void)registerToTableView:(UITableView *)tableView;

@end

#pragma mark - UITableView category.

@interface UITableView (CustomAdapterTypeTableViewCell)

- (CustomAdapterTypeTableViewCell *)dequeueReusableCellAndLoadDataWithAdapter:(TableViewCellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath;

- (CustomAdapterTypeTableViewCell *)dequeueReusableCellAndLoadDataWithAdapter:(TableViewCellDataAdapter *)adapter delegate:(id <CustomAdapterTypeTableViewCellDelegate>)delegate
                                                indexPath:(NSIndexPath *)indexPath;

- (CGFloat)cellHeightWithAdapter:(TableViewCellDataAdapter *)adapter;

@end
