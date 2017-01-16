//
//  TDRecommendUserCell.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/16.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDRecommendUserCell.h"
#import "TDRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface TDRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView; // 头像
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;     // 昵称
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;      // 粉丝数
@end

@implementation TDRecommendUserCell

#pragma mark - 重写右侧的内容
- (void)setUser:(TDRecommendUser *)user{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header]          // 设置图片的url
                            placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];  // 设置占位图片
}

@end
