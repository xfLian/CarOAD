//
//  NeedInfomationListCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/3.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

static NSString  *NSNotificationCountDownTimeCell = @"NSNotificationCountDownTimeCell";
static NSString  *NSNotificationCountLocationCell = @"NSNotificationCountLocationCell";

@interface NeedInfomationListCell : CustomAdapterTypeTableViewCell

- (void) loadTimeContent;
- (void) loadDistanceContent;

@end
