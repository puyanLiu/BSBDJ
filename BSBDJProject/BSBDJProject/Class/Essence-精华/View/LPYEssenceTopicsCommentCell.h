//
//  LPYEssenceTopicsCommentCell.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/4.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPYEssenceTopicCommentModel;

@interface LPYEssenceTopicsCommentCell : UITableViewCell

/** comment Model */
@property (nonatomic,strong) LPYEssenceTopicCommentModel *commentModel;

+ (instancetype)essenceTopicsCommentCell;
@end
