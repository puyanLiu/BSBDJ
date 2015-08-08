//
//  LPYShowTagView.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/6.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYShowTagView.h"

@interface LPYShowTagView()

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation LPYShowTagView
- (void)awakeFromNib
{
    // 添加按钮
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
//    addBtn.size = [UIImage imageNamed:@"tag_add_icon"].size;
//    addBtn.size = [addBtn imageForState:UIControlStateNormal].size;
    addBtn.size = addBtn.currentImage.size;
    [addBtn addTarget:self action:@selector(btnAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addBtn];
}

// 添加标签
- (void)btnAddClick
{
    
}
@end
