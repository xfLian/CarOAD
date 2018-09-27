//
//  OADJobExperiencesListViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/17.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

typedef void(^AddJobExpListSuccessBlock) (BOOL isNeedLoadCVData);

@interface OADJobExperiencesListViewController : CustomTableViewController

@property (nonatomic, strong) NSString *cvId;
@property (nonatomic, copy) AddJobExpListSuccessBlock isNeedLoadCVData;

@end
