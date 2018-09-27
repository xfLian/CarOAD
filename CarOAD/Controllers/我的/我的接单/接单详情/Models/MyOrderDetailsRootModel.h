//
//  MyOrderDetailsRootModel.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyOrderDetailsData.h"
#import "MyOrderDetailsDemandImgList.h"
#import "MyOrderDetailsOrderMsgList.h"

@interface MyOrderDetailsRootModel : NSObject

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray <MyOrderDetailsData *> *data;
@property (nonatomic, strong) NSArray <MyOrderDetailsDemandImgList *> *demandImgList;
@property (nonatomic, strong) NSArray <MyOrderDetailsOrderMsgList *> *orderMsgList;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
