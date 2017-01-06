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
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon"
                                                                 highImage:@"MainTagSubIconClick"
                                                                    target:self
                                                                    action:@selector(tagClick)];
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
