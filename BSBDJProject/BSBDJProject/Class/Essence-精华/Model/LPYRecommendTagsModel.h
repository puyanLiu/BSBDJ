//
//  LPYRecommendTagsModel.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/25.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPYRecommendTagsModel : NSObject
/** theme_id */
@property (nonatomic,strong) NSString *theme_id;

/** theme_name */
@property (nonatomic,strong) NSString *theme_name;

/** image */
@property (nonatomic,strong) NSString *image_list;

/** sum_number */
@property (nonatomic,assign) NSInteger sub_number;

@end
