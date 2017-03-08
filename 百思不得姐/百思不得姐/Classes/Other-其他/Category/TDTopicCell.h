//
//  TDTopicCell.h
//  百思不得姐
//
//  Created by 蓝田 on 2017/3/7.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TDTopic;

@interface TDTopicCell : UITableViewCell
@property (nonatomic, strong) TDTopic *topic;  // 帖子数据
@end
