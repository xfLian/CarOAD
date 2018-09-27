//
//  PublishMySkillData.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "PublishMySkillData.h"

#import "MYSkillDetailesData.h"

@implementation PublishMySkillData

+ (PublishMySkillData *) getMySkillDataWithData:(id)data; {
    
    MYSkillDetailesData *tmpData = data;
    PublishMySkillData  *model   = [PublishMySkillData new];

    model.skillId = tmpData.skillId;
    model.skillTitle = tmpData.skillTitle;
    model.skillInfo = tmpData.skillInfo;
    model.skillImg = tmpData.skillImgName;
    model.price = tmpData.price;
    model.unit = tmpData.unit;
    model.skillType = tmpData.skillType;
    model.provinceId = tmpData.Provinceid;
    model.cityId = tmpData.Cityid;
    model.areaId = tmpData.Areaid;
    model.address = tmpData.address;
    model.longitude = tmpData.longitude;
    model.latitude = tmpData.latitude;
    model.servereArea = tmpData.servereArea;

    return model;
    
}

@end
