//
//  CVSettingIsOpenCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@class CVSettingIsOpenCell;

@protocol CVSettingIsOpenCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) clickSetOpenCVWithData:(id)data;

@end

@interface CVSettingIsOpenCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id <CustomAdapterTypeTableViewCellDelegate, CVSettingIsOpenCellDelegate> delegate;

@property (nonatomic, assign) NSInteger row;

- (void) loadContent;

@end
