//
//  AMapSearchView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@class AMapSearchView;

@protocol AMapSearchViewDelegate <NSObject>

- (void) startPoiSearchWithText:(NSString *)searchText;

@end

@interface AMapSearchView : CustomView

@property (nonatomic, weak) id <AMapSearchViewDelegate> delegate;

@end
