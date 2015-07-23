//
//  UIView+LPYView.h
//  01-彩票
//
//  Created by 刘蒲艳 on 15/6/27.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LPYView)
// 分类如果写@property,只会生成方法声明，不会自动生成成员属性及方法实现

/**
 *  高度
 */
@property (nonatomic,assign) CGFloat height;

/**
 *  宽度
 */
@property (nonatomic,assign) CGFloat width;

/**
 *  x
 */
@property (nonatomic,assign) CGFloat x;

/**
 *  y
 */
@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;

@end
