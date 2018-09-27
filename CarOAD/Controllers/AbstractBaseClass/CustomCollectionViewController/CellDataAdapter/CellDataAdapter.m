//
//  CellDataAdapter.m
//  youIdea
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CellDataAdapter.h"

@implementation CellDataAdapter

+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                       data:(id)data
                                                   cellType:(NSInteger)cellType {
    
    CellDataAdapter *adapter    = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellType            = cellType;
    
    return adapter;
}

@end
