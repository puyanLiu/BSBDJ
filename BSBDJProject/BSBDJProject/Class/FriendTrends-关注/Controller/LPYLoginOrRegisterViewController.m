//
//  LPYLoginOrRegisterViewController.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/26.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYLoginOrRegisterViewController.h"

@interface LPYLoginOrRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtTelephone;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

// 注册左边距离登录的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintRegisterLoginMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLoginLeftMargin;

@end

@implementation LPYLoginOrRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // txtTelephonePlaceHolder
    // 方法一：更改placeHolder颜色
//    NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    self.txtTelephone.attributedPlaceholder = placeHolder;
//    
//    NSMutableAttributedString *pwdPlaceHolder = [[NSMutableAttributedString alloc] initWithString:@"密码"];
//    [pwdPlaceHolder addAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, 2)];
//    self.txtPwd.attributedPlaceholder = pwdPlaceHolder;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 调整状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// 关闭
- (IBAction)btnCloseClick {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 登录or注册
- (IBAction)btnRegisterClick:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    self.constraintLoginLeftMargin.constant = sender.selected ? - self.view.width : 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
