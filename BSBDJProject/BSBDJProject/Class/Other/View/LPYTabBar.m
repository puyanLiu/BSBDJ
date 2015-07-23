//
//  LPYTabBar.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYTabBar.h"

@implementation LPYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame])
    {
        // 设置字体颜色
        [self setUpFont];
        
        // 设置背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    
    return self;
}


- (void)setUpFont
{
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSMutableDictionary *normal = [NSMutableDictionary dictionary];
    normal[NSForegroundColorAttributeName] = LPYColor(146, 146, 146);
    [tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
    
    NSMutableDictionary *selected = [NSMutableDictionary dictionary];
    selected[NSForegroundColorAttributeName] = LPYColor(67, 67, 67);
    [tabBarItem setTitleTextAttributes:selected forState:UIControlStateSelected];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat tabItemW = self.width / 5;
    CGFloat tabItemH = self.height;
    // 布局子控制器
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            view.frame = CGRectMake((index > 1 ? index + 1 : index) * tabItemW, 0, tabItemW, tabItemH);
            index++;
        }
    }
}

@end
