//
//  LPYFriendTrendsViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYFriendTrendsViewController.h"
#import "LPYRecommendViewController.h"
#import "LPYLoginOrRegisterViewController.h"

@interface LPYFriendTrendsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblLogin;

@end

@implementation LPYFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置背景色
    LPYBackgroundColor;
    
    // 设置导航条
    [self setUpNav];
    
    // 设置Label行间距
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.lblLogin.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.headIndent = 30; // 缩进
//    style.firstLineHeadIndent = 0;
    style.lineSpacing = 10; // 行距
    style.alignment = NSTextAlignmentCenter;
    // 需要设置的范围
    NSRange range = NSMakeRange(0, self.lblLogin.text.length);
    [text addAttribute:NSParagraphStyleAttributeName value:style range:range];
    self.lblLogin.attributedText = text;
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

// 登录 or 注册
- (IBAction)btnLoginOrRegisterClick {
    LPYLoginOrRegisterViewController *login = [[LPYLoginOrRegisterViewController alloc] init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
