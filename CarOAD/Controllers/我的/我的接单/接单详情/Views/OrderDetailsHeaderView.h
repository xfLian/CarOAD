//
//  OrderDetailsHeaderView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

static NSString  *NSNotificationDetailsCountDownTimeCell = @"NSNotificationDetailsCountDownTimeCell";

@protocol OrderDetailsHeaderViewDelegate <NSObject>

- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag;

@end

@interface OrderDetailsHeaderView : CustomView

@property (nonatomic, weak) id <OrderDetailsHeaderViewDelegate> delegate;

@property (nonatomic, weak) id imageData;

@end
