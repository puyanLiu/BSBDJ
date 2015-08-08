//
//  LPYMeCell.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/7.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYMeCell.h"

@implementation LPYMeCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(self.imageView.image)
    {
        // 调整
        self.imageView.y = 5;
        self.imageView.height = self.height - 2 *self.imageView.y;
        self.imageView.width = self.imageView.height;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
