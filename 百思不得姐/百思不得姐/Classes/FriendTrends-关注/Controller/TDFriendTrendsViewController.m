//
//  TDFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/5.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDFriendTrendsViewController.h"

@interface TDFriendTrendsViewController ()

@end

@implementation TDFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // title属性相当于设置了navigationItem和tabBarItem两个属性的值
    //    self.title = @"我的关注";
    
    //    self.navigationItem.title = @"我的关注";
    //    self.tabBarItem.title = @"我的关注";
    
    // 设置导航栏标题（文字）
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon"
                                                                 highImage:@"friendsRecommentIcon-click"
                                                                    target:self
                                                                    action:@selector(friendsClick)];
}

- (void)friendsClick{
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
