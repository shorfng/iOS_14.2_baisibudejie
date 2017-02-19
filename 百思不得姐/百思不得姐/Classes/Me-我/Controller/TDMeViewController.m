//
//  TDMeViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/5.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDMeViewController.h"

@interface TDMeViewController ()
@end

@implementation TDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题（文字）
    self.navigationItem.title = @"我的";
    
    // 设置导航栏左边的按钮:积分
    UIBarButtonItem *integral = [UIBarButtonItem itemWithImage:@"nav_coin_icon"
                                                     highImage:@"nav_coin_icon_click"
                                                        target:self
                                                        action:@selector(integralClick)];
    
    self.navigationItem.leftBarButtonItem = integral;
    
    // 设置导航栏右边的按钮:设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon"
                                                        highImage:@"mine-setting-icon-click"
                                                           target:self
                                                           action:@selector(settingClick)];
    
    // 设置导航栏右边的按钮:黑夜模式
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon"
                                                     highImage:@"mine-moon-icon-click"
                                                        target:self
                                                        action:@selector(moonClick)];
    
    // 创建导航栏右边按钮（使用 Items,按顺序，从右往左放）
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    // 设置背景色
    self.view.backgroundColor = TDGlobalBg;
}

-(void)integralClick{
    TDLogFunc;
}

- (void)settingClick{
    TDLogFunc;
}

- (void)moonClick{
    TDLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
