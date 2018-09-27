//
//  MyOrderDetailsDemandImgList.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderDetailsDemandImgList : NSObject

@property (nonatomic, strong) NSString *demandImgId;
@property (nonatomic, strong) NSString *demandImgName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
