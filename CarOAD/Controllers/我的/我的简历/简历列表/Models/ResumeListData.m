//
//  ResumeListData.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ResumeListData.h"

@interface ResumeListData()

@end

@implementation ResumeListData

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

+ (ResumeListData *) getViewModelWithData:(id)data; {

    ResumeListData *newDataModel = [[ResumeListData alloc] init];
    ResumeListData *dataModel    = data;

    newDataModel.CVId       = dataModel.CVId;
    newDataModel.workNature = dataModel.workNature;
    newDataModel.isDefault  = dataModel.isDefault;
    newDataModel.integrity  = dataModel.integrity;
    newDataModel.skillPost  = dataModel.skillPost;
    newDataModel.skillPost  = dataModel.skillPost;
    newDataModel.uodateDate = dataModel.uodateDate;
    newDataModel.isOpen     = dataModel.isOpen;
    
    newDataModel.expendStringHeight = dataModel.expendStringHeight;
    newDataModel.normalStringHeight = dataModel.normalStringHeight;

    return newDataModel;

}

@end
