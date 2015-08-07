//
//  LPYEssenceTopicCommentViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/2.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicCommentViewController.h"
#import "UIBarButtonItem+LPYBarButtonItem.h"
#import "LPYEssenceTopicsCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LPYEssenceTopicCommentModel.h"
#import <SVProgressHUD.h>
#import "LPYEssenceTopicCommentHeaderView.h"
#import "LPYEssenceTopicsCommentCell.h"

@interface LPYEssenceTopicCommentViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CommentBottomConstraint;

/** 最热评论 */
@property (nonatomic,strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic,strong) NSMutableArray *latestComments;

/** total */
@property (nonatomic,assign) NSInteger total;

/** page */
@property (nonatomic,assign) NSInteger page;

/** 保存Cell的最新评论 */
@property (nonatomic,strong) LPYEssenceTopicCommentModel *save_top_cmt;

/** afn */
@property (nonatomic,strong) AFHTTPSessionManager *httpSession;
@end

@implementation LPYEssenceTopicCommentViewController
- (AFHTTPSessionManager *)httpSession
{
    if(_httpSession == nil)
    {
        _httpSession = [AFHTTPSessionManager manager];
    }
    
    return _httpSession;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置导航条
    [self setNav];
    // 设置UITableView
    [self setUpTableViewHeader];
    
    [self setUpTableViewRefresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardChangeFrame:(NSNotification *)note
{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.CommentBottomConstraint.constant = LPYScreenHeight - frame.origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

// 移除键盘
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.view endEditing:YES];
//}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if(self.save_top_cmt)
    {
        self.essenceTopicModel.top_cmt = self.save_top_cmt;
        // 重新计算cell的高度
        [self.essenceTopicModel setValue:@0 forKey:@"cellHeight"];
        self.save_top_cmt = nil;
    }
    
    // 结束任务
//    [self.httpSession.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 使用此方法结束任务后，将不能开启新的任务
    [self.httpSession invalidateSessionCancelingTasks:YES];
}

- (void)setNav
{
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"comment_nav_item_share_icon"] highlightedImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click"] target:nil action:nil];
}

static NSString *cellID = @"comment";

- (void)setUpTableViewHeader
{
    self.tableView.backgroundColor = LPYGlobalColor;
    // 拖动tableView的时候，移除键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPYEssenceTopicsCommentCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 动态调整Cell高度 ,自动适应，iOS8.0之后可用
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    LPYEssenceTopicsCell *header = [LPYEssenceTopicsCell essenceTopicsCell];
    
    UIView *view = [[UIView alloc] init];
    
    if(self.essenceTopicModel.top_cmt)
    {
        self.save_top_cmt = self.essenceTopicModel.top_cmt;
        self.essenceTopicModel.top_cmt = nil;
        // 重新计算cell的高度
        [self.essenceTopicModel setValue:@0 forKey:@"cellHeight"];
    }
    view.height = self.essenceTopicModel.cellHeight + LPYEssenceTopicCellMargin;
    
    header.essenceTopicModel = self.essenceTopicModel;
    header.frame = CGRectMake(0, 0, LPYScreenWidth, self.essenceTopicModel.height);
    
    [view addSubview:header];
    self.tableView.tableHeaderView = view;
}

- (void)setUpTableViewRefresh
{
    self.tableView.header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTableViewData)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.footer.hidden = YES;
}

