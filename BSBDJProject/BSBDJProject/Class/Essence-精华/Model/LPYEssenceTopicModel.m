//
//  LPYEssenceTopicModel.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/28.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicModel.h"
#import "NSDate+LPYDate.h"
#import <MJExtension.h>

@implementation LPYEssenceTopicModel
{
    //cellHeight readonly
    CGFloat _cellHeight;
    
    CGRect _pictureFrame;
    
    BOOL _largePicture;
    
    CGFloat _pictureRealHeight;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"pic_small" : @"image0",
             @"pic_middle" : @"image1",
             @"pic_large" : @"image2",
             @"ID" : @"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
//    return @{
//             @"top_cmt" : @"LPYEssenceTopicCommentModel"
//             };
    return @{
             @"top_cmt" : [LPYEssenceTopicCommentModel class]
             };
}


/**
 当前时间 一分钟内 -----刚刚
 当前时间 一小时内 -----显示多少分钟前
 当前时间 24小时内 -----显示多少小时前
 昨天 -----显示昨天 时：分：秒
 今年 -----显示月：日 时：分：秒
 其他 -----显示年：月：日 时：分：秒
 */
- (NSString *)passtime
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [df dateFromString:_passtime];
    
    NSDateComponents *delta = [NSDate deltaDate:date];
    if([NSDate isToday:date] && delta.hour == 0 && delta.minute == 0)
    {
        return @"刚刚";
    }
    else if([NSDate isToday:date] && delta.hour == 0)
    {
        return [NSString stringWithFormat:@"%zd分钟前",delta.minute];
    }
    else if([NSDate isToday:date])
    {
        df.dateFormat = @"HH:mm:ss";
        return [df stringFromDate:date];
    }
    else if([NSDate isYesterday:date])
    {
        df.dateFormat = @"HH:mm:ss";
        return [NSString stringWithFormat:@"昨天 %@", [df stringFromDate:date]];
    }
    else if([NSDate isTodayYear:date])
    {
        df.dateFormat = @"MM-dd HH:mm:ss";
        return [df stringFromDate:date];
    }
    else
    {
        return _passtime;
    }
}

- (CGFloat)cellHeight
{
    CGFloat cellW = LPYScreenWidth - 4 * LPYEssenceTopicCellMargin;
    // 计算文本高度
    CGSize textSize = CGSizeMake(cellW, MAXFLOAT);
    // NSStringDrawingUsesLineFragmentOrigin
    CGFloat textH = [_text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    // 计算段子高度
    _cellHeight = LPYEssenceTopicCellTopH + textH + LPYEssenceTopicCellMargin;
    
    if(self.type == LPYEssenceTopicTypePicture) // 图片
    {
        CGFloat picH = cellW * self.height / self.width;
        if(picH > 1000)
        {
            _pictureRealHeight = picH;
            picH = 300;
            _largePicture = YES;
        }
        else
        {
            _largePicture = NO;
        }
        _pictureFrame = CGRectMake(LPYEssenceTopicCellMargin, _cellHeight, cellW, picH);
        _cellHeight += picH + LPYEssenceTopicCellMargin;
    }
    else if(self.type == LPYEssenceTopicTypeVoice)
    {
        CGFloat picH = cellW * self.height / self.width;
        _voiceFrame = CGRectMake(LPYEssenceTopicCellMargin, _cellHeight, cellW, picH);
        _cellHeight += picH + LPYEssenceTopicCellMargin * 2;
    }
    else if(self.type == LPYEssenceTopicTypeMovie)
    {
        CGFloat picH = cellW * self.height / self.width;
        _moiveFrame = CGRectMake(LPYEssenceTopicCellMargin, _cellHeight, cellW, picH);
        _cellHeight += picH + LPYEssenceTopicCellMargin;
    }
    
    // 最新评论
    LPYEssenceTopicCommentModel *comment = [self.top_cmt firstObject];
    if(comment)
    {
        // 计算文本高度
        CGFloat commentH = [[NSString stringWithFormat:@"%@ : %@",comment.user.username ,comment.content] boundingRectWithSize:CGSizeMake(LPYScreenWidth - 4 * LPYEssenceTopicCellMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        _cellHeight += 20 + commentH + LPYEssenceTopicCellMargin;
    }
    
    _cellHeight += LPYEssenceTopicCellBottomH + LPYEssenceTopicCellMargin;
    
    return  _cellHeight;
}
@end
