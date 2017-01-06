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
    
#pragma mark - 导航栏右边的按钮:设置
    // 设置导航栏右边的按钮类型
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置导航栏右边按钮的背景图片（Normal 和 Highlighted）
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    
    // 设置导航栏右边按钮的尺寸（等于当前背景图片的尺寸）
    settingButton.size = settingButton.currentBackgroundImage.size;
    
    // 导航栏右边按钮的点击事件
    [settingButton addTarget:self
                      action:@selector(settingClick)
            forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 导航栏右边的按钮:黑夜模式
    // 设置导航栏右边的按钮类型
    UIButton *nightModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置导航栏右边按钮的背景图片（Normal 和 Highlighted）
    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    
    // 设置导航栏右边按钮的尺寸（等于当前背景图片的尺寸）
    nightModeButton.size = nightModeButton.currentBackgroundImage.size;
    
    // 导航栏右边按钮的点击事件
    [nightModeButton addTarget:self
                        action:@selector(nightModeClick)
              forControlEvents:UIControlEventTouchUpInside];
    
    // 创建导航栏右边按钮（使用 Items）
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithCustomView:settingButton],
                                                [[UIBarButtonItem alloc] initWithCustomView:nightModeButton]
                                                ];
}

- (void)settingClick{
    TDLogFunc;
}

- (void)nightModeClick{
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
