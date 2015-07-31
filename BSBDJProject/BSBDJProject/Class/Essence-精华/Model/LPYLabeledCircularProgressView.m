//
//  LPYLabeledCircularProgressView.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/30.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYLabeledCircularProgressView.h"

@implementation LPYLabeledCircularProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *progressLabel = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [progressLabel stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
