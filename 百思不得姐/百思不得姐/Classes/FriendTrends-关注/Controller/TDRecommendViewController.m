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
#import <MJRefresh.h>                 // 刷新

// 宏定义 - 根据左侧表格选中的行获得行号（获取左侧表格被选中的行号）
#define TDSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface TDRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *categories;                   // 左边的类别数据
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView; // 左边的类别表格
@property (nonatomic, strong) NSArray *users;                        // 右边的用户数据
@property (weak, nonatomic) IBOutlet UITableView *userTableView;     // 右边的用户列表
@property (nonatomic, strong) NSMutableDictionary *params;           // 请求参数
@property (nonatomic, strong) AFHTTPSessionManager *manager;         // AFN请求管理者
@end

@implementation TDRecommendViewController

// 标识
static NSString * const TDCategoryId = @"category";
static NSString * const TDUserId = @"user";

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
}

#pragma mark - 加载左侧的类别数据
- (void)loadCategories{
    // 显示指示器,设置指示器样式
    [SVProgressHUD show ];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    // 左测 - 开始发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"
           parameters:params
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  // 隐藏指示器
                  [SVProgressHUD dismiss];
                  
                  // 字典数组 -> 模型数组
                  // 将服务器返回的字典list（Json数据）转换成模型数组TDRecommendCategory
                  self.categories = [TDRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                  
                  NSLog(@"%@",responseObject);
                  
                  // 刷新表格
                  [self.categoryTableView reloadData];
                  
                  // 默认选中首行
                  [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                  
                  // 让用户表格进入下拉刷新状态
                  [self.userTableView.mj_header beginRefreshing];
                  
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

#pragma mark - 添加刷新控件
- (void)setupRefresh{
    // 进入下拉刷新状态
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadNewUsers)];
    // 进上拉刷新状态
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                        refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - 下拉刷新加载用户数据（右侧表格）
- (void)loadNewUsers{
    
    TDRecommendCategory *recommendCategory = TDSelectedCategory;
    
    // 设置当前页码为1
    recommendCategory.currentPage = 1;
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(recommendCategory.id);
    params[@"page"] = @(recommendCategory.currentPage);
    self.params = params;
    
    // 开始发送请求给服务器, 加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"
           parameters:params
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  // 字典数组 -> 模型数组
                  // 将服务器返回的字典list（Json数据）转换成模型数组TDRecommendCategory
                  NSArray *users = [ TDRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                  
                  // 清除所有旧数据
                  [recommendCategory.users removeAllObjects];
                  
                  // 添加到当前类别对应的用户数组中
                  [recommendCategory.users addObjectsFromArray:users];
                  
                  // 保存右侧表格的用户总数
                  recommendCategory.total = [responseObject[@"total"] integerValue];
                  
                  // 如果请求的参数不是最后一次请求，则直接 return，不往下继续执行，此次请求作废
                  if (self.params != params) return;
                  
                  // 刷新右边的表格
                  [self.userTableView reloadData];
                  
                  // 结束刷新
                  [self.userTableView.mj_header endRefreshing];
                  
                  // 让底部控件结束刷新
                  [self checkFooterState];
                  
                  // TDLog(@"%@",responseObject);
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  if (self.params != params) return;
                  
                  [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
                  
                  // 结束刷新
                  [self.userTableView.mj_header endRefreshing];
                  
                  // TDLog(@"%@",error);
              }];
}

#pragma mark - 上拉刷新加载更多用户数据（右侧表格）
-(void)loadMoreUsers{
    
    TDRecommendCategory *recommendCategory = TDSelectedCategory;
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(recommendCategory.id);
    params[@"page"] = @(++recommendCategory.currentPage);
    self.params = params;
    
    // 开始发送请求给服务器, 加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"
           parameters:params
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  // 字典数组 -> 模型数组
                  // 将服务器返回的字典list（Json数据）转换成模型数组TDRecommendCategory
                  NSArray *users = [ TDRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                  
                  // 添加到当前类别对应的用户数组中
                  [recommendCategory.users addObjectsFromArray:users];
                  
                  // 如果请求的参数不是最后一次请求，则直接 return，不往下继续执行，此次请求作废
                  if (self.params != params) return;
                  
                  // 刷新右边的表格
                  [self.userTableView reloadData];
                  
                  // 让底部控件结束刷新
                  [self checkFooterState];
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if (self.params != params) return;
                  
                  [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
                  
                  // 让底部控件结束刷新
                  [self.userTableView.mj_footer endRefreshing];
              }];
}

#pragma mark - 时刻监测footer的状态
- (void)checkFooterState{
    
    TDRecommendCategory *rc = TDSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏(当前选中行的右侧表格没有数据就隐藏)
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // 判断右侧表格加载的用户总数是否等于服务器返回的用户总数
    if (rc.users.count == rc.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData]; // 提示全部数据已经加载完毕
    } else { // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];  // 让底部控件结束刷新
    }
}

#pragma mark - 表格返回多少行（UITableViewDataSource）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // 判断是左侧表格还是右侧表格
    if (tableView == self.categoryTableView) {  // 左侧表格
        return self.categories.count;
    }else{  // 右侧表格
        // 监测footer的状态
        [self checkFooterState];
        
        // 返回当前选中行的右侧表格数据
        return [TDSelectedCategory users].count;
    }
}

#pragma mark -  返回表格 cell 的内容（UITableViewDataSource）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 判断是左侧表格还是右侧表格
    if (tableView == self.categoryTableView) {   // 左侧表格
        TDRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TDCategoryId];
        
        // 改变 cell 的字体大小和对齐方式
        cell.textLabel.font  = [UIFont fontWithName: @"Arial" size: 13.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{    // 右侧表格
        TDRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:TDUserId];
        cell.user = [TDSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - 点击左侧表格显示右侧表格的内容（UITableViewDelegate）
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 结束所有右侧表格的上拉和下拉刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    TDRecommendCategory *category = self.categories[indexPath.row];
    
    // 判断右侧的表格中是否有数据，如果有就只刷新，如果没有就从服务器获取
    if (category.users.count) {
        [self.userTableView reloadData];
    }else{
        // 当网速较慢时，刷新表格,马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
