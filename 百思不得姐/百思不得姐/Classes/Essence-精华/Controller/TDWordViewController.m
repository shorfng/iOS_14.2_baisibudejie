//
//  TDWordViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/3/2.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDWordViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "TDTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "TDTopicCell.h"  // cell的xib

@interface TDWordViewController ()
@property (nonatomic, strong) NSMutableArray *topics;  // 帖子数据
@property (nonatomic, assign) NSInteger page;          // 当前页码
@property (nonatomic, copy) NSString *maxtime;         // 当加载下一页数据时需要这个参数
@property (nonatomic, strong) NSDictionary *params;    // 上一次的请求参数
@end

@implementation TDWordViewController

- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
}

static NSString * const TDTopicCellId = @"topic";
- (void)setupTableView{
    
    // 设置 tableView 内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = TDTitilesViewY + TDTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 设置 tableView 的右侧滚动进度条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 去掉表格的分割线，表格背景色为透明
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册 xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDTopicCell class])
                                               bundle:nil]
         forCellReuseIdentifier:TDTopicCellId];
}

#pragma mark - 添加刷新控件
- (void)setupRefresh{
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewTopics)];
    
    // 自动改变上拉刷新控件的透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 下拉刷新
- (void)loadNewTopics{
    // 一旦进入下拉刷新，首先要结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"
                            parameters:params
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
                                   
                                   // 如果最新请求的参数和存储的请求参数不一样，则原来的请求作废
                                   if (self.params != params) return;
                                   
                                   // 存储maxtime
                                   self.maxtime = responseObject[@"info"][@"maxtime"];
                                   
                                   // 字典 -> 模型
                                   self.topics = [TDTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                                   
                                   [self.tableView reloadData];              // 刷新表格
                                   [self.tableView.mj_header endRefreshing]; // 结束刷新
                                   self.page = 0;                            // 清空页码
                                   
                                   //[responseObject writeToFile:@"/Users/TD/Desktop/duanzi.plist" atomically:YES];
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   // 如果最新请求的参数和存储的请求参数不一样，则原来的请求作废
                                   if (self.params != params) return;
                                   
                                   [self.tableView.mj_header endRefreshing];  // 结束刷新
                               }];
}

#pragma mark - 上拉加载更多
- (void)loadMoreTopics{
    
    // 一旦进入上拉刷新，首先要结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"
                            parameters:params
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
                                   
                                   // 如果最新请求的参数和存储的请求参数不一样，则原来的请求作废
                                   if (self.params != params) return;
                                   
                                   // 存储maxtime
                                   self.maxtime = responseObject[@"info"][@"maxtime"];
                                   
                                   // 字典 -> 模型
                                   NSArray *newTopics = [TDTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                                   [self.topics addObjectsFromArray:newTopics];
                                   
                                   [self.tableView reloadData];              // 刷新表格
                                   [self.tableView.mj_footer endRefreshing]; // 结束刷新
                                   self.page = page;                         // 设置页码
                                   
                                   //[responseObject writeToFile:@"/Users/TD/Desktop/duanzi.plist" atomically:YES];
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   
                                   // 如果最新请求的参数和存储的请求参数不一样，则原来的请求作废
                                   if (self.params != params) return;
                                   
                                   [self.tableView.mj_footer endRefreshing]; // 结束刷新
                               }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TDTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TDTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - tableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
