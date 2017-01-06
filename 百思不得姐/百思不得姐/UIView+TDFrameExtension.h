//
//  UIView+TDFrameExtension.h
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/6.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#pragma mark - 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量

#import <UIKit/UIKit.h>

@interface UIView (TDFrameExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@end
