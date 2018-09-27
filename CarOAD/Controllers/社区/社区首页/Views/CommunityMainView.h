//
//  CommunityMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol CommunityMainViewDelegate <NSObject>

- (void) clickAddMessageButtonWithTag:(NSInteger)tag;

- (void) clickChooseCardButton:(NSInteger)tag;

@end

@interface CommunityMainView : CustomView

@property (nonatomic, weak) id <CommunityMainViewDelegate> delegate;

@property (nonatomic, strong) NSArray *viewsArray;

- (void) buildSubView;

- (void) hideButtonBackView;

@end
