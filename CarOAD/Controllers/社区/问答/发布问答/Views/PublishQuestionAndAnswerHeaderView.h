//
//  PublishQuestionAndAnswerHeaderView.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/6.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol PublishQuestionAndAnswerHeaderViewDelegate <NSObject>

- (void) chooseQATagWithTag:(NSInteger)tag;

@end

@interface PublishQuestionAndAnswerHeaderView : CustomView

@property (nonatomic, weak) id <PublishQuestionAndAnswerHeaderViewDelegate> delegate;

@property (nonatomic, strong) NSArray *buttonTitleArray;

- (void) buildsubview;

@end
