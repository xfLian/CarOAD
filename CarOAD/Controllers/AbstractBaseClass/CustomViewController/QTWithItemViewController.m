  //
//  QTWithItemViewController.m
//  LinJiaMaMa
//
//  Created by qiantang on 16/9/12.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "QTWithItemViewController.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"

@interface QTWithItemViewController ()

@end

@implementation QTWithItemViewController

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self buildSubView];
    
    [self addTop];
    
}

- (void) buildSubView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.height)];
    self.backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backView];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight)];
    self.contentView.backgroundColor = BackGrayColor;
    [self.view addSubview:self.contentView];
    
    self.bottomView = [CustomBottomView createDefaultViewWithFrame:CGRectMake(0, self.view.height - SafeAreaBottomHeight - 50, Screen_Width,SafeAreaBottomHeight + 50)];
    [self.view addSubview:self.bottomView];
    
    self.bottomView.hidden = YES;
    
}

- (void) addTop {
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(KeyboardHide)];
    tapGestureRecognizer.cancelsTouchesInView    = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.tapGestureRecognizer = tapGestureRecognizer;
    
}

- (void) removeTap; {

    [self.view removeGestureRecognizer:self.tapGestureRecognizer];

}

- (void) setNavigationController {

    [super setNavigationController];
    
    if (![self.leftItemText isEqualToString:@"返回"]) {
        
        UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
        navigationView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:navigationView];
        
        //  添加导航栏左侧按钮
        UIView   *leftNavView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        UIButton *leftNavButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        leftNavButton.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
        leftNavButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [leftNavButton setTitle:self.leftItemText forState:UIControlStateNormal];
        [leftNavButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftNavButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [leftNavButton addTarget:self
                          action:@selector(clickLeftItem)
                forControlEvents:UIControlEventTouchUpInside];
        [leftNavView addSubview:leftNavButton];
        
        UIBarButtonItem *leftItem = [UIBarButtonItem new];
        leftItem.customView       = leftNavView;
        [self.navigationItem setLeftBarButtonItem:leftItem];
        
    } else {
        
        UIButton *leftNavButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        leftNavButton.frame           = CGRectMake(0, 0, 44, 44);
        UIImage  *ima                 = [UIImage imageNamed:@"arrow_backnav"];
        leftNavButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
        [leftNavButton setImage:ima forState:UIControlStateNormal];
        [leftNavButton addTarget:self
                          action:@selector(clickLeftItem)
                forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftNavButton];
        self.navigationItem.leftBarButtonItem = item;
    
    }
    
    if (self.rightItemText) {
        
        //  添加导航栏右侧按钮
        UIView   *rightNavView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        UIButton *rightNavButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        rightNavButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
        rightNavButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [rightNavButton setTitle:self.rightItemText forState:UIControlStateNormal];
        [rightNavButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightNavButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [rightNavButton addTarget:self
                           action:@selector(clickRightItem)
                 forControlEvents:UIControlEventTouchUpInside];
        [rightNavView addSubview:rightNavButton];
        self.rightItem = rightNavButton;
        UIBarButtonItem *rightItem = [UIBarButtonItem new];
        rightItem.customView       = rightNavView;
        [self.navigationItem setRightBarButtonItem:rightItem];
        
    } else {
    
        NSLog(@"设置");
    
    }
    
}

- (void) clickLeftItem {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) clickRightItem {
    
    
}


- (void)KeyboardHide {
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [[SDImageCache sharedImageCache] clearMemory];
    
    [super didReceiveMemoryWarning];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
        {
            // Add code to preserve data stored in the views that might be
            // needed later.
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
        
    }

}

@end
