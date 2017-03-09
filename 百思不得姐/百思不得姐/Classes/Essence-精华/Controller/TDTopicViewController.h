//
//  TDTopicViewController.h
//  百思不得姐
//
//  Created by 蓝田 on 2017/3/8.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TDTopicTypeRecom = 1,     // 推荐
    TDTopicTypeVideo = 41,    // 视频
    TDTopicTypePicture = 10,  // 图片
    TDTopicTypeWord = 29,     // 段子
    TDTopicTypeVoice = 31     // 声音
} TDTopicType;

@interface TDTopicViewController : UITableViewController
@property (nonatomic, assign) TDTopicType type;  // 帖子类型
@end
