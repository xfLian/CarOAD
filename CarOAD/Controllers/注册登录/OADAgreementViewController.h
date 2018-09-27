//
//  OADAgreementViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QTWithItemViewController.h"

typedef void(^IsObedienceAgreementBlcok) (BOOL isAgree);

@interface OADAgreementViewController : QTWithItemViewController

@property (nonatomic, copy) IsObedienceAgreementBlcok agreeBlock;

@end
