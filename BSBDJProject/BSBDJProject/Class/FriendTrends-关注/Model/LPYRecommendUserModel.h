//
//  LPYRecommendUserModel.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPYRecommendUserModel : NSObject
/** header */
@property (nonatomic,strong) NSString *header;

/** screen_name */
@property (nonatomic,strong) NSString *screen_name;

/** fans Count */
@property (nonatomic,assign) NSInteger fans_count;

@end
