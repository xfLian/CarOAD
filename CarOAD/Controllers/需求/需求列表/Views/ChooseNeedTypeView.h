//
//  ChooseNeedTypeView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/4.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ChooseNeedTypeViewDelegate <NSObject>

/**
 选中的需求类型

 @param demandTypeData 选中的需求类型
 */
- (void) selectedDemandTypeData:(NSDictionary *)demandTypeData;

@end

@interface ChooseNeedTypeView : CustomView

@property (nonatomic, weak) id <ChooseNeedTypeViewDelegate> delegate;
@property (nonatomic, strong) id selectedData;

@end
