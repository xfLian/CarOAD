//
//  OADUserInfomationViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

typedef void(^AddUserInfoSuccessBlock) (BOOL isNeedLoadCVData);

@interface OADUserInfomationViewController : CustomTableViewController

@property (nonatomic, copy) AddUserInfoSuccessBlock isNeedLoadCVData;

@end
