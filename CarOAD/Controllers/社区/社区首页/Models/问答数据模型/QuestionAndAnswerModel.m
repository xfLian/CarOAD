//
//  QuestionAndAnswerModel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QuestionAndAnswerModel.h"

#import "QAListData.h"

#define Text_Back_Height 50 *Scale_Height

#define Image_One_Height (Screen_Width - 24 *Scale_Width) / 2

#define Image_More_Height (Screen_Width - 44 *Scale_Width) / 9 *2

@implementation QuestionAndAnswerModel

+ (QuestionAndAnswerModel *) initQuestionAndAnswerData:(id)data; {
    
    QAListData             *tmpData = data;
    QuestionAndAnswerModel *model   = [[QuestionAndAnswerModel alloc] init];
    
    NSArray *array = [tmpData.QAImgURLList componentsSeparatedByString:@","];
    
    model.qAId            = tmpData.QAId;
    model.text            = tmpData.QAInfo;
    model.imageArray      = array;
    model.iconImageString = tmpData.createrImg;
    model.name            = tmpData.createrName;
    model.date            = tmpData.createDate;
    model.carType         = tmpData.carBrand;
    model.number          = tmpData.answerNum;
    model.totalLikeNum    = tmpData.totalLikeNum;
    model.isLike          = tmpData.isLike;
    
    CGFloat cell_height = 70 *Scale_Height;
    
    if (array.count == 1) {
        
        model.cell_type = @"0";
        cell_height = 70 *Scale_Height + Image_One_Height;
        
    } else if (array.count > 1) {
        
        model.cell_type = @"2";
        cell_height = 70 *Scale_Height + Image_More_Height;
        
    } else if (array.count == 0) {
        
        model.cell_type = @"3";
        cell_height = 60 *Scale_Height;
        
    }
    
    model.cell_height = cell_height;
    
    return model;

}

@end
