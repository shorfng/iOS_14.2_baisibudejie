//
//  TDRecommendUser.h
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/16.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDRecommendUser : NSObject
@property (nonatomic, copy) NSString *header;        // 头像
@property (nonatomic, assign) NSInteger fans_count;  // 粉丝数(有多少人关注这个用户)
@property (nonatomic, copy) NSString *screen_name;   // 昵称
@end
