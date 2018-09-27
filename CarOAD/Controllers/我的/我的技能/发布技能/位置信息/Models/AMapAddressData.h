//
//  AMapAddressData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMapAddressData : NSObject

@property (nonatomic, assign) BOOL          isSelected;
@property (nonatomic, copy)   NSString     *uid;
@property (nonatomic, copy)   NSString     *name;
@property (nonatomic, copy)   AMapGeoPoint *location;
@property (nonatomic, copy)   NSString     *address;

@end
