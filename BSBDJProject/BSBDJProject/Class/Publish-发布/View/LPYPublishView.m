//
//  LPYPublishView.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/31.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYPublishView.h"
#import "LPYContentVerticalButton.h"
#import <POP.h>

// 弹性影响因素
#define springEffect 10;
#define springDuration 0.1;

@interface LPYPublishView ()
/** slogan */
@property (nonatomic,weak) UIImageView *sloganView;

@end

@implementation LPYPublishView

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}


UIWindow *_window;
+ (void)show
{
    _window = [[UIWindow alloc] init];
//    _window.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    _window.frame = [UIScreen mainScreen].bounds;
    _window.hidden = NO;
    
    LPYPublishView *publish = [LPYPublishView publishView];
    publish.frame = [UIScreen mainScreen].bounds;
    [_window addSubview:publish];
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)setUp
{
    self.userInteractionEnabled = NO;
    
    // 加载按钮
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text" ,@"publish-audio", @"publish-review", @"publish-offline"];
    CGFloat btnW = 72;
    CGFloat btnH = btnW + 50;
    NSInteger col = 3;
    NSInteger row = titles.count % col == 0 ? titles.count / col : titles.count / col + 1;
    CGFloat btnStartXMargin = 20;
    CGFloat btnStartYMargin = (LPYScreenHeight - btnH * row) * 0.5;
    CGFloat btnWMargin = (LPYScreenWidth - btnW * col - btnStartXMargin * 2) / (col - 1);
    
    for(NSInteger i = 0; i < titles.count; i++)
    {
        LPYContentVerticalButton *btn = [[LPYContentVerticalButton alloc] init];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat btnX = btnStartXMargin + (i % col) * (btnW + btnWMargin);
        CGFloat btnY = btnStartYMargin + (i / col) * btnH;
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(btnOptionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        // 添加动画
        POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        pop.beginTime = CACurrentMediaTime() + i * springDuration;
        pop.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY - LPYScreenHeight, btnW, btnY)];
        pop.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        pop.springBounciness = springEffect;
        pop.springSpeed = springEffect;
        [btn pop_addAnimation:pop forKey:nil];
    }
    
    
    // 加载标语
    UIImage *slogan = [UIImage imageNamed:@"app_slogan"];
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:slogan];
    CGFloat centerY = LPYScreenHeight * 0.15;
    CGFloat centerX = LPYScreenWidth * 0.5;
    sloganView.center = CGPointMake(centerX, centerY - LPYScreenHeight);
    [self addSubview:sloganView];
    self.sloganView = sloganView;
    
    // 添加动画
    POPSpringAnimation *sloganpop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    sloganpop.beginTime = CACurrentMediaTime() + titles.count * springDuration;
    sloganpop.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    sloganpop.springBounciness = springEffect;
    sloganpop.springSpeed = springEffect;
    [sloganpop setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:sloganpop forKey:nil];
}

- (void)cancelWithCompletionBlock:(void(^)())completed
{
    self.userInteractionEnabled = NO;
    int i = 0;
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[LPYContentVerticalButton class]])
        {
            LPYContentVerticalButton *btn = (LPYContentVerticalButton *)view;
            
            // 添加动画
            POPBasicAnimation *pop = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
            pop.beginTime = CACurrentMediaTime() + i * springDuration;
            CGRect btnF = view.frame;
            btnF.origin.y += LPYScreenHeight;
            pop.toValue = [NSValue valueWithCGRect:btnF];
            [btn pop_addAnimation:pop forKey:nil];
            i++;
        }
    }
    
    // 标语添加动画
    POPBasicAnimation *sloganpop = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    sloganpop.beginTime = CACurrentMediaTime() + i * springDuration;
    CGPoint center = self.sloganView.center;
    center.y = LPYScreenHeight;
    sloganpop.toValue = [NSValue valueWithCGPoint:center];
    // 动画的执行节奏，一开始很慢，后来很快
    sloganpop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.sloganView pop_addAnimation:sloganpop forKey:nil];
    [sloganpop setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        // 执行取消事件
        //        if(completed)
        //        {
        //            completed();
        //        }
        
        
//        [self removeFromSuperview];
        
        _window = nil;
        
        !completed ? : completed();
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self btnCancelClick];
}

- (void)btnOptionClick:(UIButton *)sender
{
    [self cancelWithCompletionBlock:^{
        // 执行具体操作
        //        NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
        if(sender.tag == 1)
        {
            LPYLog(@"发视频");
        }
        else if(sender.tag == 2)
        {
            LPYLog(@"发图片");
        }
        else if(sender.tag == 3)
        {
            LPYLog(@"发段子");
        }
        else if(sender.tag == 4)
        {
            LPYLog(@"发声音");
        }
        else if(sender.tag == 5)
        {
            LPYLog(@"审帖");
        }
        else if(sender.tag == 6)
        {
            LPYLog(@"离线下载");
        }
        
    }];
}


- (IBAction)btnCancelClick {
    // 取消页面
    [self cancelWithCompletionBlock:nil];
}


@end
