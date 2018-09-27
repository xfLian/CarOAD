//
//  DemandListData.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "DemandListData.h"

#import "MapsTypeTool.h"

@implementation DemandListData

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([value isKindOfClass:[NSNull class]]) {

        return;

    }

    if ([value isKindOfClass:[NSNumber class]]) {

        NSString *data = [NSString stringWithFormat:@"%@",value];
        value = data;

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

- (instancetype)timeModelWithData:(id)data; {

    DemandListData *newModel = [[[self class] alloc] init];
    DemandListData *model    = data;

    newModel.demandId       = model.demandId;
    newModel.demandTitle    = model.demandTitle;
    newModel.demandImg      = model.demandImg;
    newModel.price          = model.price;
    newModel.cityArea       = model.cityArea;
    newModel.carType        = model.carType;
    newModel.demandType     = model.demandType;
    newModel.endByTime      = model.endByTime;
    newModel.longitude      = model.longitude;
    newModel.latitude       = model.latitude;
    newModel.URGLevel       = model.URGLevel;

    NSString *day    = nil;
    NSString *hour   = nil;
    NSString *minute = nil;
    NSString *second = nil;
    if([model.endByTime rangeOfString:@"天"].location !=NSNotFound) {
        NSArray *dayArray = [model.endByTime componentsSeparatedByString:@"天"];
        day               = dayArray[0];
        if (dayArray.count > 1) {
            hour = dayArray[1];
            if([hour rangeOfString:@"小时"].location !=NSNotFound) {
                NSArray *hourArray = [hour componentsSeparatedByString:@"小时"];
                hour               = hourArray[0];
                if (hourArray.count > 1) {
                    minute = hourArray[1];
                    if([minute rangeOfString:@"分钟"].location !=NSNotFound) {
                        NSArray *minuteArray = [minute componentsSeparatedByString:@"分钟"];
                        minute               = minuteArray[0];
                        if (minuteArray.count > 1) {
                            second = minuteArray[1];
                            if([second rangeOfString:@"秒"].location !=NSNotFound) {
                                NSArray *secondArray = [second componentsSeparatedByString:@"秒"];
                                second               = secondArray[0];
                            } else {
                                second = @"0";
                            }
                        } else {
                            second = @"0";
                        }
                    } else {
                        if([minute rangeOfString:@"秒"].location !=NSNotFound) {
                            NSArray *secondArray = [minute componentsSeparatedByString:@"秒"];
                            second = secondArray[0];
                        } else {
                            second = @"0";
                        }
                        minute = @"0";
                    }
                } else {
                    minute = @"0";
                    second = @"0";
                }
            } else {
                if([hour rangeOfString:@"分钟"].location !=NSNotFound) {
                    NSArray *minuteArray = [hour componentsSeparatedByString:@"分钟"];
                    minute               = minuteArray[0];
                    if (minuteArray.count > 1) {
                        second = minuteArray[0];
                        if([second rangeOfString:@"秒"].location !=NSNotFound) {
                            NSArray *secondArray = [second componentsSeparatedByString:@"秒"];
                            second               = secondArray[0];
                        } else {
                            second = @"0";
                        }
                    } else {
                        second = @"0";
                    }
                } else {
                    if([hour rangeOfString:@"秒"].location !=NSNotFound) {
                        NSArray *secondArray = [hour componentsSeparatedByString:@"秒"];
                        second = secondArray[0];
                    } else {

                        second = @"0";

                    }
                    minute = @"0";
                }
                hour = @"0";
            }
        } else {
            hour   = @"0";
            minute = @"0";
            second = @"0";
        }
    } else {
        if([model.endByTime rangeOfString:@"小时"].location !=NSNotFound) {
            NSArray *hourArray = [model.endByTime componentsSeparatedByString:@"小时"];
            hour               = hourArray[0];
            if (hourArray.count > 1) {
                minute = hourArray[1];
                if([minute rangeOfString:@"分钟"].location !=NSNotFound) {
                    NSArray *minuteArray = [minute componentsSeparatedByString:@"分钟"];
                    minute               = minuteArray[0];
                    if (minuteArray.count > 1) {
                        second = minuteArray[1];
                        if([second rangeOfString:@"秒"].location !=NSNotFound) {
                            NSArray *secondArray = [second componentsSeparatedByString:@"秒"];
                            second               = secondArray[0];
                        } else {
                            second = @"0";
                        }
                    } else {
                        second = @"0";
                    }
                } else {
                    if([minute rangeOfString:@"秒"].location !=NSNotFound) {
                        NSArray *secondArray = [minute componentsSeparatedByString:@"秒"];
                        second = secondArray[0];
                    } else {
                        second = @"0";
                    }
                    minute = @"0";
                }
            } else {
                minute = @"0";
                second = @"0";
            }
        } else {
            if([model.endByTime rangeOfString:@"分钟"].location !=NSNotFound) {
                NSArray *minuteArray = [model.endByTime componentsSeparatedByString:@"分钟"];
                minute               = minuteArray[0];
                if (minuteArray.count > 1) {
                    second = minuteArray[0];
                    if([second rangeOfString:@"秒"].location !=NSNotFound) {
                        NSArray *secondArray = [second componentsSeparatedByString:@"秒"];
                        second               = secondArray[0];
                    } else {
                        second = @"0";
                    }
                } else {
                    second = @"0";
                }
            } else {
                if([model.endByTime rangeOfString:@"秒"].location !=NSNotFound) {
                    NSArray *secondArray = [model.endByTime componentsSeparatedByString:@"秒"];
                    second = secondArray[0];
                } else {
                    second = @"0";
                }
                minute = @"0";
            }
            hour = @"0";
        }
        day = @"0";
    }

    NSInteger seconds = day.integerValue *24 *60 *60 + hour.integerValue *60 *60 + minute.integerValue *60 + second.integerValue;
    newModel.countdownTime = [NSNumber numberWithInteger:seconds];

    return newModel;

}

- (void)countDown {

    _countdownTime = @(_countdownTime.integerValue - 1);
}

- (NSString *)currentTimeString {

    NSInteger seconds = _countdownTime.integerValue;

    if (seconds <= 0) {

        return @"00:00:00";

    } else {

        return [NSString stringWithFormat:@"%02ld天%02ld小时%02ld分钟%02ld秒", (long)(seconds / 86400), (long)(seconds % 86400 / 3600), (long)(seconds % 3600 / 60), (long)(seconds % 60)];
    }
}

@end
