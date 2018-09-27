//
//  NormalTabsView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/22.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol NormalTabsViewDelegate <NSObject>

- (void) clickTabsButtonWithType:(NSInteger)type;

@end

@interface NormalTabsView : CustomView

@property (nonatomic, weak) id <NormalTabsViewDelegate> delegate;

@property (nonatomic, strong) NSArray *buttonTitleArray;

- (void) buildsubview;

@end
