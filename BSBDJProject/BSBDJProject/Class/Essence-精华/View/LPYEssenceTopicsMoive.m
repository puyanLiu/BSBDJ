//
//  LPYEssenceTopicsMoive.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/1.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicsMoive.h"
#import <UIImageView+WebCache.h>

@interface LPYEssenceTopicsMoive()

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;

@property (weak, nonatomic) IBOutlet UILabel *lblPlayCount;

@property (weak, nonatomic) IBOutlet UILabel *lblPlayLength;

@end

@implementation LPYEssenceTopicsMoive

- (void)awakeFromNib
{
    // 取消自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
    self.movieImageView.userInteractionEnabled = YES;
    
    // 给图片添加点击事件
    [self.movieImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnMoiveImage)]];
}

- (void)btnMoiveImage
{
    
}

+ (instancetype)essenceTopicsMoive
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)setEssenceTopicModel:(LPYEssenceTopicModel *)essenceTopicModel
{
    _essenceTopicModel = essenceTopicModel;
    // 下载图片
    self.lblPlayCount.text = [NSString stringWithFormat:@"%zd播放", self.essenceTopicModel.playcount];
    self.lblPlayLength.text = [NSString stringWithFormat:@"%02zd:%02zd", self.essenceTopicModel.videotime / 60, self.essenceTopicModel.videotime % 60];
    
    [self.movieImageView sd_setImageWithURL:[NSURL URLWithString:self.essenceTopicModel.pic_large] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}

@end
