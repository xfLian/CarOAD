//
//  HomePageTrendsCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@class HomePageTrendsCell;

@protocol HomePageTrendsCellDelegate <NSObject,CustomAdapterTypeTableViewCellDelegate>

- (void) clickChankDetailsWithData:(id)data;

@end

@interface HomePageTrendsCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate,HomePageTrendsCellDelegate> delegate;

- (void) dealloc;

@end
