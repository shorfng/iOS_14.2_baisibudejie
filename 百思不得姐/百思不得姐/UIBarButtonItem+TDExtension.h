//
//  UIBarButtonItem+TDExtension.h
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/6.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TDExtension)

+ (instancetype)itemWithImage:(NSString *)image
                    highImage:(NSString *)highImage
                       target:(id)target
                       action:(SEL)action;
@end
