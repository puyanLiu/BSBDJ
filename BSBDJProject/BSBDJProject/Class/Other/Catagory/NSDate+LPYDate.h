//
//  NSDate+LPYDate.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/29.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LPYDate)
/**
 当前时间 一分钟内 -----刚刚
 当前时间 一小时内 -----显示多少分钟前
 当前时间 24小时内 -----显示多少小时前
 昨天 -----显示昨天 时：分：秒
 今年 -----显示月：日 时：分：秒
 其他 -----显示年：月：日 时：分：秒
 */
+ (NSString *)timeShow:(NSString *)strDate;

// 返回时间差
+ (NSDateComponents *)deltaDate:(NSDate *)date;

// 返回时间组件
+ (NSDateComponents *)componentsFromDate:(NSDate *)date;

// 是否为昨天
+ (BOOL)isYesterday:(NSDate *)date;

// 是否为今天
+ (BOOL)isToday:(NSDate *)date;

// 是否为今年
+ (BOOL)isTodayYear:(NSDate *)date;

@end
