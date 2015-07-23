//
//  LPYFriendTrendsViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYFriendTrendsViewController.h"
#import "LPYRecommendViewController.h"

@interface LPYFriendTrendsViewController ()

@end

@implementation LPYFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置背景色
    LPYBackgroundColor;
    
    // 设置导航条
    [self setUpNav];
}

- (void)setUpNav
{
    // 标题
    self.navigationItem.title = @"我的关注";
    
    // 左边内容
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemClick
{
    LPYRecommendViewController *recommend = [[LPYRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
