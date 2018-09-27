//
//  OADPublishMySkillViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

typedef void(^PublishSkillSuccessBlock) (BOOL isPublishSkillSuccess);

@interface OADPublishMySkillViewController : CustomTableViewController

@property (nonatomic, strong) id data;
@property (nonatomic, copy) PublishSkillSuccessBlock publishSkillSuccess;

@end
