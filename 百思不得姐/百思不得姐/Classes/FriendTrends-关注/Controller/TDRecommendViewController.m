//
//  TDRecommendViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/9.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>               // 第三方字典转模型
#import "TDRecommendCategoryCell.h"   // 左侧cell
#import "TDRecommendCategory.h"       // 左侧模型
#import "TDRecommendUserCell.h"       // 右侧cell
#import "TDRecommendUser.h"           // 右侧模型

@interface TDRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *categories;                   // 左边的类别数据
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView; // 左边的类别表格

@property (nonatomic, strong) NSArray *users;                        // 右边的用户数据
@property (weak, nonatomic) IBOutlet UITableView *userTableView;     // 右边的用户列表
@end

@implementation TDRecommendViewController

// 标识
static NSString * const TDCategoryId = @"category";
static NSString * const TDUserId = @"user";

#pragma mark - 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setupTableView];
    
    // 显示指示器,设置指示器样式
    [SVProgressHUD show ];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    // 左测 - 开始发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"
                            parameters:params
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   
                                   // 隐藏指示器
                                   [SVProgressHUD dismiss];
                                   
                                   // 将服务器返回的字典list（Json数据）转换成模型数组TDRecommendCategory
                                   self.categories = [TDRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                                   
                                   NSLog(@"%@",responseObject);
                                   
                                   // 刷新表格
                                   [self.categoryTableView reloadData];
                                   
                                   // 默认选中首行
                                   [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                                   
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   
                                   // 显示失败信息
                                   [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络！"];
                               }];
}

#pragma mark - 控件的初始化
- (void)setupTableView{
    
    // 设置代理和数据源 （左侧的表格视图使用的是代码设置，右侧的表格视图使用的是连线方式）
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    
    // 注册左侧 xib
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:TDCategoryId];
    
    // 注册右侧 xib
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:TDUserId];
    
    // 设置contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 设置标题和背景色
    self.title = @"推荐关注";
    self.view.backgroundColor = TDGlobalBg;
}

#pragma mark - 表格返回多少行（UITableViewDataSource）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // 判断是左侧表格还是右侧表格
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else{
        return self.users.count;
    }
}

#pragma mark -  返回表格 cell 的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 判断是左侧表格还是右侧表格
    if (tableView == self.categoryTableView) {
        TDRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TDCategoryId];
        
        // 改变 cell 的字体大小和对齐方式
        cell.textLabel.font  = [UIFont fontWithName: @"Arial" size: 13.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.category= self.categories[indexPath.row];
        
        return cell;
    }else{
        TDRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:TDUserId];
        cell.user = self.users[indexPath.row];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TDRecommendCategory *category = self.categories[indexPath.row];
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    
    // 开始发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"
                            parameters:params
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   
                                   self.users = [ TDRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                                   
                                   // 刷新右边的表格
                                   [self.userTableView reloadData];
                                   
                                   TDLog(@"%@",responseObject);
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   
                                   TDLog(@"%@",error);
                               }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
