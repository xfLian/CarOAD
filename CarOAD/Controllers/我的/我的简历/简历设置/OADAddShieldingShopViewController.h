//
//  OADAddShieldingShopViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QTWithItemViewController.h"

typedef void(^AddShieldingShopSuccessBlcok) (BOOL addSuccess);

@interface OADAddShieldingShopViewController : QTWithItemViewController

@property (nonatomic, copy) AddShieldingShopSuccessBlcok addSuccess;

@end
