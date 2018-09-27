//
//  ResumeListLabel.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ResumeListLabel.h"

@interface ResumeListLabel ()<NumberCountDelegate>

@end

@implementation ResumeListLabel

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {

        self.countLabel               = [[UILabel alloc] initWithFrame:self.bounds];
        self.countLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.countLabel];
        self.countLabel.alpha         = 0;

        self.rungsNumber          = [RungsNumber new];
        self.rungsNumber.delegate = self;
    }

    return self;
}

- (void)numberCount:(NumberCount *)numberCount currentSting:(NSAttributedString *)string {

    self.countLabel.attributedText = string;
}

- (void)showDuration:(CGFloat)duration {

    self.rungsNumber.fromValue = self.fromValue;
    self.rungsNumber.toValue   = self.toValue;
    self.rungsNumber.duration  = duration;
    self.countLabel.transform    = CGAffineTransformMake(1, 0, 0, 1, 0, 0);

    [self.rungsNumber startAnimation];

    [UIView animateWithDuration:duration animations:^{

        self.countLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        self.countLabel.alpha     = 1.f;
    }];
}

- (void)hideDuration:(CGFloat)duration {

    self.rungsNumber.fromValue = self.toValue;
    self.rungsNumber.toValue   = 0;
    self.rungsNumber.duration  = duration;

    [self.rungsNumber startAnimation];

    [UIView animateWithDuration:duration animations:^{

        self.countLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        self.countLabel.alpha     = 0.f;
    }];
}

@end
