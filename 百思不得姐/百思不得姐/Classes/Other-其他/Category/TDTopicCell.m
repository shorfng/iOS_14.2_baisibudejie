//
//  TDTopicCell.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/3/7.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDTopicCell.h"
#import "TDTopic.h"
#import <UIImageView+WebCache.h>

@interface TDTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;   // 用户头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;              // 用户昵称
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;        // 发帖时间
@property (weak, nonatomic) IBOutlet UIButton *dingButton;            // 被顶数
@property (weak, nonatomic) IBOutlet UIButton *caiButton;             // 被踩数
@property (weak, nonatomic) IBOutlet UIButton *shareButton;           // 分享数
@property (weak, nonatomic) IBOutlet UIButton *commentButton;         // 评论数
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;          // 新浪加V  
@end

@implementation TDTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 给cell设置背景图片
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}


- (void)setTopic:(TDTopic *)topic{
    _topic = topic;
    
    // 不是新浪加V，就隐藏
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]
                             placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    // 设置用户名
    self.nameLabel.text = topic.name;
    // 设置发帖时间
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮右侧显示的东西
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
}

// 如果数量大于1万,placeholder显示xx万； 如果数字大于0，placeholder显示实际数字；如果是其他情况，如等于0，直接显示placeholder
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

#pragma mark - 重新布局
- (void)setFrame:(CGRect)frame{
    // 定义间距
    static CGFloat margin = 10;
    
    // 重写布局
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
