//
//  CustomTableViewCell.h
//  youIdea
//
//  Created by admin on 16/4/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableViewCell;

@protocol CustomTableViewCellDelegate <NSObject>

@optional

/**
 *  CustomTableViewCell's event.
 *
 *  @param cell  CustomTableViewCell type class.
 *  @param event Event data.
 */
- (void)customCell:(CustomTableViewCell *)cell event:(id)event;

@end

@interface CustomTableViewCell : UITableViewCell

#pragma mark - Propeties.

/**
 *  CustomTableViewCell's delegate.
 */
@property (nonatomic, weak) id <CustomTableViewCellDelegate>  delegate;

/**
 *  CustomTableViewCell's data.
 */
@property (nonatomic, weak) id                       data;

/**
 *  CustomTableViewCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath             *indexPath;

/**
 *  TableView.
 */
@property (nonatomic, weak) UITableView             *tableView;

/**
 *  Controller.
 */
@property (nonatomic, weak) UIViewController        *controller;

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


@end
