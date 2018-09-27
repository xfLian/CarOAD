//
//  CertificationMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol CertificationMainViewDelegate <NSObject>

- (void) publishCertificationInfo;
- (void) chooseIdCodePhotoWithTag:(NSInteger)tag;

@end

@interface CertificationMainView : CustomView

@property (nonatomic, weak) id<CertificationMainViewDelegate> delegate;

- (void) loadUserNameAndIdCodeWithName:(NSString *)name idCode:(NSString *)idCode;
- (void) publishButtonIsCanClick;
- (void) loadIdPhotoWithImage:(UIImage *)image tag:(NSInteger)tag;

@end
