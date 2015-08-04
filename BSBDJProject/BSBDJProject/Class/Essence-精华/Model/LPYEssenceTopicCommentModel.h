//
//  LPYEssenceTopicTopCommentModel.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/2.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPYEssenceTopicUserModel.h"

@interface LPYEssenceTopicCommentModel : NSObject
/** content */
@property (nonatomic,copy) NSString *content;
/** ctime */
@property (nonatomic,copy) NSString *ctime;
/** like count */
@property (nonatomic,assign) NSInteger like_count;
/** voice url */
@property (nonatomic,copy) NSString *voiceuri;
/** voicetime */
@property (nonatomic,assign) NSInteger voicetime;
/** user */
@property (nonatomic,strong) LPYEssenceTopicUserModel *user;

@end
