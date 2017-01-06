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
    
    // 创建导航栏右边按钮（使用 Items）
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    // 设置背景色
    self.view.backgroundColor = TDGlobalBg;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
