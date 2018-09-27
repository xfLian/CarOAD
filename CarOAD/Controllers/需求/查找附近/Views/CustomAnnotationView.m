//
//  CustomAnnotationView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAnnotationView.h"

#import "FindNeedInfoOfNearbyData.h"

#define kCalloutWidth  200.0
#define kCalloutHeight 70.0

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;
@property (nonatomic, strong, readwrite) UILabel *label;
@property (nonatomic, strong)            NSArray *datasArray;

@end

@implementation CustomAnnotationView

- (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier; {
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {

        UILabel *label = [UILabel createLabelWithFrame:self.imageView.frame
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:UIFont_15
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
        [self addSubview:label];
        self.label = label;
        
    }
    
    return self;
    
}

- (void) sendDataArray:(NSArray *)dataArray {
    
    self.datasArray = [dataArray copy];
    
    for (int i = 0; i < dataArray.count; ++i)
    {
        FindNeedInfoOfNearbyData *model = dataArray[i];

        CLLocation *location = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
        
        CLLocation *a_location = [location locationMarsFromBaidu];
        
        if (a_location.coordinate.latitude == self.annotation.coordinate.latitude && a_location.coordinate.longitude == self.annotation.coordinate.longitude) {
            
            if (model.cell_tag == 0) {
                
                self.label.hidden = YES;
                
            } else {
                
                self.label.hidden = NO;
                self.label.text = [NSString stringWithFormat:@"%ld",model.cell_tag];
                [self.label sizeToFit];
                self.label.frame = CGRectMake((self.width - self.label.width) / 2,
                                              (self.height - self.label.height) / 2,
                                              self.label.width,
                                              self.label.height);
                
            }
            
        }
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        for (int i = 0; i < self.datasArray.count; ++i)
        {
            FindNeedInfoOfNearbyData *model = self.datasArray[i];
            
            CLLocation *location   = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
            CLLocation *a_location = [location locationMarsFromBaidu];

            if (a_location.coordinate.latitude == self.annotation.coordinate.latitude && a_location.coordinate.longitude == self.annotation.coordinate.longitude) {

                [self.calloutView loadContentWithData:model];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedLocationAnnotation" object:model];
            }
            
        }
        [self addSubview:self.calloutView];

    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

//  修正点击气泡按钮位置
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        
        CGPoint tempoint = [self.calloutView.button convertPoint:point fromView:self];
        
        if (CGRectContainsPoint(self.calloutView.button.bounds, tempoint)) {
            
            view = self.calloutView.button;
            
        }
        
    }
    
    return view;
    
}

@end
