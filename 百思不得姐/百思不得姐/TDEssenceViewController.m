//
//  TDEssenceViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/6.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDEssenceViewController.h"

@interface TDEssenceViewController ()
@end

@implementation TDEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏的标题 View（是一个图片）
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮类型
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置导航栏左边按钮的背景图片（Normal 和 Highlighted）
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    
    // 设置导航栏左边按钮的尺寸（等于当前背景图片的尺寸）
    tagButton.size = tagButton.currentBackgroundImage.size;
    
    // 导航栏左边按钮的点击事件
    [tagButton addTarget:self
                  action:@selector(tagClick)
        forControlEvents:UIControlEventTouchUpInside];
    
    // 创建导航栏左边按钮（自定义 View，将上面的自定义的 View 传递进来）
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tagButton];
}

- (void)tagClick{
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
