
//
//  TDTopic.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/3/2.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDTopic.h"

@implementation TDTopic{
    CGFloat _cellHeight;
}

// 重写发帖时间
- (NSString *)create_time{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {  // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) { // 1天内又大于1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时内又大于1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟内
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 昨天以前（不显示年）
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年（显示全部）
        return _create_time;
    }
}


- (CGFloat)cellHeight{
    if (!_cellHeight) {
        
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * TDTopicCellMargin, MAXFLOAT);
        
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                context:nil].size.height;
        
        // cell的高度
        _cellHeight = TDTopicCellTextY + textH + TDTopicCellBottomBarH + 2 * TDTopicCellMargin;
    }
    return _cellHeight;
}

@end


/**
 1、今年
  （1）今天
       ① 1天内又大于1小时
           “xx小时前”
       ② 1小时内又大于1分钟
          “xx分钟前”
       ③ 1分钟内
          “刚刚”
  （2）昨天
       “昨天 11:54:24”
  （3）昨天以前（不显示年）
       “04-13 14:53:22”
 
 2、非今年（显示全部）
    “2015-08-08 19:45:32”
 */
