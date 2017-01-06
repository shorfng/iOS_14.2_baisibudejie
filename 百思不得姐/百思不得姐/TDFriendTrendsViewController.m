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
    
    // 设置导航栏左边的按钮类型
    UIButton *friendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置导航栏左边按钮的背景图片（Normal 和 Highlighted）
    [friendsButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [friendsButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    
    // 设置导航栏左边按钮的尺寸（等于当前背景图片的尺寸）
    friendsButton.size = friendsButton.currentBackgroundImage.size;
    
    // 导航栏左边按钮的点击事件
    [friendsButton addTarget:self
                      action:@selector(friendsClick)
            forControlEvents:UIControlEventTouchUpInside];
    
    // 创建导航栏左边按钮（自定义 View，将上面的自定义的 View 传递进来）
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendsButton];
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
