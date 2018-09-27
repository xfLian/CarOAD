//
//  AdvertiseMainSubView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol AdvertiseMainSubViewDelegate <NSObject>

- (void) clickchooseButtonWithType:(NSInteger)type;
- (void) clickHideChooseTypeView;

@end

@interface AdvertiseMainSubView : CustomView

@property (nonatomic, weak) id <AdvertiseMainSubViewDelegate> delegate;

@property (nonatomic, strong) NSArray *buttonTitleArray;

- (void) buildsubview;
- (void) loadUI;

@end
