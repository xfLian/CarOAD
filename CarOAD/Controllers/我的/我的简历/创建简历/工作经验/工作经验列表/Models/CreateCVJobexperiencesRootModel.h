//
//  CreateCVJobexperiencesRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateCVJobexperiencesData.h"

@interface CreateCVJobexperiencesRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <CreateCVJobexperiencesData *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
