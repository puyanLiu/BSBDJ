//
//  LPYPictureLargeViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/31.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYPictureLargeViewController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "LPYLabeledCircularProgressView.h"

@interface LPYPictureLargeViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/** imageView */
@property (nonatomic,weak) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet LPYLabeledCircularProgressView *circluarProgressView;

@end

@implementation LPYPictureLargeViewController
- (UIImageView *)imageView
{
    if(_imageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        _imageView = imageView;
    }
    
    return _imageView;
}

- (void)setEssenceTopicModel:(LPYEssenceTopicModel *)essenceTopicModel
{
    _essenceTopicModel = essenceTopicModel;
    // 设置Image的尺寸
    CGFloat imageH = LPYScreenWidth * _essenceTopicModel.height / _essenceTopicModel.width;
    self.imageView.frame = CGRectMake(0, 0, LPYScreenWidth, imageH);
    self.imageView.centerX = LPYScreenWidth * 0.5;
    self.imageView.centerY = LPYScreenHeight < imageH ? imageH * 0.5 : LPYScreenHeight * 0.5;
    self.scrollView.contentSize = CGSizeMake(0, imageH);
    
    // 显示进度
    [self.circluarProgressView setProgress:self.essenceTopicModel.pictureProgress animated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_essenceTopicModel.pic_large] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.circluarProgressView.hidden = NO;
        self.essenceTopicModel.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.circluarProgressView setProgress:self.essenceTopicModel.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.circluarProgressView.hidden = YES;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 1.5;
    // 给图片添加点击事件
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
}

// UIScrollView 缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)btnShareClick {
    NSLog(@"分享");
}

- (IBAction)btnSaveClick {
    if(self.imageView.image == nil)
    {
        [SVProgressHUD showErrorWithStatus:@"图片还未加载完成。。。。。"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error)
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
}

@end
