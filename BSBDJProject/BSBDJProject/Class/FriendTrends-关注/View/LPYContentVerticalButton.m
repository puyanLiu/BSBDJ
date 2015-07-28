//
//  LPYContentVerticalButton.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/26.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYContentVerticalButton.h"

@implementation LPYContentVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // image
    self.imageView.centerX = self.frame.size.width * 0.5;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // title
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
