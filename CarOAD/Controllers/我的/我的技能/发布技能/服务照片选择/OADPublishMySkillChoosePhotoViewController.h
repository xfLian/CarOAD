//
//  OADPublishMySkillChoosePhotoViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "QTWithItemViewController.h"

typedef void(^AddPhotoSuccessBlock) (NSString *skillPhotoImageString);

@interface OADPublishMySkillChoosePhotoViewController : QTWithItemViewController

@property (nonatomic, strong) NSString *imageString;
@property (nonatomic, copy)   AddPhotoSuccessBlock addPhotoSuccess;

@end
