//
//  UIBarButtonItem+LPYBarButtonItem.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LPYBarButtonItem)

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

@end
