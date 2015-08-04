//
//  LPYEssenceTopicCommentHeaderView.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/4.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYEssenceTopicCommentHeaderView.h"

@interface LPYEssenceTopicCommentHeaderView()

/** UILabel */
@property (nonatomic,weak) UILabel *label;


@end

@implementation LPYEssenceTopicCommentHeaderView

+ (instancetype)essenceTopicCommentHeaderView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    LPYEssenceTopicCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if(header == nil)
    {
        header = [[LPYEssenceTopicCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = LPYColor(67, 67, 67);
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.width = 200;
        label.x = LPYEssenceTopicCellMargin;
        [self addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setHeaderTitle:(NSString *)headerTitle
{
    _headerTitle = [headerTitle copy];
    
    self.label.text = _headerTitle;
}

@end
