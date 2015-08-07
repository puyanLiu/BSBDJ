//
//  LPYEssenceTopicsCommentCell.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/4.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicsCommentCell.h"
#import <UIImageView+WebCache.h>
#import "LPYEssenceTopicCommentModel.h"
#import "LPYHelpClass.h"

@interface LPYEssenceTopicsCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

@property (weak, nonatomic) IBOutlet UILabel *lblLoveCount;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIButton *btnVoice;

@end

@implementation LPYEssenceTopicsCommentCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageView;
}

+ (instancetype)essenceTopicsCommentCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setCommentModel:(LPYEssenceTopicCommentModel *)commentModel
{
    _commentModel = commentModel;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:self.commentModel.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    if(self.commentModel.user.sex == LPYEssenceMale)
    {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }
    else if(self.commentModel.user.sex == LPYEssenceFaMale)
    {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    self.lblUserName.text = self.commentModel.user.username;
    self.lblContent.text = self.commentModel.content;
    
    // 处理点赞内容
    [LPYHelpClass setTopicWithLabel:self.lblLoveCount withCount:self.commentModel.like_count];
    // 语音标识
    if(self.commentModel.voiceuri && ![self.commentModel.voiceuri isEqualToString:@""])
    {
        self.lblContent.hidden = YES;
        self.btnVoice.hidden = NO;
        
        [self.btnVoice setTitle:[NSString stringWithFormat:@"%zd ''",self.commentModel.voicetime] forState:UIControlStateNormal];
    }
    else
    {
        self.btnVoice.hidden = YES;
        self.lblContent.hidden = NO;
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = LPYEssenceTopicCellMargin;
    frame.size.width -= 2 * LPYEssenceTopicCellMargin;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 允许成为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
