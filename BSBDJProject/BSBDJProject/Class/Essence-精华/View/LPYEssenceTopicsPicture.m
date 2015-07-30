//
//  LPYEssenceTopicsPicture.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/30.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicsPicture.h"
#import <UIImageView+WebCache.h>

@interface LPYEssenceTopicsPicture()
@property (weak, nonatomic) IBOutlet UIImageView *gifFlagImage;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;

@property (weak, nonatomic) IBOutlet UIButton *btnSeeLargeImage;

@end

@implementation LPYEssenceTopicsPicture

- (void)awakeFromNib
{
    // 取消自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)essenceTopicsPicture
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)setEssenceTopicModel:(LPYEssenceTopicModel *)essenceTopicModel
{
    _essenceTopicModel = essenceTopicModel;
    [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:self.essenceTopicModel.pic_large]];
    // 判断是否gif图片
    NSString *suffix = self.essenceTopicModel.pic_large.pathExtension;
    self.gifFlagImage.hidden = ![suffix.lowercaseString isEqualToString:@"gif"];
    // 是否显示 点击大图查看
    self.btnSeeLargeImage.hidden = !self.essenceTopicModel.isLargePicture;
    if(self.essenceTopicModel.isLargePicture)
    {
        // 绘图
        UIGraphicsBeginImageContextWithOptions(self.essenceTopicModel.pictureFrame.size, YES, 1);
        // 获取上下文
        CGRect pictureF = self.essenceTopicModel.pictureFrame;
        pictureF.size.height = self.essenceTopicModel.pictureRealHeight;
        [self.pictureImage.image drawInRect:pictureF];
        
        self.pictureImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 大图
        self.pictureImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    else
    {
        self.pictureImage.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
