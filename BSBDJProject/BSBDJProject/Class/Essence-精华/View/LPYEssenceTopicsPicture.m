//
//  LPYEssenceTopicsPicture.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/30.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicsPicture.h"
#import <UIImageView+WebCache.h>
#import "LPYLabeledCircularProgressView.h"
#import "LPYPictureLargeViewController.h"

@interface LPYEssenceTopicsPicture()
@property (weak, nonatomic) IBOutlet UIImageView *gifFlagImage;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;

@property (weak, nonatomic) IBOutlet UIButton *btnSeeLargeImage;

@property (weak, nonatomic) IBOutlet LPYLabeledCircularProgressView *circluarProgressView;
@end

@implementation LPYEssenceTopicsPicture

- (void)awakeFromNib
{
    // 取消自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.pictureImage.userInteractionEnabled = YES;
    // 给图片添加点击事件
    [self.pictureImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnPictureImage)]];
}

- (IBAction)btnPictureImage
{
    LPYPictureLargeViewController *pictureLarge = [[LPYPictureLargeViewController alloc] init];
    pictureLarge.view.frame = CGRectMake(0, 0, LPYScreenWidth, LPYScreenHeight);
    pictureLarge.essenceTopicModel = self.essenceTopicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureLarge animated:YES completion:nil];
}

+ (instancetype)essenceTopicsPicture
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)setEssenceTopicModel:(LPYEssenceTopicModel *)essenceTopicModel
{
    _essenceTopicModel = essenceTopicModel;
    // 下载图片
    self.circluarProgressView.hidden = NO;
    
    // 加载图片进度，防止因网速慢，Cell的循环利用，加载别的图片的进度
    [self.circluarProgressView setProgress:self.essenceTopicModel.pictureProgress animated:NO];
    
    // 判断是否gif图片
    NSString *suffix = self.essenceTopicModel.pic_large.pathExtension;
    self.gifFlagImage.hidden = ![suffix.lowercaseString isEqualToString:@"gif"];
    // 是否显示 点击大图查看
    self.btnSeeLargeImage.hidden = !self.essenceTopicModel.isLargePicture;
    
    [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:self.essenceTopicModel.pic_large] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.essenceTopicModel.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.circluarProgressView setProgress:self.essenceTopicModel.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 下载完成
        self.circluarProgressView.hidden = YES;
        
        if(self.essenceTopicModel.isLargePicture)
        {
            // 绘图 当图片过大，显示图片顶部完整内容
            UIGraphicsBeginImageContextWithOptions(self.essenceTopicModel.pictureFrame.size, YES, 0.0);
            CGRect pictureF = self.essenceTopicModel.pictureFrame;
    
            [self.pictureImage.image drawInRect:CGRectMake(0, 0, pictureF.size.width, self.essenceTopicModel.pictureRealHeight)];
    
            self.pictureImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
            UIGraphicsEndImageContext();
        }
    }];
}

@end
