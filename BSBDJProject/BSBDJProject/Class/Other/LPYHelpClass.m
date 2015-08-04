//
//  LPYHelpClass.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/4.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYHelpClass.h"

@implementation LPYHelpClass

// 处理按钮上边显示数值的情况
+ (void)setTopicWithButton:(UIButton *)btn withCount:(NSInteger)count withTitle:(NSString *)title
{
    NSString *content = title;
    if(count >= 10000)
    {
        content = [NSString stringWithFormat:@"%.1f万",1.0 *count / 10000];
    }
    else if(count > 0)
    {
        content = [NSString stringWithFormat:@"%zd", count];
    }
    [btn setTitle:content forState:UIControlStateNormal];
}

// 处理文本上边显示数值的情况
+ (void)setTopicWithLabel:(UILabel *)label withCount:(NSInteger)count
{
    NSString *content = @"0";
    if(count >= 10000)
    {
        content = [NSString stringWithFormat:@"%.1f万",1.0 *count / 10000];
    }
    else if(count > 0)
    {
        content = [NSString stringWithFormat:@"%zd", count];
    }
    label.text = content;
}

@end
