//
//  LPYTabBarController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYTabBarController.h"
#import "LPYTabBar.h"
#import "LPYNavigationController.h"
#import "LPYFriendTrendsViewController.h"
#import "LPYEssenceViewController.h"
#import "LPYMeViewController.h"
#import "LPYNewViewController.h"
#import "LPYPublishViewController.h"
#import "LPYPublishView.h"
#import "LPYPublishSegementViewController.h"

@interface LPYTabBarController ()
/**
 *  发布按钮
 */
@property (nonatomic,weak) UIButton *publish;

@end

@implementation LPYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 只读属性，只能通过KVC赋值
    [self setValue:[[LPYTabBar alloc] init] forKey:@"tabBar"];
       
    // 添加子控制器
    [self setUpChildController];
    
}


- (void)setUpChildController
{
    // 精华
    LPYEssenceViewController *essence = [[LPYEssenceViewController alloc] init];
    [self addChildViewController:essence title:@"精华" image:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_essence_click_icon"]];
    
    // 新帖
    LPYNewViewController *new = [[LPYNewViewController alloc] init];
    [self addChildViewController:new title:@"新帖" image:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_new_click_icon"]];
    
    // 关注
    LPYFriendTrendsViewController *friend = [[LPYFriendTrendsViewController alloc] init];
    [self addChildViewController:friend title:@"关注" image:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_friendTrends_click_icon"]];
    
    // 我
    LPYMeViewController *me = [[LPYMeViewController alloc] init];
    [self addChildViewController:me title:@"我" image:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_me_click_icon"]];
    
    // 发布
    UIButton *publish = [UIButton buttonWithType:UIButtonTypeCustom];
    [publish setBackgroundImage:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [publish setBackgroundImage:[UIImage imageRenderingModeAlwaysOriginalNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [publish addTarget:self action:@selector(btnPublishClick) forControlEvents:UIControlEventTouchUpInside];
    [publish sizeToFit];
    publish.x = (self.tabBar.width - publish.width) * 0.5;
    [self.tabBar addSubview:publish];
    self.publish = publish;
    
}

UIWindow *window;
UIWindow *window2;
- (void)btnPublishClick
{
//    [LPYPublishView show];
    
//        LPYPublishViewController *publish = [[LPYPublishViewController alloc] initWithNibName:NSStringFromClass([LPYPublishViewController class]) bundle:nil];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
    
    LPYPublishSegementViewController *segement = [[LPYPublishSegementViewController alloc] init];
    UINavigationController *navigation =  [[UINavigationController alloc] initWithRootViewController:segement];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navigation animated:YES completion:nil];
    
    // 弹出的页面 半透明效果
    //    LPYPublishView *publishView = [LPYPublishView publishView];
    //    publishView.frame = [UIScreen mainScreen].bounds;
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    [window addSubview:publishView];
    
    
    // 窗口级别
//     UIWindowLevelNormal < UIWindowLevelStatusBar < UIWindowLevelAlert
    
//        window = [[UIWindow alloc] init];
//        window.frame = CGRectMake(0, 0, 375, 20);
//        window.backgroundColor = [UIColor yellowColor];
//        window.windowLevel = UIWindowLevelStatusBar;
//        window.hidden = NO;
//    
//        window2 = [[UIWindow alloc] init];
//        window2.frame = CGRectMake(100, 100, 100, 100);
//        window2.backgroundColor = [UIColor redColor];
//        window2.hidden = NO;
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    childController.title = title;
    childController.tabBarItem.image = image;
    childController.tabBarItem.selectedImage = selectedImage;
    
    LPYNavigationController *navigationController = [[LPYNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:navigationController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
