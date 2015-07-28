//
//  LPYRecommendViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/23.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYRecommendViewController.h"
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LPYCategoryCell.h"
#import "LPYRecommendUserModel.h"
#import "LPYUserCell.h"

@interface LPYRecommendViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** category model */
@property (nonatomic,strong) NSArray *categoriesData;

/** AFHttpSessionManager */
@property (nonatomic,strong) AFHTTPSessionManager *httpSessionMgr;

/** 存储参数 */
@property (nonatomic,strong) NSMutableDictionary *params;

@end

@implementation LPYRecommendViewController
- (NSArray *)categoriesData
{
    if(_categoriesData == nil)
    {
        _categoriesData = [NSArray array];
    }
    
    return _categoriesData;
}

- (AFHTTPSessionManager *)httpSessionMgr
{
    if(_httpSessionMgr == nil)
    {
        _httpSessionMgr = [[AFHTTPSessionManager alloc] init];
    }
    
    return _httpSessionMgr;
}

// 定义重利用标识
static NSString * const category = @"categoryCell";
static NSString * const user = @"userCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置背景图片
    LPYBackgroundColor;
    
    self.navigationItem.title = @"推荐关注";
    
    // TableView初始化设置
    [self setupTableView];
    
    // 初始化加载数据
    [self initData];
    
    // 推荐用户组刷新设置
    [self setupRefresh];
}

- (void)setupTableView
{
    self.categoryTableView.backgroundColor = [UIColor clearColor];
    
    self.userTableView.backgroundColor = [UIColor clearColor];
    
    // 设置UIEdge
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 60;
    
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.categoryTableView.showsHorizontalScrollIndicator = NO;
    self.categoryTableView.showsVerticalScrollIndicator = NO;
    self.userTableView.showsHorizontalScrollIndicator = NO;
    
    // 设置代理
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPYCategoryCell class]) bundle:nil] forCellReuseIdentifier:category];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPYUserCell class]) bundle:nil] forCellReuseIdentifier:user];
}

- (void)setupRefresh
{
    // 顶部刷新
    self.userTableView.header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerLoad)];
    
    // 底部刷新
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoad)];
}

// 顶部加载
- (void)headerLoad
{
    // 结束底部刷新
    [self.userTableView.footer endRefreshing];
    
    // 获取选中的类别
    LPYCategoryModel *categoryModel = [self getSelectedCategoryModel];
    // 存储参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"list";
    paras[@"c"] = @"subscribe";
    paras[@"category_id"] = categoryModel.ID;
    // 获取当前显示的页数
    categoryModel.currentPage = 1;
    paras[@"page"] = @(categoryModel.currentPage);
    
    self.params = paras;
    
    [self.httpSessionMgr GET:@"http://api.budejie.com/api/api_open.php" parameters:paras success:^(NSURLSessionDataTask *task, id responseObject) {
        // 总数
        NSInteger total = [responseObject[@"total"] intValue];
        categoryModel.recommendUsers = [NSMutableArray array];
        categoryModel.total = total;
        
        [categoryModel.recommendUsers addObjectsFromArray:[LPYRecommendUserModel objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
        // 判断是否最后一条记录
        if(self.params != paras)
            return;
        
        // 刷新表格
        [self.userTableView reloadData];
        
        if(categoryModel.recommendUsers.count == total)
        {
            // 提示用户已加载完毕
            [self.userTableView.footer noticeNoMoreData];
        }
        
        // 结束刷新
        [self.userTableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if(self.params != paras)
            return;
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败。。。。。。。。。。"];
        // 结束刷新
        [self.userTableView.header endRefreshing];
    }];
}

// 底部加载
- (void)footerLoad
{
    // 结束顶部刷新
    [self.userTableView.header endRefreshing];
    // 获取选中的类别
    LPYCategoryModel *categoryModel = [self getSelectedCategoryModel];
    // 存储参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"list";
    paras[@"c"] = @"subscribe";
    paras[@"category_id"] = categoryModel.ID;
    // 获取当前显示的页数
    paras[@"page"] = @(++categoryModel.currentPage);
    
    self.params = paras;
    
    [self.httpSessionMgr GET:@"http://api.budejie.com/api/api_open.php" parameters:paras success:^(NSURLSessionDataTask *task, id responseObject) {
        // 总数
        NSInteger total = [responseObject[@"total"] intValue];
        
        [categoryModel.recommendUsers addObjectsFromArray:[LPYRecommendUserModel objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
        if(self.params != paras)
            return ;
        
        // 刷新表格
        [self.userTableView reloadData];
        
        if(categoryModel.recommendUsers.count == total)
        {
            // 提示用户已加载完毕
            [self.userTableView.footer noticeNoMoreData];
            return;
        }
        
        // 结束刷新
        [self.userTableView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(self.params != paras)
            return ;
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败。。。。"];
        // 结束刷新
        [self.userTableView.footer endRefreshing];
    }];
}

- (void)initData
{
    // 等待
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
#warning 设置请求时间
    self.httpSessionMgr.requestSerializer.timeoutInterval = 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"category";
    paras[@"c"] = @"subscribe";
    // 请求类别信息
    [self.httpSessionMgr GET:@"http://api.budejie.com/api/api_open.php" parameters:paras success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.categoriesData = [LPYCategoryModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        // 默认选中第一个
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.categoryTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.categoryTableView didSelectRowAtIndexPath:indexPath];
        
        // 取消等待
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"数据加载失败。。。。。"];
    }];
}

// 设置数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.categoryTableView)
    {
        return self.categoriesData.count;
    }
    else
    {
        // 获取对应的用户推送信息
        LPYCategoryModel *category = [self getSelectedCategoryModel];
        NSInteger count = category.recommendUsers.count;
        // 如果没有数据，底部刷新样式不需要显示
        self.userTableView.footer.hidden = !(count > 0);
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.categoryTableView)
    {
        // 类别信息
        LPYCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:category];
        LPYCategoryModel *model = self.categoriesData[indexPath.row];
        cell.categoryModel = model;
        return cell;
    }
    else
    {
        // 推荐用户组
        LPYUserCell *cell = [tableView dequeueReusableCellWithIdentifier:user];
        // 获取选中类别
        LPYCategoryModel *categoryModel = [self getSelectedCategoryModel];
        LPYRecommendUserModel *model = categoryModel.recommendUsers[indexPath.row];
        cell.recommendUserModel = model;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新，避免相互影响
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    if(tableView == self.categoryTableView)
    {
        // 获取选中的类别
        LPYCategoryModel *categoryModel = [self getSelectedCategoryModel];
        
        [self getUserData:categoryModel];
        
#warning 记录当前顶部显示的记录,滚动到对应记录
    }
}


// 获取选中的类别信息
- (LPYCategoryModel *)getSelectedCategoryModel
{
    NSIndexPath *cateIndexPath = self.categoryTableView.indexPathForSelectedRow;
    if(cateIndexPath)
    {
        LPYCategoryModel *categoryModel = self.categoriesData[cateIndexPath.row];
        return categoryModel;
    }
    else
    {
        return nil;
    }
}

// 请求用户推荐信息
- (void)getUserData:(LPYCategoryModel *)categoryModel
{
    [self.userTableView reloadData];
    
    if(categoryModel.recommendUsers.count == 0)
    {
        // 顶部刷新
        [self.userTableView.header beginRefreshing];
    }
    else
    {
        // 底部刷新
        [self footerLoad];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 控制器销毁
- (void)dealloc
{
    [self.httpSessionMgr.operationQueue cancelAllOperations];
}

@end
