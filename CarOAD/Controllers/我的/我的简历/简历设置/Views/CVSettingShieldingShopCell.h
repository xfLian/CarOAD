//
//  CVSettingShieldingShopCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@class CVSettingShieldingShopCell;

@protocol CVSettingShieldingShopCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) clickDeleteShieldingShopWithData:(id)data;

@end

@interface CVSettingShieldingShopCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id <CustomAdapterTypeTableViewCellDelegate, CVSettingShieldingShopCellDelegate> delegate;

@property (nonatomic, assign) NSInteger row;

- (void) loadContent;

@end
