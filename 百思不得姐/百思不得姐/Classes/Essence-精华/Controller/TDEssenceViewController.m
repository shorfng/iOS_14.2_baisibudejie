//
//  TDEssenceViewController.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/6.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDEssenceViewController.h"
#import "TDTopicViewController.h"

@interface TDEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *indicatorView;     // 标签栏底部的指示器
@property (nonatomic, weak) UIView *titlesView;        // 顶部的所有标签
@property (nonatomic, weak) UIScrollView *contentView; // 中间的内容
@property (nonatomic, weak) UIButton *selectedButton;  // 标签栏当前选中的按钮
@end

@implementation TDEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVces];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 设置中间内容的scrollView
    [self setupContentView];
}

#pragma mark - 设置导航栏
-(void)setupNav{
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

#pragma mark - 初始化子控制器
- (void)setupChildVces{
    
    // 推荐
    TDTopicViewController *recom = [[TDTopicViewController alloc] init];
    recom.title = @"推荐";
    recom.type = TDTopicTypeRecom;
    [self addChildViewController:recom];
    
    // 视频
    TDTopicViewController *video = [[TDTopicViewController alloc] init];
    video.title = @"视频";
    video.type  = TDTopicTypeVideo;
    [self addChildViewController:video];
    
    // 图片
    TDTopicViewController *picture = [[TDTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = TDTopicTypePicture;
    [self addChildViewController:picture];
    
    // 段子
    TDTopicViewController *word = [[TDTopicViewController alloc] init];
    word.title = @"段子";
    word.type = TDTopicTypeWord;
    [self addChildViewController:word];
    
    // 声音
    TDTopicViewController *voice = [[TDTopicViewController alloc] init];
    voice.title = @"声音";
    video.type = TDTopicTypeVoice;
    [self addChildViewController:voice];
}

#pragma mark - 设置顶部的标签栏
-(void)setupTitlesView{
    
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = TDTitilesViewH;
    titlesView.y = TDTitilesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        
        // 子标签大小
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        
        // 子标签属性
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self
                   action:@selector(titleClick:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 指示器的动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 让 contentView 沿着x轴滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width; // 只改变x值，即横向移动
    
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark - 设置中间内容的scrollView
- (void)setupContentView{
    // 不要自动调整inset，必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    
    // 宽度 = 一个contentView的宽 x 子控制器的个数
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)rankClick{
    TDLogFunc;
}

-(void)crossClick{
    TDLogFunc;
}

#pragma mark - UIScrollViewDelegate（代理方法） - 滚动的动画完成时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20，在状态栏下方)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    [scrollView addSubview:vc.view];
}

#pragma mark - 停止拖拽后，滚动到子控制器，点击相应的标签按钮
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
