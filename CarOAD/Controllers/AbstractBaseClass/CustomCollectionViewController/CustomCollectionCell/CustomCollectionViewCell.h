//
//  CustomCollectionViewCell.h
//  youIdea
//
//  Created by admin on 16/4/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataAdapter.h"

@class CustomCollectionViewCell;

@protocol CustomCollectionViewCellDelegate <NSObject>

@optional

/**
 *  CustomCell's event.
 *
 *  @param cell  CustomAdapterTypeCell type class.
 *  @param event Event data.
 */
- (void)customAdapterTypeCell:(CustomCollectionViewCell *)cell event:(id)event;

@end

@interface CustomCollectionViewCell : UICollectionViewCell

#pragma mark - Propeties.

/**
 *  CustomCell's delegate.
 */
@property (nonatomic, weak) id <CustomCollectionViewCellDelegate>  delegate;

/**
 *  CustomCell's data.
 */
@property (nonatomic, weak) CellDataAdapter         *dataAdapter;

/**
 *  CustomCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath             *indexPath;

/**
 *  TableView.
 */
@property (nonatomic, weak) UICollectionView        *collectionView;

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
