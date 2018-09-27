//
//  OADAddSkillsCertificateViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

typedef void(^AddSkillsCertificateSuccessBlock) (BOOL isAddJobSuccess);

@interface OADAddSkillsCertificateViewController : CustomTableViewController

@property (nonatomic, strong) id data;
@property (nonatomic, copy)   AddSkillsCertificateSuccessBlock addJobExpSucces;

@end
