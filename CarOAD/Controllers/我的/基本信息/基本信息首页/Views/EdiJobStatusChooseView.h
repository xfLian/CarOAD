//
//  EdiJobStatusChooseView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol EdiJobStatusChooseViewDelegate <NSObject>

- (void) getSelectedData:(id)data;

@end

@interface EdiJobStatusChooseView : CustomView

@property (nonatomic, weak) id<EdiJobStatusChooseViewDelegate> delegate;

- (void) buildsubview;
- (void) showWithDuration:(CGFloat)duration animations:(BOOL)animations;
- (void) hideWithDuration:(CGFloat)duration animations:(BOOL)animations;

@end
