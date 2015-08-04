//
//  LPYEssenceTopicCommentHeaderView.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/4.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPYEssenceTopicCommentHeaderView : UITableViewHeaderFooterView

/** 标题 */
@property (nonatomic,copy) NSString *headerTitle;

+ (instancetype)essenceTopicCommentHeaderView:(UITableView *)tableView;
@end
