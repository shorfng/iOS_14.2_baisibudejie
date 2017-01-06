//
//  TDTabBarController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/5.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDTabBarController.h"
#import "TDEssenceViewController.h"
#import "TDNewViewController.h"
#import "TDFriendTrendsViewController.h"
#import "TDMeViewController.h"
#import "TDTabBar.h"
#import "TDNavigationController.h"

@interface TDTabBarController ()
@end

@implementation TDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置未选中状态下 title 的属性
    NSMutableDictionary *attrs =[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];   // 文字大小
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor]; // 文字的前景色
    
    // 设置选中状态下 title 的属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 通过 appearance 统一设置所有 UItabBarItem 的文字的属性
    // 后面带有 UI_APPEARANCE_SELECTOR 的方法，都可以通过 appearance 对象统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    // 添加子控制器
    [self setupChildVc:[[TDEssenceViewController alloc]init]
                 title:@"精华"
                 image:@"tabBar_essence_icon"
         selectedImage:@"tabBar_essence_click_icon"];
    
    
    [self setupChildVc:[[TDNewViewController alloc]init]
                 title:@"最新"
                 image:@"tabBar_new_icon"
         selectedImage:@"tabBar_new_click_icon"];
    
    
    [self setupChildVc:[[TDFriendTrendsViewController alloc]init]
                 title:@"关注"
                 image:@"tabBar_friendTrends_icon"
         selectedImage:@"tabBar_friendTrends_click_icon"];
    
    
    [self setupChildVc:[[TDMeViewController alloc]init]
                 title:@"我"
                 image:@"tabBar_me_icon"
         selectedImage:@"tabBar_me_click_icon"];
    
    // 更换tabBar （因为 tabBar 的属性是 readonly，则通过kvc访问其成员变量）
    [self setValue:[[TDTabBar alloc] init] forKeyPath:@"tabBar"];
}

#pragma mark - 初始化子控制器
-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    // 设置 tabBarItem 文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 将上面创建的 vc 传进来，包装为导航控制器
    TDNavigationController *nav =[[TDNavigationController alloc]initWithRootViewController:vc];
    
    // 将导航控制器添加为 tabbarController 的子控制器
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
