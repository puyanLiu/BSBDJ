//
//  UIBarButtonItem+LPYBarButtonItem.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "UIBarButtonItem+LPYBarButtonItem.h"

@implementation UIBarButtonItem (LPYBarButtonItem)
- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:image forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [leftBtn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn setImage:highlightedImage forState:UIControlStateHighlighted];
    
    [leftBtn setTitle:title forState:UIControlStateNormal];
    
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮距离左边的距离
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    [leftBtn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:leftBtn];

}

@end
