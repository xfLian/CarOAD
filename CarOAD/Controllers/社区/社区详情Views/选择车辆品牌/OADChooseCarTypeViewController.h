//
//  OADChooseCarTypeViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/7.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "QTWithItemViewController.h"

typedef void(^GetCarTypeInfoBlock) (NSDictionary *carBrandData, NSDictionary *carTypeData);

@interface OADChooseCarTypeViewController : QTWithItemViewController

@property (nonatomic, copy) GetCarTypeInfoBlock carTypeInfoBlock;
@property (nonatomic, strong) id selectedData;

@end
