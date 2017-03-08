//  比较日期的类扩展
//  NSDate+TDExtension.h

#import <Foundation/Foundation.h>

@interface NSDate (TDExtension)
- (NSDateComponents *)deltaFrom:(NSDate *)from;  // 比较from和self的时间差值
- (BOOL)isThisYear;   // 是否为今年
- (BOOL)isToday;      // 是否为今天
- (BOOL)isYesterday;  // 是否为昨天
@end
