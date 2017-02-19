//
//  TDFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/5.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDFriendTrendsViewController.h"
#import "TDRecommendViewController.h"

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
    self.navigationItem.title = @"关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"cellFollowIcon"
                                                                 highImage:@"cellFollowDisableIcon"
                                                                    target:self
                                                                    action:@selector(friendsClick)];
    // 设置导航栏右边的按钮 - 搜索
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_search_icon"
                                                                  highImage:@"nav_search_icon_click"
                                                                     target:self
                                                                     action:@selector(searchClick)];
    
    // 设置背景色
    self.view.backgroundColor = TDGlobalBg;
}

- (void)friendsClick{
    TDRecommendViewController *vc = [[TDRecommendViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)searchClick{
    TDLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
