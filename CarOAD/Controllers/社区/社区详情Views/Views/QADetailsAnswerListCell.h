//
//  QADetailsAnswerListCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol QADetailsAnswerListCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) clickDetailsListLikeButtonForData:(id)data;

@end

@interface QADetailsAnswerListCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id <CustomAdapterTypeTableViewCellDelegate, QADetailsAnswerListCellDelegate> delegate;

- (void)loadContent;

@end
