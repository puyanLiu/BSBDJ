//
//  LPYScrollViewWindow.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/4.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYScrollViewWindow.h"

@implementation LPYScrollViewWindow

static UIWindow *window_;

+ (void)showWindow
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, LPYScreenWidth, LPYStatusBarH);
    window_.windowLevel = UIWindowLevelStatusBar;
    window_.hidden = NO;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)windowClick
{
    // 点击窗口
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollView:window];
}

+ (void)searchScrollView:(UIView *)view
{
    for (UIScrollView *subView in view.subviews) {
        // 是否显示在当前窗口中
        BOOL isShowOnKeyWindow = [UIView isShowOnKeyWindow:subView];
        
        if([subView isKindOfClass:[UIScrollView class]] && isShowOnKeyWindow)
        {
            CGPoint contentOffset = subView.contentOffset;
            contentOffset.y = -subView.contentInset.top;
            subView.contentOffset = contentOffset;
        }
        [self searchScrollView:subView];
    }
}

+ (void)show
{
    [self showWindow];
}
@end
