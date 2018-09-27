//
//  CVSettingIsDefaultCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@class CVSettingIsDefaultCell;

@protocol CVSettingIsDefaultCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) clickSetDefaultCVWithData:(id)data;

@end

@interface CVSettingIsDefaultCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id <CustomAdapterTypeTableViewCellDelegate, CVSettingIsDefaultCellDelegate> delegate;

@property (nonatomic, assign) NSInteger row;

- (void) loadContent;

@end
