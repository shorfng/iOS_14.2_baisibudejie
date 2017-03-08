//
//  NSDate+TDExtension.m

#import "NSDate+TDExtension.h"

@implementation NSDate (TDExtension)

#pragma mark - 比较from和self的时间差值
- (NSDateComponents *)deltaFrom:(NSDate *)from{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 用到的时间（年月日时分秒）
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 比较时间（from和self的时间差值）
    return [calendar components:unit fromDate:from toDate:self options:0];
}

#pragma mark - 是否是今年（比较年）
- (BOOL)isThisYear{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    // 如果年相同，则是今年
    return nowYear == selfYear;
}

#pragma mark - 是否是今天（方法1：比较字符串）
- (BOOL)isToday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 日期转字符串
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    // 如果年月日都相同，则为今天
    return [nowString isEqualToString:selfString];
}

#pragma mark - 是否是今天（方法2：比较年月日）
//- (BOOL)isToday{
//    // 日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//
//    // 如果年月日都相同，则为今天
//    return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day;
//}

#pragma mark - 是否是昨天（只比较年月日）
- (BOOL)isYesterday{
    // 2014-12-31 23:59:59 -> 2014-12-31
    // 2015-01-01 00:00:01 -> 2015-01-01
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 把日期转为时分秒都是 0 的时间
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    // 比较年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    // 如果年月都相同，天相差一天，则为昨天
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

@end
