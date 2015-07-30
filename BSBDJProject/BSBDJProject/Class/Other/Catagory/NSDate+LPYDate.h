//
//  NSDate+LPYDate.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/29.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LPYDate)

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
