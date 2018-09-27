//
//  OADAddJobIntensionViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/15.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

#import "CreateCVJobIntensionData.h"

typedef void(^AddJobIntensionSuccessBlock) (BOOL isNeedLoadCVData);

@interface OADAddJobIntensionViewController : CustomTableViewController

@property (nonatomic, strong) id data;
@property (nonatomic, copy) AddJobIntensionSuccessBlock isNeedLoadCVData;

@end
