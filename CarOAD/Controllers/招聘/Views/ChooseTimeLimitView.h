//
//  ChooseTimeLimitView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ChooseTimeLimitViewDelegate <NSObject>

/**
 获取到的时间范围

 @param timeLimitData 时间范围数据
 */
- (void) selectedTimeLimitData:(NSDictionary *)timeLimitData;

@end

@interface ChooseTimeLimitView : CustomView

@property (nonatomic, weak) id <ChooseTimeLimitViewDelegate> delegate;

@end
