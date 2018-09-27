//
//  OADChangePhoneCodeViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QTWithItemViewController.h"

typedef void(^ChangePhoneBlcok) (BOOL isSuccessForPhoneAccreditation, NSString *userPhone);

@interface OADChangePhoneCodeViewController : QTWithItemViewController

@property (nonatomic, copy) ChangePhoneBlcok changePhone;

@end
