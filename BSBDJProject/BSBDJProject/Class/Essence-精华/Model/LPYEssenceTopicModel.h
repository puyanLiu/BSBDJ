//
//  LPYEssenceTopicModel.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/28.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPYEssenceTopicModel : NSObject
/** 帖子类型 */
@property (nonatomic,assign) NSInteger type;

/** 发帖人的昵称 */
@property (nonatomic,copy) NSString *screen_name;

/** 头像url地址 */
@property (nonatomic,strong) NSString *profile_image;

/** 发帖时间 */
@property (nonatomic,strong) NSString *passtime;

/** 踩的数量 */
@property (nonatomic,assign) NSInteger hate;

/** 顶的数量 */
@property (nonatomic,assign) NSInteger love;

/** 帖子的内容 */
@property (nonatomic,copy) NSString *text;

/** 帖子的收藏量 */
@property (nonatomic,assign) NSInteger bookmark;

/** 帖子的评论数 */
@property (nonatomic,assign) NSInteger comment;

/** 转发的数量 */
@property (nonatomic,assign) NSInteger repost;

/** 是否是新浪用户 */
@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;

/** maxtime */
@property (nonatomic,strong) NSString *maxtime;
@end
