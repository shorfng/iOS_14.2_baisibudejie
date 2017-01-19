//
//  TDRecommendCategory.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/11.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDRecommendCategory.h"

@implementation TDRecommendCategory
#pragma mark - 懒加载
// 类别（左侧表格）所对应的用户数据（右侧表格）
- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
