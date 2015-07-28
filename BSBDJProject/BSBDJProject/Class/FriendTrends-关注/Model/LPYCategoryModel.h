//
//  LPYCategoryModel.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPYCategoryModel : NSObject
/** id */
@property (nonatomic,strong) NSString *ID;

/** name */
@property (nonatomic,strong) NSString *name;

/** count */
@property (nonatomic,assign) NSInteger count;

/** 保存用户推荐相关数据 */
@property (nonatomic,strong) NSMutableArray *recommendUsers;

/** currentPage */
@property (nonatomic,assign) NSInteger currentPage;

/** total */
@property (nonatomic,assign) NSInteger total;

/** NSIndexPath */
@property (nonatomic,strong) NSIndexPath *currentIndexPath;

@end
