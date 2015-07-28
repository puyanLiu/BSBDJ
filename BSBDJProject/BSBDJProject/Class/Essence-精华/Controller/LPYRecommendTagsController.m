//
//  LPYRecommendTagsController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/25.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYRecommendTagsController.h"
#import "LPYRecommendTagsModel.h"
#import "LPYRecommendTagsCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface LPYRecommendTagsController ()

/** recommendTags */
@property (nonatomic,strong) NSMutableArray *recommendTags;

/** AFHttpSession */
@property (nonatomic,strong) AFHTTPSessionManager *httpSessionMgr;

@end

@implementation LPYRecommendTagsController

- (NSMutableArray *)recommendTags
{
    if(_recommendTags == nil)
    {
        _recommendTags = [NSMutableArray array];
    }
    
    return _recommendTags;
}

- (AFHTTPSessionManager *)httpSessionMgr
{
    if(_httpSessionMgr == nil)
    {
        _httpSessionMgr = [[AFHTTPSessionManager alloc] init];
    }
    
    return _httpSessionMgr;
}

static NSString * const recommend = @"recommendCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPYRecommendTagsCell class]) bundle:nil] forCellReuseIdentifier:recommend];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    LPYBackgroundColor;
    
    self.title = @"推荐标签";
    
    [self initData];
}

- (void)initData {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 请求数据
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"tag_recommend";
    paras[@"action"] = @"sub";
    paras[@"c"] = @"topic";
    
    [self.httpSessionMgr GET:@"http://api.budejie.com/api/api_open.php" parameters:paras success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.recommendTags = [LPYRecommendTagsModel objectArrayWithKeyValuesArray:responseObject];
        // 刷新表格
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        _recommendTags = [NSMutableArray array];
        // 加载失败
        [SVProgressHUD showErrorWithStatus:@"加载失败。。。。。"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPYRecommendTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:recommend];
    LPYRecommendTagsModel *recommendModel = self.recommendTags[indexPath.row];
    cell.recommendTagsModel = recommendModel;
    return cell;
}

// 控件销毁
- (void)dealloc
{
    [self.httpSessionMgr.operationQueue cancelAllOperations];
}
@end
