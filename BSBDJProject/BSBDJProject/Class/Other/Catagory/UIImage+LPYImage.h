//
//  UIImage+LPYImage.h
//  01-彩票
//
//  Created by 刘蒲艳 on 15/6/27.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LPYImage)
/**
 *  图片显示原来的内容，不被渲染
 *
 *  @return <#return value description#>
 */
+ (instancetype)imageRenderingModeAlwaysOriginalNamed:(NSString *)name;

/**
 *  图片中间部分拉伸
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype) imageStretchableWithNamed:(NSString *)name;
@end
