//
//  NSDate+XMGExtension.m
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSDate+XMGExtension.h"

@implementation NSDate (XMGExtension)
- (NSDateComponents *)deltaFrom:(NSDate *)from{
    //日历
    NSCalendar *caledar = [NSCalendar currentCalendar];
    
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [caledar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear {
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

//- (BOOL)isToday{
//    //日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//    
//    return  nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day;
//    
//}


- (BOOL)isToday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *slefString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:slefString];
}

- (BOOL)isYesterday {
    //2014-12-31 23:59:59 -> 2014-12-31
    //2015-01-01 00:00:01 -> 2015-01-01
    
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat =  @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
@end
