//
//  ResumeListCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

typedef enum : NSUInteger {

    kShowButtonCellNormalType,
    kShowButtonCellExpendType,

} EShowButtonCellType;

@class ResumeListCell;

@protocol ResumeListCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) clickCheckPreviewCVWithRow:(NSInteger)row;
- (void) clickRefreshCVWithRow:(NSInteger)row;
- (void) clickEdiCVWithRow:(NSInteger)row;
- (void) clickDeleteCVWithRow:(NSInteger)row;

@end

@interface ResumeListCell : CustomAdapterTypeTableViewCell

#pragma mark - Propeties.

/**
 *  CustomCell's delegate.
 */
@property (nonatomic, weak) id <CustomAdapterTypeTableViewCellDelegate, ResumeListCellDelegate> delegate;

@end
