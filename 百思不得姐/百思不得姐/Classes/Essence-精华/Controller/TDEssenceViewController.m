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
    
    // 设置导航栏左边的按钮 - 排行榜
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_item_game_icon"
                                                                 highImage:@"nav_item_game_click_icon"
                                                                    target:self
                                                                    action:@selector(rankClick)];
    // 设置导航栏右边的按钮 - 随机穿越
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"RandomAcross"
                                                                  highImage:@"RandomAcrossClick"
                                                                     target:self
                                                                     action:@selector(crossClick)];
    
    // 设置背景色
    self.view.backgroundColor = TDGlobalBg;
}

- (void)rankClick{
    TDLogFunc;
}

-(void)crossClick{
    TDLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
