//
//  TDNewViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/5.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDNewViewController.h"

@interface TDNewViewController ()
@end

@implementation TDNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏的标题 View（是一个图片）
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮 - 审核
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"review_post_nav_icon"
                                                                 highImage:@"review_post_nav_icon_click"
                                                                    target:self
                                                                    action:@selector(reviewClick)];
    // 设置导航栏右边的按钮 - 搜索
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_search_icon"
                                                                  highImage:@"nav_search_icon_click"
                                                                     target:self
                                                                     action:@selector(searchClick)];
    // 设置背景色
    self.view.backgroundColor = TDGlobalBg;
}

- (void)reviewClick{
    TDLogFunc;
}

- (void)searchClick{
    TDLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
