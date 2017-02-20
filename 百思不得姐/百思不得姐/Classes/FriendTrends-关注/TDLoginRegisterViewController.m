//
//  TDLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/2/19.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDLoginRegisterViewController.h"
#import "TDPhoneLoginRegisterController.h"

@interface TDLoginRegisterViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *otherLoginView;
@end

@implementation TDLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 状态栏颜色设置为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 取消按钮
- (IBAction)cancelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 微信登录按钮
- (IBAction)weixinLoginButton:(UIButton *)sender {
}

#pragma mark - QQ登录按钮
- (IBAction)qqLoginButton:(UIButton *)sender {
}

#pragma mark - 其他登录方式按钮
- (IBAction)otherLoginButton:(UIButton *)sender {
    
    // 创建UIAlertController 设置标题，信息，样式
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 创建UIAlertAction对象，设置标题并添加到UIAlertController上
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"手机号登录"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                            // 跳转到手机号登录注册界面
                                                            TDPhoneLoginRegisterController *vc =[[TDPhoneLoginRegisterController alloc]init];
                                                            
                                                            [self presentViewController:vc animated:YES completion:nil];
                                                        }];
    
    UIAlertAction *xlAction = [UIAlertAction actionWithTitle:@"新浪微博"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                         
                                                     }];
    
    UIAlertAction *txAction = [UIAlertAction actionWithTitle:@"腾讯微博"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                         
                                                     }];
    
    // 改变所有 actionWithTitle 的字体颜色
    alert.view.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    
    // 将 message 添加到 ActionSheet 上
    [alert addAction:phoneAction];
    [alert addAction:xlAction];
    [alert addAction:txAction];
    [alert addAction:cancelAction];
    
    // 显示 ActionSheet
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
