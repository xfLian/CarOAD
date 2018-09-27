//
//  MyPublishMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol MyPublishMainViewDelegate <NSObject>

- (void) clickChooseCardButton:(NSInteger)tag;

@end

@interface MyPublishMainView : CustomView

@property (nonatomic, weak) id <MyPublishMainViewDelegate> delegate;

@property (nonatomic, strong) NSArray *viewsArray;

- (void) buildSubView;

@end
