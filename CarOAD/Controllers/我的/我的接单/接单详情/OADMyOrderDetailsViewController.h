//
//  OADMyOrderDetailsViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

@interface OADMyOrderDetailsViewController : CustomTableViewController

@property (nonatomic, strong) NSString *demandId;
@property (nonatomic, assign) BOOL      isNeedListPush;
@property (nonatomic, assign) BOOL      isNotivationPush;

@end
