//
//  AppDelegate.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AppDelegate.h"

#import "RootTabBarViewController.h"

#import "OADMyOrderDetailsViewController.h"
#import "OADMYSkillDetailesViewController.h"
#import "OADMyDeliverDetailsViewController.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //sleep(1);
    
    //  设置服务器请求环境变量
    self.qtMainRootUrl = CarOadMainHttpURL;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor       = [UIColor colorWithRed:0
                                                  green:0
                                                   blue:0
                                                  alpha:1];
    
    RootTabBarViewController *rootViewController = [[RootTabBarViewController alloc] init];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    //  注册微信
    [WXApi registerApp:WX_AppID];
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = AMap_Key;
    
    //  注册极光
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        
        JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
        
        entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
        
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
        
#endif
        
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
        
    }
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPush_Key
                          channel:JPUSH_channel
                 apsForProduction:IsProduction];
    
    if (launchOptions) {
        
        NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        if (remoteNotification) {
            
            [JPUSHService handleRemoteNotification:remoteNotification];
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            
            [self pushVCWith:remoteNotification];
        }
        
    }
    
    //不需要任何调试信息的时候，调用此API （发布时建议调用此API，用来屏蔽日志信息，节省性能消耗)
    //  [JPUSHService setDebugMode];//开启Debug模式
    //  [JPUSHService setLogOFF];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    CarOadLog(@"2");
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    CarOadLog(@"1");
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    
    
}

- (void)applicationDidFinishLaunching:(UIApplication*)application {
    
    
    
}

#pragma mark - 极光相关
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
}

//  注册极光失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler(UNNotificationPresentationOptionAlert);
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {//收到远程通知
        
        [JPUSHService handleRemoteNotification:userInfo];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [self pushVCWith:userInfo];
        
    } else {// 判断为本地通知 点击打开App
        
        // 更新显示的徽章个数
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        badge--;
        badge = badge >= 0 ? badge : 0;
        [UIApplication sharedApplication].applicationIconBadgeNumber = badge;

    }
    
    completionHandler();
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    [self pushVCWith:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    application.applicationIconBadgeNumber = 0;
    [self pushVCWith:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //  本地推送
    
    //  更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;

}

#pragma mark -  Methods_PUSH
//根据推送 跳转页面
- (void)pushVCWith:(NSDictionary *)userInfo {
        
    NSString *typeCode  = userInfo[@"TypeCode"];
    NSString *projectId = userInfo[@"ID"];
    
    CarOadLog(@"userInfo --- %@",userInfo);
    CarOadLog(@"projectId --- %@",projectId);
    
    if ([typeCode isEqualToString:@"XQ"]) {
        
        OADMyOrderDetailsViewController *viewController = [OADMyOrderDetailsViewController new];
        viewController.isNotivationPush = YES;
        viewController.demandId         = projectId;
        
        UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:viewController];
        self.window.rootViewController = naviVC;
        
    } else if ([typeCode isEqualToString:@"JN"]) {
        
        OADMYSkillDetailesViewController *viewController = [OADMYSkillDetailesViewController new];
        viewController.isNotivationPush = YES;
        viewController.skillId          = projectId;
        UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:viewController];
        self.window.rootViewController = naviVC;
        
    } else if ([typeCode isEqualToString:@"JL"]) {
        
        OADMyDeliverDetailsViewController *viewController = [OADMyDeliverDetailsViewController new];
        viewController.isNotivationPush   = YES;
        viewController.recruiId           = projectId;
        UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:viewController];
        self.window.rootViewController = naviVC;
        
    }
    
}

#pragma mark - 微信相关
/**
 *  9.0后的方法
 */
- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{

    NSString *string =[url absoluteString];

    if ([string hasPrefix:@"wx"]) {

        /*
         *
         *  这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面
         *  （://pay 之前的那串字符串就是你的APPID，）
         *
         */
        return  [WXApi handleOpenURL:url delegate:self];

    }

    return YES;

}

/*
 *  微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
 */
-(void) onResp:(BaseResp*)resp
{

    if([resp isKindOfClass:[SendMessageToWXResp class]]){

        //使用UIAlertView 显示回调信息
        NSString    *str       = [NSString stringWithFormat:@"%d",resp.errCode];
        NSString    *message   = nil;

        if ([str isEqualToString:@"0"]) {

            message = @"分享成功";
            
        } else if ([str isEqualToString:@"-2"]) {
            
            message = @"您已取消分享";
            
        } else {
            
            message = @"分享失败";
            
        }

        NSNotification *notice = \
        [NSNotification notificationWithName:@"WXShareResoult"
                                      object:nil
                                    userInfo:@{@"message" : message}];
        //  发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];

    }

}

/**
 处理来至QQ的请求
 */
- (void)onReq:(BaseReq *)req; {}

@end
