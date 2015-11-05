//
//  NSDate+WDCalendar.h
//  WDCalendar
//
//  Created by Blake on 15/1/9.
//  Copyright (c) 2015年 Blake. All rights reserved.
//


/**
 *  日期格式的处理类
 *
 *  @param WDCalendar 日期格式的处理
 *
 *  @return 相应地日期格式
 */
#import <Foundation/Foundation.h>

#define KWDATE_DEFAULT @"yyyy-MM-dd HH:mm:ss"
#define KWDATE_CHINESEDATE @"yyyy年MM月dd日 HH时mm分ss秒"


@interface NSDate (WDCalendar)
/*
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 */
-(NSDateComponents*)componentsOfDay;

#pragma mark -  获取详细日期属性
/**
 *  获取年
 *
 *  @return 获取年
 */
- (NSUInteger)year;

/**
 *  获取月份
 *
 *  @return 获取月份
 */
- (NSUInteger)month;

/**
 *  获取日
 *
 *  @return 获取日
 */
- (NSUInteger)day;

/**
 *  获取小时
 *
 *  @return 获取小时
 */
- (NSUInteger)hour;

/**
 *  获取分钟
 *
 *  @return 获取分钟
 */
- (NSUInteger)minute;

/**
 *  获取秒数
 *
 *  @return 获取秒数
 */
- (NSUInteger)second;

/**
 *  获取星期几
 *
 *  @return 获取星期几
 */
- (NSUInteger)weekday;

/**
 *  获取第几周
 *
 *  @return 获取第几周
 */
- (NSUInteger)weekofYear;

/**
 *  获取当月天数
 *
 *  @return 获取当月天数
 */
- (NSUInteger)numberOfDaysInCurrentMonth;

/**
 *  获取当月周数
 *
 *  @return 获取当月周数
 */
- (NSUInteger)numberOfWeeksInCurrentMonth;

/**
 *  获取当月中，这一周的天数
 *
 *  @return 获取当月中，这一周的天数
 */
- (NSUInteger)numberOfDaysInTheWeekInMonth;

/**
 *  获取当天是当月的第几周
 *
 *  @return 获取当天是当月的第几周
 */
- (NSUInteger)weekOfDayInMonth;


#pragma mark - 获取日期对象
/**
 *  获取当月第一天日期
 *
 *  @return 获取当月第一天日期
 */
- (NSDate *)firstDayInCurrentMonth;

/**
 *  获取当月最后一天日期
 *
 *  @return 获取当月最后一天日期
 */
- (NSDate *)lastDayInCurrentMonth;

/**
 *  获取当前日上个月日期
 *
 *  @return 获取当前日上个月日期
 */
- (NSDate *)dayInThePreviousMonth;

/**
 *  获取下个月日期
 *
 *  @return 获取下个月日期
 */
- (NSDate *)dayInTheFollowingMonth;


/**
 *  获取当天的起始时间（00:00:00）
 *
 *  @return 获取当天的起始时间（00:00:00）
 */
- (NSDate *)beginingOfDay;

/**
 *  获取当天的结束时间（23:59:59）
 *
 *  @return 获取当天的结束时间（23:59:59）
 */
- (NSDate *)endOfDay;

/**
 *  获取前一个月的第一天
 *
 *  @return 获取前一个月的第一天
 */
- (NSDate *)firstDayOfThePreviousMonth;

/**
 *  获取后一个月的第一天
 *
 *  @return 获取后一个月的第一天
 */
- (NSDate *)firstDayOfTheFollowingMonth;

/**
 *  获取这一周的第一天
 *
 *  @return 获取这一周的第一天
 */
- (NSDate *)firstDayOfTheWeek;

/**
 *  获取当月中，前一周的第一天
 *
 *  @return 获取当月中，前一周的第一天
 */
- (NSDate *)firstDayOfThePreviousWeekInTheMonth;

/**
 *  获取前一个月中，最后一周的第一天
 *
 *  @return 获取前一个月中，最后一周的第一天
 */
- (NSDate *)firstDayOfTheLastWeekInPreviousMonth;

/**
 *  获取当月中，后一周的第一天
 *
 *  @return 获取当月中，后一周的第一天
 */
- (NSDate *)firstDayOfTheFollowingWeekInTheMonth;

/**
 *  获取下一个月中，最前一周的第一天
 *
 *  @return 获取下一个月中，最前一周的第一天
 */
- (NSDate *)firstDayOfTheFirstWeekInFollowingMonth;


/**
 *  获取当月中，这一周的第一天
 *
 *  @return 获取当月中，这一周的第一天
 */
- (NSDate *)firstDayOfTheWeekInTheMonth;


/**
 *  当前日期的昨天
 *
 *  @return 当前日期的昨天
 */
- (NSDate *)yesterDay;


/**
 *  当前日期的明天
 *
 *  @return 当前日期的明天
 */
- (NSDate *)tomorrow;

/**
 *  返回几天前的日期
 *
 *  @param number 几天前
 *
 *  @return 返回几天前的日期
 */
- (NSDate *)daysAgo:(NSInteger)number;

/**
 *  判断与某一天是否为同一天
 *
 *  @param otherDate 某一天
 *
 *  @return YES是同一天,NO不是同一天
 */
- (BOOL)sameDayWithDate:(NSDate *)otherDate;

/**
 *  判断与某一天是否为同一周
 *
 *  @param otherDate 某一天
 *
 *  @return YES是同一周,NO不是同一周
 */
- (BOOL)sameWeekWithDate:(NSDate *)otherDate;

/**
 *  判断与某一天是否为同一月
 *
 *  @param otherDate 某一天
 *
 *  @return YES是同一月,NO不是同一月
 */
- (BOOL)sameMonthWithDate:(NSDate *)otherDate;


/**
 *  获取日期字符(yyyy-MM-dd HH:mm:ss)
 *
 *  @return 获取日期字符(yyyy-MM-dd HH:mm:ss)
 */
- (NSString *)dateString;

/**
 *  对应格式的日期字符 键入KWD提示常用
 *
 *  @param format 日期格式
 *
 *  @return 对应格式的日期字符
 */
- (NSString *)dateStringWithFormat:(NSString*)format;


@end
