//
//  LPYEssenceViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/22.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceViewController.h"
#import "LPYRecommendTagsController.h"
#import "LPYEssenceAllViewController.h"
#import "LPYEssencePictureViewController.h"
#import "LPYEssenceSegmentViewController.h"
#import "LPYEssenceSoundsViewController.h"
#import "LPYEssenceVedioViewController.h"


@interface LPYEssenceViewController () <UIScrollViewDelegate>
/** 选中的标题 */
@property (nonatomic,weak) UIButton *btnSelect;

/** selectedView */
@property (nonatomic,weak) UIView *selectedView;

/** titleView */
@property (nonatomic,weak) UIView *titleView;


@end

@implementation LPYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航条
    [self setUpNav];
    
    // 设置背景
    LPYBackgroundColor;
    
    // 不调整UIEdge
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加子控制器
    [self addAllChildViewController];
    
    // 添加标题
    [self addTitleView];
    
    // 添加内容
    [self addContentView];
}

// 添加标题View
- (void)addTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = LPYColor(252, 252, 252);
    titleView.frame = CGRectMake(0, 64, self.view.width, 40);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 添加底部标签
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor redColor];
    CGFloat selectedViewH = 2;
    
    CGFloat btnW = titleView.width / self.childViewControllers.count;
    for(int i = 0; i < self.childViewControllers.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = titleView.height;
        [btn setTitle:[self.childViewControllers[i] title] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnTitleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        
        if(i == 0)
        {
            [btn layoutIfNeeded];
            selectedView.frame = CGRectMake((btn.width - btn.titleLabel.width) * 0.5, titleView.height - selectedViewH, btn.titleLabel.width, selectedViewH);
        }
    }
    
    
    [titleView addSubview:selectedView];
    self.selectedView = selectedView;
}

// 添加内容View
- (void)addContentView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = [UIColor yellowColor];
    contentView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    contentView.contentSize = CGSizeMake(self.view.width * (self.titleView.subviews.count - 1), 0);
    contentView.delegate = self;
    [self.view insertSubview:contentView atIndex:0];
}

- (void)addAllChildViewController
{
    LPYEssenceAllViewController *essenceAll = [[LPYEssenceAllViewController alloc] init];
    essenceAll.title = @"全部";
    [self addChildViewController:essenceAll];
    
    LPYEssenceVedioViewController *vedio = [[LPYEssenceVedioViewController alloc] init];
    vedio.title = @"视频";
    [self addChildViewController:vedio];
    
    LPYEssenceSoundsViewController *sounds = [[LPYEssenceSoundsViewController alloc] init];
    sounds.title = @"声音";
    [self addChildViewController:sounds];
    
    LPYEssencePictureViewController *picture = [[LPYEssencePictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    LPYEssenceSegmentViewController *segement = [[LPYEssenceSegmentViewController alloc] init];
    segement.title = @"段子";
    [self addChildViewController:segement];
}

- (void)btnTitleClick:(UIButton *)sender
{
    self.btnSelect.enabled = YES;
    self.btnSelect = sender;
    sender.enabled = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedView.width = sender.titleLabel.width;
        self.selectedView.centerX = sender.centerX;
    }];
    
    // 添加内容
    
}

// scrollView 减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)setUpNav
{
    // 标题
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageView;
    
    // 左边内容
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemClick
{
    LPYRecommendTagsController *recommendTagsCV = [[LPYRecommendTagsController alloc] init];
    [self.navigationController pushViewController:recommendTagsCV animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
