//
//  MYSkillListCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@class MYSkillListCell;

@protocol MYSkillListCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) clickEdiSkillWithData:(id)data;
- (void) clickDeleteSkillWithData:(id)data;
- (void) clickChangeStateSkillWithData:(id)data;
- (void) clickHandleSkillWithData:(id)data;

@end

@interface MYSkillListCell : CustomAdapterTypeTableViewCell

#pragma mark - Propeties.

/**
 *  CustomCell's delegate.
 */
@property (nonatomic, weak) id <CustomAdapterTypeTableViewCellDelegate, MYSkillListCellDelegate> delegate;

- (void) loadContent;

@end
