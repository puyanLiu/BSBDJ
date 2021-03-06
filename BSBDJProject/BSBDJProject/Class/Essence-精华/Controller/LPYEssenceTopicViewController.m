//
//  LPYEssenceSegmentViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/27.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicViewController.h"
#import "LPYEssenceTopicModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import "LPYEssenceTopicsCell.h"
#import "LPYEssenceTopicCommentViewController.h"
#import "LPYNewViewController.h"

@interface LPYEssenceTopicViewController ()
/** topics */
@property (nonatomic,strong) NSMutableArray *essenceTopics;

/** params */
@property (nonatomic,strong) NSMutableDictionary *params;

@property (nonatomic,copy) NSString *maxtime;

/** 记录当前选中的索引 */
@property (nonatomic,assign) NSInteger lastSelectedIndex;
@end

@implementation LPYEssenceTopicViewController
- (NSMutableArray *)essenceTopics
{
    if(_essenceTopics == nil)
    {
        _essenceTopics = [NSMutableArray array];
    }
    
    return _essenceTopics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景色
    LPYBackgroundColor;
    [self setupTableView];

    CGFloat top = LPYEssenceNavigationAndStateH + LPYEssenceTitleH;
    CGFloat bottom = LPYEssenceTabBarH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelectedClick) name:LPYTabBarDidClickNotification object:nil];
}

// 点击更新数据源
- (void)tabBarSelectedClick
{
    if(self.tabBarController.selectedViewController == self.navigationController)
    {
        // 更新数据源 view在当前窗口显示
        // 在当前界面连续点击两次，才刷新
        if([UIView isShowOnKeyWindow:self.view] && self.lastSelectedIndex == self.tabBarController.selectedIndex)
        {
            [self.tableView.header beginRefreshing];
        }
    }
    // 记录当前选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

static NSString * const essenceTopicsCell = @"essenceTopicsCell";

// 数据刷新
- (void)setupTableView
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHeaderData)];
    // 开始刷新
    // 自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
    self.tableView.footer.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPYEssenceTopicsCell class]) bundle:nil] forCellReuseIdentifier:essenceTopicsCell];
}

- (NSString *)a
{
    // 新帖 父控制器LPYNewViewController
    if([self.parentViewController isKindOfClass:[LPYNewViewController class]])
    {
        return @"newlist";
    }
    // 精华 父控制器 LPYEssenceViewController
    return @"list";
}

// 加载头部数据
- (void)loadHeaderData
{
    AFHTTPSessionManager *httpSessionManger = [AFHTTPSessionManager manager];
//    httpSessionManger.requestSerializer.timeoutInterval = 10;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = [self a];
    params[@"c"] = @"data";
    params[@"type"] = @(self.essenceTopicType);
    
    self.params = params;
    [httpSessionManger GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(self.params != params)
            return ;
        // 清空缓存数据
        [self.essenceTopics removeAllObjects];
        
        [self.essenceTopics addObjectsFromArray:[LPYEssenceTopicModel objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
        self.tableView.footer.hidden = self.essenceTopics.count <= 0;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(self.params != params)
            return ;
        [SVProgressHUD showErrorWithStatus:@"数据加载失败。。。。"];
        // 结束刷新
        [self.tableView.header endRefreshing];
    }];
}

// 加载尾部数据
- (void)loadFooterData
{
    AFHTTPSessionManager *httpSessionManger = [AFHTTPSessionManager manager];
//    httpSessionManger.requestSerializer.timeoutInterval = 10;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = [self a];
    params[@"c"] = @"data";
    params[@"type"] = @(self.essenceTopicType);
    params[@"maxtime"] = self.maxtime;
    
    self.params = params;
    
    [httpSessionManger GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if(self.params != params)
            return ;
        
        // 保存数据
        [self.essenceTopics addObjectsFromArray:[LPYEssenceTopicModel objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
        
        self.tableView.footer.hidden = self.essenceTopics.count <= 0;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(self.params != params)
            return ;
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        // 结束刷新
        [self.tableView.footer endRefreshing];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.essenceTopics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LPYEssenceTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:essenceTopicsCell];
    LPYEssenceTopicModel *model = self.essenceTopics[indexPath.row];
    cell.essenceTopicModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPYEssenceTopicModel *model = self.essenceTopics[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPYEssenceTopicModel *model = self.essenceTopics[indexPath.row];
    // 跳转到评论页面
    LPYEssenceTopicCommentViewController *commentViewController = [[LPYEssenceTopicCommentViewController alloc] init];
    commentViewController.essenceTopicModel = model;
    [self.navigationController pushViewController:commentViewController animated:YES];
}
@end
