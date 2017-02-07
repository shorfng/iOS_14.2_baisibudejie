//
//  TDRecommendCategory.h
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/11.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#pragma mark - “推荐关注”中左侧标签的列表模型(tableview)

#import <Foundation/Foundation.h>

@interface TDRecommendCategory : NSObject
@property (nonatomic, assign) NSInteger id;     // id
@property (nonatomic, copy) NSString *name;     // 名字
@property (nonatomic, assign) NSInteger count;  // 总数
@property (nonatomic, strong) NSMutableArray *users;  // 类别（左侧表格）所对应的用户数据（右侧表格）
@property (nonatomic, assign) NSInteger total;        // 用户总数
@property (nonatomic, assign) NSInteger currentPage;  // 当前页码
@end
