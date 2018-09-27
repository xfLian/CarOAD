//
//  OADMyLocationViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QTWithItemViewController.h"

#import "AMapAddressData.h"

typedef void(^GetUserLocationBlcok) (AMapAddressData *locationData);

@interface OADMyLocationViewController : QTWithItemViewController

@property (nonatomic, copy) GetUserLocationBlcok getUserLocation;

@end
