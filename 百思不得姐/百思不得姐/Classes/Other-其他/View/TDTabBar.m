//
//  TDTabBar.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/5.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDTabBar.h"

@interface TDTabBar()
@property (nonatomic, weak) UIButton *publishButton; // 发布按钮
@end

@implementation TDTabBar

#pragma mark - 初始化控件的 frame
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 创建 button
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置发布按钮的图片
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"]
                                 forState:UIControlStateNormal];
        
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"]
                                 forState:UIControlStateHighlighted];
        
        [self addSubview:publishButton];
        
        self.publishButton = publishButton;
    }
    return self;
}

#pragma mark - 重写子控件的布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的中心点
    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);

    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    // 遍历子控件
    for (UIView *button in self.subviews) {
        // 如果按钮的类型是继承自UIControl 并且 按钮不是publishButton，则重新计算 frame
        if ([button isKindOfClass:[UIControl class]] && button != self.publishButton ) {
            // 计算按钮的x值 = 按钮的宽 x 索引  （其中第三个按钮的索引为2，在publishButton右侧，需要+1计算）
            CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            // 增加索引
            index++;
        }
    }
}

@end
