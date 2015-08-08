//
//  LPYMeFooterView.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/7.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYMeFooterView.h"
#import "LPYMeActiveModel.h"
#import <UIButton+WebCache.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LPYMeActiveButton.h"
#import "LPYTabBarController.h"
#import "LPYNavigationController.h"
#import "LPYWebViewController.h"

#define cols 4
#define btnH 100
@interface LPYMeFooterView()
/** model */
@property (nonatomic,strong) NSMutableArray *activeModels;
@end

@implementation LPYMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
        // 获取数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            self.activeModels = [LPYMeActiveModel objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
    
            [self addButton];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    return self;
}

- (void)setup
{
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)addButton
{
    for(int i = 0; i < self.activeModels.count; i++)
    {
        LPYMeActiveModel *model = self.activeModels[i];
        
        LPYMeActiveButton *btn = [[LPYMeActiveButton alloc] init];
        btn.tag = i;
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    
    // 计算父控件高度
    self.height = (self.activeModels.count + cols - 1) / cols * btnH;
    
    [self setNeedsLayout];
}

- (void)btnClick:(UIButton *)sender
{
    LPYMeActiveModel *model = self.activeModels[sender.tag];
    
    LPYTabBarController *tabBarController = (LPYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    LPYNavigationController *navigationController = (LPYNavigationController *)tabBarController.selectedViewController;
    LPYWebViewController *webController = [[LPYWebViewController alloc] init];
    webController.activeModel = model;
    [navigationController pushViewController:webController animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat btnW = LPYScreenWidth / cols;
    for (int i = 0; i < self.activeModels.count; i++) {
        LPYMeActiveButton *btn = self.contentView.subviews[i];
        CGFloat x = (i % cols) * btnW;
        CGFloat y = (i / cols) * btnH;
        btn.frame = CGRectMake(x, y, btnW, btnH);
    }
}

@end
