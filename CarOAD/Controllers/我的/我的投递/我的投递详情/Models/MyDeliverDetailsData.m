//
//  MyDeliverDetailsData.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "MyDeliverDetailsData.h"

#import "MapsTypeTool.h"

@implementation MyDeliverDetailsData

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
        
    }
    
    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        if (self = [super init]) {
            
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    
    return self;
}

- (void)calculateDistanceWithLocation:(CLLocation *)userLocation; {
    
    self.userLocation = userLocation;
    
}

- (NSString *) getDistance; {

    if (self.latitude.length > 0 && self.longitude.length > 0) {
        
        if (self.userLocation.coordinate.latitude > 0 && self.userLocation.coordinate.longitude > 0) {
            
            CLLocation *newLocation = [self.userLocation locationBaiduFromMars];
            
            double distance = [MapsTypeTool LantitudeLongitudeDist:[self.longitude doubleValue] other_Lat:[self.latitude  doubleValue] self_Lon:newLocation.coordinate.longitude self_Lat:newLocation.coordinate.latitude];
            
            float tmpDistance = distance / 1000;
            
            _distance = [NSString stringWithFormat:@"%.2fkm",tmpDistance];
            
        } else {
            
            _distance = @"0.00km";
            
        }
        
    } else {
        
        _distance = @"0.00km";
        
    }
    
    return _distance;
    
}

@end
