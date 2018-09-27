//
//  FindNeedInfoOfNearbyCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/26.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomAdapterTypeTableViewCell.h"

static NSString  *NSNotificationCountDownTimeFindNeedInfoOfNearbyCell = @"NSNotificationCountDownTimeFindNeedInfoOfNearbyCell";

@interface FindNeedInfoOfNearbyCell : CustomAdapterTypeTableViewCell

- (void) loadTimeContent;

@end
