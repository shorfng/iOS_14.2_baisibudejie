//
//  UIBarButtonItem+TDExtension.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/6.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "UIBarButtonItem+TDExtension.h"

@implementation UIBarButtonItem (TDExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    
    // 设置导航栏的按钮类型
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置导航栏按钮的背景图片（Normal 和 Highlighted）
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    // 设置导航栏按钮的尺寸（等于当前背景图片的尺寸）
    button.size = button.currentBackgroundImage.size;
    
    // 导航栏按钮的点击事件
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    // 返回导航栏按钮（自定义 View，将上面的自定义的 View 传递进来）
    return [[self alloc] initWithCustomView:button];
}
@end
