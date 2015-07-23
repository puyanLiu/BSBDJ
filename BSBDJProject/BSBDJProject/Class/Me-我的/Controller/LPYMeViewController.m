//
//  LPYMeViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYMeViewController.h"

@interface LPYMeViewController ()

@end

@implementation LPYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    LPYBackgroundColor;
}

- (void)setUpNav
{
    // 标题
    self.navigationItem.title = @"我的";
    
    // 设置
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingItemClick)];
    // 月亮
    UIBarButtonItem *moonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine-moon-icon"] highlightedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonItemClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)settingItemClick
{
    LPYLog(@"---");
}

- (void)moonItemClick
{
    LPYLog(@"moon");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
