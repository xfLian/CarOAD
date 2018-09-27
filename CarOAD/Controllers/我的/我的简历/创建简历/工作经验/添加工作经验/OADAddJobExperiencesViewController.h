//
//  OADAddJobExperiencesViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

typedef void(^AddJobExpSuccessBlock) (BOOL isAddJobSuccess);

@interface OADAddJobExperiencesViewController : CustomTableViewController

@property (nonatomic, strong) id data;
@property (nonatomic, copy) AddJobExpSuccessBlock addJobExpSucces;

@end
