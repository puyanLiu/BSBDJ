//
//  LPYHelpClass.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/4.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPYHelpClass : NSObject

// 处理按钮上边显示数值的情况
+ (void)setTopicWithButton:(UIButton *)btn withCount:(NSInteger)count withTitle:(NSString *)title;

// 处理文本上边显示数值的情况
+ (void)setTopicWithLabel:(UILabel *)label withCount:(NSInteger)count;
@end
