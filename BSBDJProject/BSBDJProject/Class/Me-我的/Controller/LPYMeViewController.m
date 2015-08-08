//
//  LPYMeViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYMeViewController.h"
#import "LPYMeCell.h"
#import "LPYMeFooterView.h"

@interface LPYMeViewController ()

@end

@implementation LPYMeViewController
static NSString *meCell = @"meCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    LPYBackgroundColor;
    
    [self setupTableView];
}

- (void)setupTableView
{
    // 注册
    [self.tableView registerClass:[LPYMeCell class] forCellReuseIdentifier:meCell];
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    // 添加脚部
    LPYMeFooterView *footer = [[LPYMeFooterView alloc] init];
    self.tableView.tableFooterView = footer;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    // 分组样式
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCell];
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        // 登录
        cell.textLabel.text = @"登录/注册";
        UIImage *image = [UIImage imageNamed:@"defaultUserIcon"];
        cell.imageView.image = [image imageStyle];
    }
    else if(indexPath.section == 1 && indexPath.row == 0)
    {
        // 离线下载
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    return cell;
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
