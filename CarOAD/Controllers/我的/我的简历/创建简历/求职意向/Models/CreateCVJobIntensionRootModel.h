//
//  CreateCVJobIntensionRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateCVJobIntensionData.h"

@interface CreateCVJobIntensionRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <CreateCVJobIntensionData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
