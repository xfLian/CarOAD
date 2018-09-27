//
//  ArtInfoRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ArtInfoData.h"

@interface ArtInfoRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <ArtInfoData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
