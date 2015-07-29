//
//  LPYEssenceSegmentViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/27.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceSegmentViewController.h"
#import "LPYEssenceTopicModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "LPYEssenceTopicsCell.h"

@interface LPYEssenceSegmentViewController ()
/** topics */
@property (nonatomic,strong) NSMutableArray *essenceTopics;

/** params */
@property (nonatomic,strong) NSMutableDictionary *params;

@property (nonatomic,copy) NSString *maxtime;
@end

@implementation LPYEssenceSegmentViewController
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

// 加载头部数据
- (void)loadHeaderData
{
    AFHTTPSessionManager *httpSessionManger = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
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
        // 结束刷新
        [self.tableView.header endRefreshing];
    }];
}

// 加载尾部数据
- (void)loadFooterData
{
    AFHTTPSessionManager *httpSessionManger = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
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
    cell.essenceTopicModel = self.essenceTopics[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
@end
