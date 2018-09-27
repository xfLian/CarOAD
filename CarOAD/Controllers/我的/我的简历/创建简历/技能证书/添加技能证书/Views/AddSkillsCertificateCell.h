//
//  AddSkillsCertificateCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol AddSkillsCertificateCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) addImageWithImageStringArray:(NSArray *)imageStringArray;
- (void) deleteImageWithImageStringArray:(NSArray *)imageStringArray;

- (void) showErrorMessage:(NSString *)message;

@end

@interface AddSkillsCertificateCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate, AddSkillsCertificateCellDelegate> delegate;

@property (nonatomic, assign) NSInteger row;

- (void) loadContent;

@end
