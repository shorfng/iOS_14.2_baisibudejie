//
//  TDTopic.h
//  百思不得姐
//
//  Created by 蓝田 on 2017/3/2.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDTopic : NSObject
@property (nonatomic, copy) NSString *name;           // 用户名称
@property (nonatomic, copy) NSString *profile_image;  // 用户头像
@property (nonatomic, copy) NSString *create_time;    // 发帖时间
@property (nonatomic, copy) NSString *text;           // 发帖内容
@property (nonatomic, assign) NSInteger ding;         // 顶的数量
@property (nonatomic, assign) NSInteger cai;          // 踩的数量
@property (nonatomic, assign) NSInteger repost;       // 转发数
@property (nonatomic, assign) NSInteger comment;      // 评论数
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;  // 是否为新浪加V用户
@end
