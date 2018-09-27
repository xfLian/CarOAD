//
//  PublishMySkillChooseTypeOfServiceView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol PublishMySkillChooseTypeOfServiceViewDelegate <NSObject>

/**
 获取到的城市信息
 
 @param categoryData 服务类型
 @param catenaData 服务系
 @param categoryInfoData 子服务系
 */
- (void) getSelectedCategoryData:(NSDictionary *)categoryData
                        catenaData:(NSDictionary *)catenaData
                        categoryInfoData:(NSDictionary *)categoryInfoData;

@end

@interface PublishMySkillChooseTypeOfServiceView : CustomView

@property (nonatomic, weak) id<PublishMySkillChooseTypeOfServiceViewDelegate> delegate;

- (void) buildsubview;
- (void) showWithDuration:(CGFloat)duration animations:(BOOL)animations;
- (void) hideWithDuration:(CGFloat)duration animations:(BOOL)animations;

@end
