//
//  LPYEssenceTopicsVoice.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/1.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicsVoice.h"
#import "LPYLabeledCircularProgressView.h"
#import "LPYPictureLargeViewController.h"
#import <UIImageView+WebCache.h>

@interface LPYEssenceTopicsVoice()
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;

@property (weak, nonatomic) IBOutlet UILabel *lblPlayCount;

@property (weak, nonatomic) IBOutlet UILabel *lblPlayLength;

@property (weak, nonatomic) IBOutlet LPYLabeledCircularProgressView *circluarProgressView;

@end

@implementation LPYEssenceTopicsVoice

- (void)awakeFromNib
{
    // 取消自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
    self.voiceImageView.userInteractionEnabled = YES;
    
    // 给图片添加点击事件
    [self.voiceImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnVoiceImage)]];
}

- (void)btnVoiceImage
{
    LPYPictureLargeViewController *pictureLarge = [[LPYPictureLargeViewController alloc] init];
    pictureLarge.view.frame = CGRectMake(0, 0, LPYScreenWidth, LPYScreenHeight);
    pictureLarge.essenceTopicModel = self.essenceTopicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureLarge animated:YES completion:nil];
}

- (void)setEssenceTopicModel:(LPYEssenceTopicModel *)essenceTopicModel
{
    _essenceTopicModel = essenceTopicModel;
    // 下载图片
    self.circluarProgressView.hidden = NO;
    self.lblPlayCount.text = [NSString stringWithFormat:@"%zd播放", self.essenceTopicModel.playcount];
    self.lblPlayLength.text = [NSString stringWithFormat:@"%02zd:%02zd", self.essenceTopicModel.voicetime / 60, self.essenceTopicModel.voicetime % 60];
    // 加载图片进度，防止因网速慢，Cell的循环利用，加载别的图片的进度
    [self.circluarProgressView setProgress:self.essenceTopicModel.pictureProgress animated:NO];
    
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:self.essenceTopicModel.pic_large] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.essenceTopicModel.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.circluarProgressView setProgress:self.essenceTopicModel.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 下载完成
        self.circluarProgressView.hidden = YES;
    }];
}

@end
