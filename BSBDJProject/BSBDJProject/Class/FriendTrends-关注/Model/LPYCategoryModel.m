//
//  LPYCategoryModel.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYCategoryModel.h"
#import <MJExtension.h>

@implementation LPYCategoryModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    // key是模型中的属性名，value是从字典中对应的内容
    return @{@"ID" : @"id"};
}

@end
