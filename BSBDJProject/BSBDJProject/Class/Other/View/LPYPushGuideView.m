//
//  LPYPushGuideView.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/26.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYPushGuideView.h"

@implementation LPYPushGuideView

- (IBAction)clost {
    [self removeFromSuperview];
}

+ (void)show
{
    // 判断软件版本，只是第一次安装或版本改变的时候显示
    // 系统版本
    NSString * const versionKey = @"CFBundleShortVersionString";
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] stringForKey:versionKey];
    // 当前版本
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil]];
    NSString *currentVersion = dict[versionKey];
    if(![oldVersion isEqualToString:currentVersion])
    {
        // 显示推送引导
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LPYPushGuideView *guide = [LPYPushGuideView viewFromXib];
        guide.frame = window.frame;
        [window addSubview:guide];
        
        // 保存
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
        // 同步
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
