//
//  LPYShowTagView.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/6.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYShowTagView.h"

@implementation LPYShowTagView

+ (instancetype)showTagView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
