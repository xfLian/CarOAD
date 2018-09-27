//
//  RootTabBarViewController.m
//  youIdea
//
//  Created by admin on 16/4/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "RootTabBar.h"

#import "OADHomePageViewController.h"
#import "OADAdvertiseViewController.h"
#import "OADNeedViewController.h"
#import "OADCommunityViewController.h"
#import "OADOwnViewController.h"

@interface RootTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    UINavigationController *homePageVC = [[UINavigationController alloc] initWithRootViewController:[[OADHomePageViewController alloc] init]];
    
    UINavigationController *advertiseVC = [[UINavigationController alloc] initWithRootViewController:[[OADAdvertiseViewController alloc] init]];
    
    UINavigationController *needVC = [[UINavigationController alloc] initWithRootViewController:[[OADNeedViewController alloc] init]];

    UINavigationController *communityVC = [[UINavigationController alloc] initWithRootViewController:[[OADCommunityViewController alloc] init]];
    
    UINavigationController *ownVC = [[UINavigationController alloc] initWithRootViewController:[[OADOwnViewController alloc] init]];
    
    // 添加子控制器
    [self addChildVc:homePageVC
               title:@"首页"
               image:@"home_page_icon"
       selectedImage:@"home_page_icon_selected"];
    
    [self addChildVc:advertiseVC
               title:@"招聘"
               image:@"recruit_icon"
       selectedImage:@"recruit_icon_selected"];
    
    [self addChildVc:needVC
               title:@"需求"
               image:@"need_icon"
       selectedImage:@"need_icon_selected"];

    [self addChildVc:communityVC
               title:@"社区"
               image:@"community_icon"
       selectedImage:@"community_icon_selected"];
    
    [self addChildVc:ownVC
               title:@"我的"
               image:@"my_center_icon"
       selectedImage:@"my_center_icon_selected"];

    
    RootTabBar *tabBar = [[RootTabBar alloc] init];
    tabBar.delegate    = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void) addChildVc:(UIViewController *)childVc
              title:(NSString *)title
              image:(NSString *)image
      selectedImage:(NSString *)selectedImage {
    
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = \
        [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes: \
        @{NSForegroundColorAttributeName : CarOadColor(153, 153, 153)}
                                      forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes: \
        @{NSForegroundColorAttributeName : MainColor}
                                      forState:UIControlStateSelected];

    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    // 添加子控制器
    [self addChildViewController:childVc];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    if (viewController == self.viewControllers[3]) {
        
        if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
            
            return YES;
            
        }
        
        return NO;
        
    }
    return YES;
}

@end
