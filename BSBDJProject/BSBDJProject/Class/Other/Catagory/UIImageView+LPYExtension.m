//
//  UIImageView+LPYExtension.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/7.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "UIImageView+LPYExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (LPYExtension)

- (void)setHeaderImageWithUrl:(NSString *)url
{
    UIImage *placeholderImage = [UIImage imageNamed:@"defaultUserIcon"];
    placeholderImage = [placeholderImage imageStyle];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = [image imageStyle] ? : placeholderImage;
    }];
}
@end
