//
//  OADRegisterViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QTWithItemViewController.h"

typedef void(^BackLogInBlcok) (NSDictionary *loginData);

@interface OADRegisterViewController : QTWithItemViewController

@property (nonatomic, copy) BackLogInBlcok loginBlock;

@end
