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

/** contentScrollView */
@property (nonatomic,strong) UIScrollView *contentScrollView;

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
    
    // 添加内容
    [self addContentView];
    
    // 添加标题
    [self addTitleView];
    
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
        // 避免跟系统控件的tag冲突
        btn.tag = i + 1;
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
            
            // 添加第一个控制器内容
            [self scrollViewDidEndDecelerating:self.contentScrollView];
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
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(self.view.width * (self.titleView.subviews.count - 1), 0);
    self.contentScrollView = contentView;
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
        self.selectedView.width = self.btnSelect.titleLabel.width;
        self.selectedView.centerX = self.btnSelect.centerX;
    }];
    
    // 添加内容
    [self.contentScrollView setContentOffset:CGPointMake((self.btnSelect.tag - 1) * self.view.width, 0) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat viewW = self.view.width;
    CGFloat viewH = self.view.height;
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / viewW);
    UITableViewController *viewController = self.childViewControllers[index];
    viewController.view.frame = CGRectMake(scrollView.contentOffset.x, 0, viewW, viewH);
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    viewController.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    [scrollView addSubview:viewController.view];
}

// 拖拽结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    CGFloat viewW = self.view.width;
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / viewW);
    UIButton *btn = (UIButton *)[self.titleView viewWithTag:index + 1] ;
    [self btnTitleClick:btn];
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
