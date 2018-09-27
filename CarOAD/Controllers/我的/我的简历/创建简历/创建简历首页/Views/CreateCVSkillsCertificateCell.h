//
//  CreateCVSkillsCertificateCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

typedef enum : NSUInteger {

    kCreateCVSkillsCertificateCellNoDataType,
    kCreateCVSkillsCertificateCellNormalType,

} ECreateCVSkillsCertificateCellType;

@protocol CreateCVSkillsCertificateCellDelegate <NSObject>

- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag;

@end

@interface CreateCVSkillsCertificateCell : CustomAdapterTypeTableViewCell

#pragma mark - Propeties.
@property (nonatomic, weak) id <CreateCVSkillsCertificateCellDelegate> subCellDelegate;

@end
