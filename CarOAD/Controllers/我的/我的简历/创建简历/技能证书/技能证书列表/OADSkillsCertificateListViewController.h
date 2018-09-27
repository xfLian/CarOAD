//
//  OADSkillsCertificateListViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomTableViewController.h"

typedef void(^AddSkillsCertificateListSuccessBlock) (BOOL isNeedLoadCVData);

@interface OADSkillsCertificateListViewController : CustomTableViewController

@property (nonatomic, strong) NSString *cvId;
@property (nonatomic, copy)   AddSkillsCertificateListSuccessBlock isNeedLoadCVData;

@end
