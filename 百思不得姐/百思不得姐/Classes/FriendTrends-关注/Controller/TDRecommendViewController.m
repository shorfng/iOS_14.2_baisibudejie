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
#import "TDRecommendCategoryCell.h"   // cell
#import <MJExtension.h>               // 第三方字典转模型
#import "TDRecommendCategory.h"       // 模型

@interface TDRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *categories;                   // 左边的类别数据
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView; // 左边的类别表格
@end

@implementation TDRecommendViewController

static NSString * const TDCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理和数据源
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    
    // 注册xib
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:TDCategoryId];
    
    self.title = @"推荐关注";
    self.view.backgroundColor = TDGlobalBg;
    
    // 显示指示器,设置指示器样式
    [SVProgressHUD show ];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    // 开始发送请求
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
                                   //                                   [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                                   //
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   
                                   // 显示失败信息
                                   [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络！"];
                               }];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TDRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TDCategoryId];

    // 改变 cell 的字体大小和对齐方式
    cell.textLabel.font  = [UIFont fontWithName: @"Arial" size: 13.0];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.category= self.categories[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
