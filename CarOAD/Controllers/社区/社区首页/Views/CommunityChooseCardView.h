//
//  CommunityChooseCardView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/9/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol CommunityChooseCardViewDelegate <NSObject>

- (void) clickClassifiedButtonWithType:(NSInteger)type;

@end

@interface CommunityChooseCardView : CustomView

@property (nonatomic, weak) id <CommunityChooseCardViewDelegate> delegate;

@property (nonatomic, strong) NSArray *buttonTitleArray;

- (void) buildsubview;

@end
