//
//  ResumeListNoDataView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ResumeListNoDataViewDelegate <NSObject>

- (void) gotoCreateResume;

@end

@interface ResumeListNoDataView : CustomView

@property (nonatomic, weak) id <ResumeListNoDataViewDelegate> delegate;

@end
