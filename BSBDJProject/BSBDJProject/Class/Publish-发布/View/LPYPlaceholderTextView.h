//
//  LPYPlaceholderTextView.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/5.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPYPlaceholderTextView : UITextView
/** placeholder */
@property (nonatomic,copy) NSString *placeholder;

/** placeholderColor */
@property (nonatomic,strong) UIColor *placeholderColor;

/** uifont */
@property (nonatomic,strong) UIFont *placeholderFont;
@end
