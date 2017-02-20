//
//  TDTextField.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/2/20.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDTextField.h"
#import <objc/runtime.h>

static NSString * const TDPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation TDTextField

- (void)awakeFromNib{
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
    
    [super awakeFromNib];
}

#pragma mark - 当前文本框聚焦时就会调用
- (BOOL)becomeFirstResponder{
    // 修改占位文字颜色：和输入文字的时候颜色一致
    [self setValue:self.textColor forKeyPath:TDPlacerholderColorKeyPath];
    
    return [super becomeFirstResponder];
}

#pragma mark - 当前文本框失去焦点时就会调用
- (BOOL)resignFirstResponder{
    // 修改占位文字颜色：为如下颜色
    [self setValue:[UIColor colorWithRed:181/255.0 green:177/255.0 blue:179/255.0 alpha:1.0]
        forKeyPath:TDPlacerholderColorKeyPath];
    
    return [super resignFirstResponder];
}

#pragma mark - 补充
// 修改占位文字颜色，方法1：
//    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor grayColor];

// 修改占位文字颜色，方法2：
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

@end
