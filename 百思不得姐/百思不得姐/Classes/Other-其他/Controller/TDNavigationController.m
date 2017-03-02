//
//  TDNavigationController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/6.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDNavigationController.h"

@interface TDNavigationController ()
@end

@implementation TDNavigationController

#pragma mark - 当第一次使用这个类的时候会调用一次
+ (void)initialize{
    
    // 当导航栏用在 TDNavigationController 中, appearance设置才会生效
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 关闭半透明特效（导航栏下方的 view 会自动跟进，因此 view 的y设置时应为0 ）
//    bar.translucent = NO;
    
    // 设置导航栏背景色RGB值
    bar.barTintColor = [UIColor colorWithRed:252/255.0 green:13/255.0 blue:68/255.0 alpha:1.0];
 
    // 设置导航栏标题颜色为白色
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 状态栏颜色设置为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 拦截所有push进来的控制器，进行自定义返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 如果push进来的不是第一个控制器
    // 设置所有的 navigationItem 的返回按钮都是以下内容
    if (self.childViewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置按钮的文字和图片
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        // 调整按钮：方法1
        // [button sizeToFit];
        
        // 调整按钮：方法2
        // (1) 设置按钮的尺寸
        button.size = CGSizeMake(70, 30);
        // (2) 让按钮的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // (3) 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        // 设置按钮内容的文字颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        // 监听按钮的点击事件（back）
        [button addTarget:self
                   action:@selector(back)
         forControlEvents:UIControlEventTouchUpInside];
        
        // 将按钮添加到 leftBarButtonItem
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // push 控制器以后，隐藏下方的tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // super的push, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
