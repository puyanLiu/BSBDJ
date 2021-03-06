//
//  LPYConst.h
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/29.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

// 帖子类型
typedef enum
{
    LPYEssenceTopicTypeAll = 1,
    LPYEssenceTopicTypePicture = 10,
    LPYEssenceTopicTypeSegment = 29,
    LPYEssenceTopicTypeVoice = 31,
    LPYEssenceTopicTypeMovie = 41
} LPYEssenceTopicType;

// 导航控制器+状态栏高度
UIKIT_EXTERN CGFloat const LPYEssenceNavigationAndStateH;
// essence title高度
UIKIT_EXTERN CGFloat const LPYEssenceTitleH;
// 底部TabBarController 控制器高度
UIKIT_EXTERN CGFloat const LPYEssenceTabBarH;
// topic-cell 边距
UIKIT_EXTERN CGFloat const LPYEssenceTopicCellMargin;
// topic-cell topH
UIKIT_EXTERN CGFloat const LPYEssenceTopicCellTopH;
// topic-cell bottomH
UIKIT_EXTERN CGFloat const LPYEssenceTopicCellBottomH;

// comment 男
UIKIT_EXTERN NSString * const LPYEssenceMale;

// comment 女
UIKIT_EXTERN NSString * const LPYEssenceFaMale;

// status bar 高度
UIKIT_EXTERN CGFloat const LPYStatusBarH;

// 点击TabBar发送通知
UIKIT_EXTERN NSString * const LPYTabBarDidClickNotification;