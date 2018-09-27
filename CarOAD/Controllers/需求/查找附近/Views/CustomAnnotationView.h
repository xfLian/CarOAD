//
//  CustomAnnotationView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

- (void) sendDataArray:(NSArray *)dataArray;

@end
