//
//  OADShareButtonView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OADShareButtonViewDelegate <NSObject>

//  点击投诉处理
- (void) clickSureButtonWithTag:(NSInteger)tag;

@end
@interface OADShareButtonView : UIView

@property (nonatomic, weak) id<OADShareButtonViewDelegate> delegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;

- (void) show;
- (void) hide;

@end
