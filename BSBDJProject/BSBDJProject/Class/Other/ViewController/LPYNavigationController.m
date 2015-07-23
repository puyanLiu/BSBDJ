//
//  LPYNavigationController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYNavigationController.h"

@interface LPYNavigationController ()

@end

@implementation LPYNavigationController

+ (void)initialize
{
    // 设置背景图片
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置字体
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:20 weight:1.3];
    navigationBar.titleTextAttributes = textAttributes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 做一些拦截操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count >= 1)
    {
        // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置返回按钮
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] highlightedImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    [super pushViewController:viewController animated:animated];
}

// 返回
- (void)back
{
    [self popToRootViewControllerAnimated:YES];
}
@end
