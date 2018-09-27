//
//  AddJobExperiencesCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol AddJobExperiencesCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) getTextViewText:(NSString *)text forRow:(NSInteger)row;

- (void) showErrorMessage:(NSString *)message;

@optional
- (void) textViewShouldBeginEditing;

@end

@interface AddJobExperiencesCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, AddJobExperiencesCellDelegate> delegate;

@property (nonatomic, assign) NSInteger row;

- (void) loadContent;

@end
