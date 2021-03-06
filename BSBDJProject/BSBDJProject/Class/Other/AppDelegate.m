//
//  AppDelegate.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "AppDelegate.h"
#import "LPYTabBarController.h"
#import "LPYPushGuideView.h"
#import "LPYScrollViewWindow.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 加载跟控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 添加TabBarController
    UITabBarController *tabBarController = [[LPYTabBarController alloc] init];
    tabBarController.delegate = self;
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    // 显示推送引导
    [LPYPushGuideView show];
    
    return YES;
}

// 方式一：通过代理发送通知
// 方式二：通过点击按钮发送通知
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LPYTabBarDidClickNotification object:self userInfo:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 如果添加在didFinishLaunchingWithOptions
    // 会出现Application windows are expected to have a root view controller at the end of application launch
    
    // 添加UIWindow，用来控制UIScrollView的滚动
    [LPYScrollViewWindow show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
