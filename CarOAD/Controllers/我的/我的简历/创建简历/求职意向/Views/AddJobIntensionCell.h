//
//  AddJobIntensionCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol AddJobIntensionCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) getTextFieldText:(NSString *)text forRow:(NSInteger)row;

- (void) clickGetJobInfoWithRow:(NSInteger)row;

- (void) showCellErrorMessage;

@end

@interface AddJobIntensionCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, AddJobIntensionCellDelegate> delegate;

@property (nonatomic, assign) NSInteger row;

- (void) loadContent;

@end
