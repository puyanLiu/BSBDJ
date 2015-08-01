//
//  LPYTableViewCell.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/28.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicsCell.h"
#import <UIImageView+WebCache.h>
#import "LPYEssenceTopicsPicture.h"
#import "LPYEssenceTopicsVoice.h"
#import "LPYEssenceTopicsMoive.h"

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

// 文本内容
@property (weak, nonatomic) IBOutlet UILabel *lblText;

/** pictureView */
@property (nonatomic,weak) LPYEssenceTopicsPicture *essenceTopicsPicture;

/** voiceView */
@property (nonatomic,weak) LPYEssenceTopicsVoice *essenceTopicsVoice;;

/** movieView */
@property (nonatomic,weak) LPYEssenceTopicsMoive *essenceTopicsMoive;

@end

@implementation LPYEssenceTopicsCell

- (LPYEssenceTopicsPicture *)essenceTopicsPicture
{
    if(_essenceTopicsPicture == nil)
    {
        LPYEssenceTopicsPicture *picture = [LPYEssenceTopicsPicture essenceTopicsPicture];
        [self addSubview:picture];
        _essenceTopicsPicture = picture;
    }
    
    return _essenceTopicsPicture;
}

- (LPYEssenceTopicsVoice *)essenceTopicsVoice
{
    if(_essenceTopicsVoice == nil)
    {
        LPYEssenceTopicsVoice *voice = [LPYEssenceTopicsVoice essenceTopicsVoice];
        [self addSubview:voice];
        _essenceTopicsVoice = voice;
    }
    
    return _essenceTopicsVoice;
}

- (LPYEssenceTopicsMoive *)essenceTopicsMoive
{
    if(_essenceTopicsMoive == nil)
    {
        LPYEssenceTopicsMoive *movie = [LPYEssenceTopicsMoive essenceTopicsMoive];
        [self addSubview:movie];
        _essenceTopicsMoive = movie;
    }
    return _essenceTopicsMoive;
}

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
    self.lblCreateTime.text = self.essenceTopicModel.passtime;
    
    [self setTopicWithButton:self.btnDing withCount:self.essenceTopicModel.love withTitle:@"顶"];
    [self setTopicWithButton:self.btnCai withCount:self.essenceTopicModel.hate withTitle:@"踩"];
    [self setTopicWithButton:self.btnShare withCount:self.essenceTopicModel.repost withTitle:@"分享"];
    [self setTopicWithButton:self.btnComment withCount:self.essenceTopicModel.comment withTitle:@"评论"];
    
    // 文本内容
    self.lblText.text = self.essenceTopicModel.text;
    
    if(self.essenceTopicModel.type == LPYEssenceTopicTypePicture)
    {
        self.essenceTopicsPicture.hidden = NO;
        self.essenceTopicsVoice.hidden = YES;
        self.essenceTopicsMoive.hidden = YES;
        // 图片
        self.essenceTopicsPicture.essenceTopicModel = self.essenceTopicModel;
        // 图片frame
        self.essenceTopicsPicture.frame = self.essenceTopicModel.pictureFrame;
    }
    else if(self.essenceTopicModel.type == LPYEssenceTopicTypeMovie)
    {
        // 视频
        self.essenceTopicsPicture.hidden = YES;
        self.essenceTopicsVoice.hidden = YES;
        self.essenceTopicsMoive.hidden = NO;
        self.essenceTopicsMoive.essenceTopicModel = self.essenceTopicModel;
        self.essenceTopicsMoive.frame = self.essenceTopicModel.moiveFrame;
    }
    else if(self.essenceTopicModel.type == LPYEssenceTopicTypeVoice)
    {
        // 声音
        self.essenceTopicsPicture.hidden = YES;
        self.essenceTopicsVoice.hidden = NO;
        self.essenceTopicsMoive.hidden = YES;
        self.essenceTopicsVoice.essenceTopicModel = self.essenceTopicModel;
        self.essenceTopicsVoice.frame = self.essenceTopicModel.voiceFrame;
    }
    else if(self.essenceTopicModel.type == LPYEssenceTopicTypeSegment)
    {
        // 段子
        self.essenceTopicsPicture.hidden = YES;
        self.essenceTopicsVoice.hidden = YES;
        self.essenceTopicsMoive.hidden = YES;
    }
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
    frame.origin.x = LPYEssenceTopicCellMargin;
    frame.origin.y += LPYEssenceTopicCellMargin;
    frame.size.width -= LPYEssenceTopicCellMargin * 2;
    frame.size.height -= LPYEssenceTopicCellMargin;
    return [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
