//
//  MYSkillDetailesHeaderView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/20.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol MYSkillDetailesHeaderViewDelegate <NSObject>

- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag;

@end

@interface MYSkillDetailesHeaderView : CustomView

@property (nonatomic, weak) id <MYSkillDetailesHeaderViewDelegate> delegate;

- (MYSkillDetailesHeaderView *) createHeaderView;

@end
