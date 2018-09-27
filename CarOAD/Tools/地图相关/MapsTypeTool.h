//
//  MapsTypeTool.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/4.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapsTypeTool : NSObject

+ (double) LantitudeLongitudeDist:(double)lon1
                        other_Lat:(double)lat1
                         self_Lon:(double)lon2
                         self_Lat:(double)lat2;

@end
