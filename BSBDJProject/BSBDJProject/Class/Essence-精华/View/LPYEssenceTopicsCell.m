//
//  LPYTableViewCell.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/28.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicsCell.h"
#import <UIImageView+WebCache.h>
#import "NSDate+LPYDate.h"

@interface LPYEssenceTopicsCell ()
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *photoIcon;

// 新浪用户图标
@property (weak, nonatomic) IBOutlet UIImageView *sina_vIcon;

// 昵称
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

// 发表时间
@property (weak, nonatomic) IBOutlet UILabel *lblCreateTime;

// 顶
@property (weak, nonatomic) IBOutlet UIButton *btnDing;

// 踩
@property (weak, nonatomic) IBOutlet UIButton *btnCai;

// 分享
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

// 评论
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@end

@implementation LPYEssenceTopicsCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setEssenceTopicModel:(LPYEssenceTopicModel *)essenceTopicModel
{
    _essenceTopicModel = essenceTopicModel;
    
    [self.photoIcon sd_setImageWithURL:[NSURL URLWithString:self.essenceTopicModel.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sina_vIcon.hidden = !self.essenceTopicModel.isSina_v;
    self.lblUserName.text = self.essenceTopicModel.screen_name;
    // 加载时间
    self.lblCreateTime.text = [NSDate timeShow:self.essenceTopicModel.passtime];
    
    [self setTopicWithButton:self.btnDing withCount:self.essenceTopicModel.love withTitle:@"顶"];
    [self setTopicWithButton:self.btnCai withCount:self.essenceTopicModel.hate withTitle:@"踩"];
    [self setTopicWithButton:self.btnShare withCount:self.essenceTopicModel.repost withTitle:@"分享"];
    [self setTopicWithButton:self.btnComment withCount:self.essenceTopicModel.comment withTitle:@"评论"];
}

- (void)setTopicWithButton:(UIButton *)btn withCount:(NSInteger)count withTitle:(NSString *)title
{
    NSString *content = title;
    if(count >= 10000)
    {
        content = [NSString stringWithFormat:@"%.1f万",1.0 *count / 10000];
    }
    else if(count > 0)
    {
        content = [NSString stringWithFormat:@"%zd", count];
    }
    [btn setTitle:content forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    // 调整Cell的尺寸
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= margin * 2;
    frame.size.height -= margin;
    return [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
