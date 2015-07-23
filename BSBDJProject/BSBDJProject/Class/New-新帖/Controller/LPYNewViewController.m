//
//  LPYNewViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYNewViewController.h"

@interface LPYNewViewController ()

@end

@implementation LPYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    LPYBackgroundColor;
}

- (void)setUpNav
{
    // 标题
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageView;
    
    // 左边内容
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemClick
{
    LPYLog(@"---");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
