//
//  LPYPublishSegementViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/5.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYPublishSegementViewController.h"
#import "LPYPlaceholderTextView.h"
#import "LPYShowTagView.h"

@interface LPYPublishSegementViewController () <UITextViewDelegate>
/** txtView */
@property (nonatomic,weak) LPYPlaceholderTextView *placeholderTextView;

/** tagView */
@property (nonatomic,weak) LPYShowTagView *showTagView;


@end

@implementation LPYPublishSegementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupTextView];
    
    // 监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyboardDidChangeFrame:(NSNotification *)note
{
    CGRect keyboardStartRect = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardEndRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = keyboardEndRect.origin.y - keyboardStartRect.origin.y;
    self.showTagView.transform = CGAffineTransformTranslate(self.showTagView.transform, 0, ty);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)setupTextView
{
    LPYPlaceholderTextView *textView = [[LPYPlaceholderTextView alloc] init];
    textView.delegate = self;
    textView.frame = [UIScreen mainScreen].bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理";
    [self.view addSubview:textView];
    self.placeholderTextView = textView;
    
    // 显示标签
    LPYShowTagView *tagView = [LPYShowTagView viewFromXib];
    CGFloat tagH = 100;
    tagView.frame = CGRectMake(0, LPYScreenHeight - tagH, LPYScreenWidth, tagH);
    [self.view addSubview:tagView];
    self.showTagView = tagView;
}

- (void)setupNav
{
    self.navigationItem.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(btnLeftClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(btnRightClick)];
    self.navigationItem.rightBarButtonItem.enabled = false;
    // 强制重绘
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)btnLeftClick
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnRightClick
{
    LPYLog(@"-------");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
