//
//  CellDataAdapter.h
//  youIdea
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellDataAdapter : NSObject

/**
 *  Cell's reused identifier.
 */
@property (nonatomic, strong) NSString     *cellReuseIdentifier;

/**
 *  Data, can be nil.
 */
@property (nonatomic, strong) id            data;

/**
 *  Cell's type (The same cell, but maybe have different types).
 */
@property (nonatomic)         NSInteger     cellType;

/**
 *  CellDataAdapter's convenient method.
 *
 *  @param cellReuseIdentifiers Cell's reused identifier.
 *  @param data                 Data, can be nil.
 *  @param cellType             Cell's type (The same cell, but maybe have different types).
 *
 *  @return CellDataAdapter's object.
 */
+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                       data:(id)data
                                                   cellType:(NSInteger)cellType;

/**
 *  The collectionView.
 */
@property (nonatomic, weak)   UICollectionView  *collectionView;

/**
 *  CollectionView's indexPath.
 */
@property (nonatomic, weak)   NSIndexPath       *indexPath;

@end