- (void)loadTableViewData
{
    // 结束之前的任务
    [self.httpSession.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.essenceTopicModel.ID;
    params[@"page"] = @1;
    params[@"hot"] = @1;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if([responseObject count] > 0)
        {
            self.page = 1;
            self.hotComments = [LPYEssenceTopicCommentModel objectArrayWithKeyValuesArray:responseObject[@"hot"]];
            self.latestComments = [LPYEssenceTopicCommentModel objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.total = [responseObject[@"total"] integerValue];
            // 刷新tableView
            [self.tableView reloadData];
            if(self.latestComments.count > 0 && self.total > self.latestComments.count)
            {
                self.tableView.footer.hidden = NO;
            }
            else
            {
                self.tableView.footer.hidden = YES;
            }
        }
        
        // 结束刷新
        [self.tableView.header endRefreshing];
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败。。。"];
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreData
{
    // 结束之前的任务
    [self.httpSession.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.essenceTopicModel.ID;
    params[@"page"] = @(page);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if([responseObject count] > 0)
        {
            self.page++;
            
            [self.latestComments addObjectsFromArray:[LPYEssenceTopicCommentModel objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            
            // 刷新tableView
            [self.tableView reloadData];
        }
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
        
        if(self.total <= self.latestComments.count)
        {
            self.tableView.footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败。。。"];
        [self.tableView.footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.hotComments.count > 0)
    {
        return 2;
    }
    else if(self.latestComments.count > 0)
    {
        return 1;
    }
    else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if(section == 0)
    {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

// 判断应该加载那组数据
- (NSArray *)contentInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (LPYEssenceTopicCommentModel *)commentModelWithIndexPath:(NSIndexPath *)indexPath
{
    NSArray *content = [self contentInSection:indexPath.section];
    LPYEssenceTopicCommentModel *model = content[indexPath.row];
    return model;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPYEssenceTopicsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    LPYEssenceTopicCommentModel *model = [self commentModelWithIndexPath:indexPath];
    cell.commentModel = model;
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(section == 0)
//    {
//        return self.hotComments.count ? @"最热评论" : @"最新评论";
//    }
//    return self.latestComments.count ? @"最新评论" : @"";
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = LPYGlobalColor;
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = LPYColor(67, 67, 67);
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    label.width = 200;
//    label.x = LPYEssenceTopicCellMargin;
//    [view addSubview:label];
//    if(section == 0)
//    {
//        label.text = self.hotComments.count ? @"最热评论" : @"最新评论";
//    }
//    else
//    {
//        label.text = self.latestComments.count ? @"最新评论" : @"";
//    }
//    return view;
//}

// 循环利用
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *ID = @"header";
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    UILabel *label = nil;
//    NSInteger headerLabel = 111;
//    if(header == nil)
//    {
//        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
//        label = [[UILabel alloc] init];
//        label.textColor = LPYColor(67, 67, 67);
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        label.width = 200;
//        label.x = LPYEssenceTopicCellMargin;
//        [header addSubview:label];
//    }
//    else
//    {
//        label = (UILabel *)[header viewWithTag:headerLabel];
//    }
//    if(section == 0)
//    {
//        label.text = self.hotComments.count ? @"最热评论" : @"最新评论";
//    }
//    else
//    {
//        label.text = self.latestComments.count ? @"最新评论" : @"";
//    }
//
//    return header;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LPYEssenceTopicCommentHeaderView *header = [LPYEssenceTopicCommentHeaderView essenceTopicCommentHeaderView:tableView];
    if(section == 0)
    {
        header.headerTitle = self.hotComments.count ? @"最热评论" : @"最新评论";
    }
    else
    {
        header.headerTitle = self.latestComments.count ? @"最新评论" : @"";
    }
    return header;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 22;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 单例，如果在其他地方使用，先清空一下menuController
    UIMenuController *menu = [UIMenuController sharedMenuController];
    // 显示
    if(menu.isMenuVisible)
    {
        LPYLog(@"------");
        // 隐藏
        [menu setMenuVisible:NO animated:YES];
        return;
    }

    LPYEssenceTopicsCommentCell *cell = (LPYEssenceTopicsCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    // 成为第一响应者
    [cell becomeFirstResponder];
    
    
    menu.menuItems = @[
    [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(itemLoveClick:)],
    [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(itemReplyClick:)],
    [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(itemReportClick:)]
                    ];
    CGRect rect = cell.bounds;
    rect.origin.y = cell.height * 0.5;
    [menu setTargetRect:rect inView:cell];
    [menu setMenuVisible:YES animated:YES];
}

- (void)itemLoveClick:(UIMenuItem *)item
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LPYEssenceTopicCommentModel *model = [self commentModelWithIndexPath:indexPath];
    
    LPYLog(@"顶-----%@",model.content);
}

- (void)itemReplyClick:(UIMenuItem *)item
{
    LPYLog(@"回复");
}

- (void)itemReportClick:(UIMenuItem *)item
{
    LPYLog(@"举报");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
