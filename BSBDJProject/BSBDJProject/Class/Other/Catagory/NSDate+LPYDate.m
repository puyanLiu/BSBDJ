//
//  NSDate+LPYDate.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/29.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "NSDate+LPYDate.h"

@implementation NSDate (LPYDate)

- (NSTimeInterval)testDate:(NSString *)createDate
{
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *sinceDate = [df dateFromString:createDate];
    
    return [nowDate timeIntervalSinceDate:sinceDate];
}


// 返回时间差
+ (NSDateComponents *)deltaDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date toDate:[NSDate date] options:0];
}

// 返回时间组件
+ (NSDateComponents *)componentsFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
}


// 是否为昨天
+ (BOOL)isYesterday:(NSDate *)date
{
    // 当前时间组件
    NSDateComponents *currentComponents = [self componentsFromDate:[NSDate date]];
    // 待比较时间组件
    NSDateComponents *dateComponents = [self componentsFromDate:date];
    
    return currentComponents.year == dateComponents.year && currentComponents.month == dateComponents.month && (currentComponents.day - dateComponents.day == 1);
}

// 是否为今天
+ (BOOL)isToday:(NSDate *)date
{
    // 当前时间组件
    NSDateComponents *currentComponents = [self componentsFromDate:[NSDate date]];
    // 待比较时间组件
    NSDateComponents *dateComponents = [self componentsFromDate:date];
    
    return currentComponents.year == dateComponents.year && currentComponents.month == dateComponents.month && currentComponents.day == dateComponents.day;
}

// 是否为今年
+ (BOOL)isTodayYear:(NSDate *)date
{
    // 当前时间组件
    NSDateComponents *currentComponents = [self componentsFromDate:[NSDate date]];
    // 待比较时间组件
    NSDateComponents *dateComponents = [self componentsFromDate:date];
    
    return currentComponents.year == dateComponents.year;
}
@end
