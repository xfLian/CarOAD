//
//  QTCustomViewController.m
//  LinJiaMaMa
//
//  Created by qiantang on 16/9/12.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "QTCustomViewController.h"

@interface QTCustomViewController ()

@end

@implementation QTCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationController];

}

- (void) setNavigationController {

    self.title = self.navTitle;
    
    if (self.backgroundColor) {
        
        self.navigationController.navigationBar.barTintColor = self.backgroundColor;
        
    } else {
        
        self.navigationController.navigationBar.barTintColor = MainColor;
        
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"STHeitiSC-Medium" size:17.f],
                                                                      NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

@end
