//
//  TDPhoneLoginRegisterController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/2/19.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDPhoneLoginRegisterController.h"

@interface TDPhoneLoginRegisterController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin; // 登录框距离控制器view左边的间距
@end

@implementation TDPhoneLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 状态栏颜色设置为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 取消按钮，返回上一个控制器
- (IBAction)cancelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 点击显示登录界面 or 注册界面
- (IBAction)showLoginOrRegister:(UIButton *)button {
    // 退出键盘
    [self.view endEditing:YES];
    
    // 如果距离为0
    if (self.loginViewLeftMargin.constant == 0) {
        // 让登录框向左移，显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        [button setTitle:@"已有账号?" forState:UIControlStateNormal];
    } else { // 否则，让距离为0，显示登录界面
        self.loginViewLeftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
