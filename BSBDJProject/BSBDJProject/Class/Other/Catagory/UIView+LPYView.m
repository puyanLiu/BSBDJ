//
//  UIView+LPYView.m
//  01-彩票
//
//  Created by 刘蒲艳 on 15/6/27.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "UIView+LPYView.h"

@implementation UIView (LPYView)

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

+ (BOOL)isShowOnKeyWindow:(UIView *)view
{
    // 将当前View的坐标系转换为窗口坐标系
    // 第二个参数如果写nil，表示的也是UIWindow
    //        CGPoint windowP = [subView convertPoint:subView.frame.origin toView:[UIApplication sharedApplication].keyWindow];
    // 将控件在父控件的坐标系转换为在主窗口的坐标系

    // 判断两个矩形是否相交
    //        CGRectIntersectsRect(<#CGRect rect1#>, <#CGRect rect2#>)
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect windowRect = window.bounds;
    CGRect newRect = [view.superview convertRect:view.frame toView:window];
    return view.window == window && !view.hidden && view.alpha > 0.01 && CGRectIntersectsRect(windowRect, newRect);
}
@end
