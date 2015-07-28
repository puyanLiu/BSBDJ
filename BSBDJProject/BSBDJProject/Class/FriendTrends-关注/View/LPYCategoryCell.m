//
//  LPYCategoryCell.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYCategoryCell.h"

@interface LPYCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *seperator;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation LPYCategoryCell

- (void)awakeFromNib {
    // Initialization code
    // cell设置
    self.backgroundColor = LPYColor(244, 244, 244);
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    // 取消选中
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 隐藏红色线框
    self.redView.hidden = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 1;
    self.textLabel.height -= 2 * self.textLabel.y;
}

- (void)setCategoryModel:(LPYCategoryModel *)categoryModel
{
    self.textLabel.text = categoryModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.redView.hidden = !selected;
    self.textLabel.textColor = selected ? self.redView.backgroundColor : LPYColor(86, 86, 86);
    
}

@end
