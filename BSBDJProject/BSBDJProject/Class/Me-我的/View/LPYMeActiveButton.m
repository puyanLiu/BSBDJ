//
//  LPYMeActiveButton.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/7.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYMeActiveButton.h"

@implementation LPYMeActiveButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 设置字体
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageWH = self.height * 0.5;
    self.imageView.width = imageWH;
    self.imageView.height = imageWH;
    self.imageView.y = self.height * 0.1;
    self.imageView.x = (self.width - self.imageView.width) * 0.5;
    
    self.titleLabel.height = self.height * 0.3;
    self.titleLabel.width = self.width;
    self.titleLabel.x = 0;
    self.titleLabel.y = self.height - self.titleLabel.height;
}

@end
