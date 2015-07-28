//
//  LPYLoginOrRegisterTextField.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/26.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYLoginOrRegisterTextField.h"
#import <objc/runtime.h>

@implementation LPYLoginOrRegisterTextField


//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:rect withAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor]}];
//}

+ (void)initialize
{
//    unsigned int count;
//    Ivar *ivar =class_copyIvarList([UITextField class], &count);
//    for (int i = 0 ; i < count; i++) {
//        Ivar tmp = *(ivar + i);
//        // 获取成员属性
//        NSLog(@"%s",ivar_getName(tmp));
//    }
//    NSLog(@"-------%zd",count);
//    
//    // 释放
//    free(ivar);
}

- (void)setup
{
    // KVC赋值
    [self resignFirstResponder];
    
    // 更改清除按钮颜色 自定义按钮
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    // 系统默认的是设置背景图片
    [clearButton setBackgroundImage:[UIImage imageNamed:@"filed_close"] forState:UIControlStateNormal];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"filed_close_click"] forState:UIControlStateHighlighted];
    
//    NSLog(@"%@", clearButton);
    
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
}

// 获得焦点
- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

// 失去焦点
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super resignFirstResponder];
}

- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

@end
