//
//  NSDate+WDCalendar.m
//  WDCalendar
//
//  Created by Blake on 15/1/9.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import "NSDate+WDCalendar.h"

@implementation NSDate (WDCalendar)
/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
-(NSDateComponents*)componentsOfDay{
    return [[NSCalendar currentCalendar]components:
            NSCalendarUnitYear |
            NSCalendarUnitMonth |
            NSCalendarUnitDay |
            NSCalendarUnitWeekday |
            NSCalendarUnitWeekdayOrdinal |
            NSCalendarUnitWeekOfYear|
            NSCalendarUnitHour |
            NSCalendarUnitMinute |
            NSCalendarUnitSecond fromDate:self];
}
#pragma mark -  获取详细日期属性
-(NSUInteger)year{
    return [[self componentsOfDay] year];

}
-(NSUInteger)month{
    return [[self componentsOfDay] month];
}
-(NSUInteger)day{
    return [[self componentsOfDay] day];
}
-(NSUInteger)hour{
    return [[self componentsOfDay] hour];
}
-(NSUInteger)minute{
    return [[self componentsOfDay] minute];
}
-(NSUInteger)second{
    return [[self componentsOfDay] second];
}
-(NSUInteger)weekday{
    return [[self componentsOfDay] weekday];
}
-(NSUInteger)weekofYear{
    return [[self componentsOfDay] weekOfYear];
}
-(NSUInteger)numberOfDaysInCurrentMonth{
    
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    
}
-(NSUInteger)numberOfWeeksInCurrentMonth{
    
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitMonth forDate:self].length;
    
}
#pragma mark - 获取日期对象
-(NSDate*)firstDayInCurrentMonth{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

-(NSDate*)lastDayInCurrentMonth{
    
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    dateComponents.day = days;
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
}

- (NSDate *)dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)dayInTheFollowingMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}





- (NSDate *)beginingOfDay
{
    NSDateComponents* c = [self componentsOfDay];

    
    [c setHour:0];
    [c setMinute:0];
    [c setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:c];
}

/******************************************
 *@Description:获取当天的结束时间（23:59:59）
 *@Params:nil
 *@Return:当天的结束时间
 ******************************************/
- (NSDate *)endOfDay
{
    NSDateComponents* c = [self componentsOfDay];
    
    [c setHour:23];
    [c setMinute:59];
    [c setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:c];
}

/******************************************
 *@Description:获取前一个月的第一天
 *@Params:nil
 *@Return:前一个月的第一天
 ******************************************/
- (NSDate *)firstDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
//    NSDate* date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];

//    date = [date firstDayOfTheMonth];
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] firstDayInCurrentMonth];
    /*
     NSDateComponents *components = [[NSDateComponents alloc] init];
     components.month = -1;
     
     return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] firstDayOfTheMonth];
     */
}

/******************************************
 *@Description:获取后一个月的第一天
 *@Params:nil
 *@Return:后一个月的第一天
 ******************************************/
- (NSDate *)firstDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] firstDayInCurrentMonth];
}


/******************************************
 *@Description:获取前一个月中与当天对应的日期
 *@Params:nil
 *@Return:前一个月中与当天对应的日期
 ******************************************/
- (NSDate *)associateDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:获取后一个月中与当天对应的日期
 *@Params:nil
 *@Return:后一个月中与当天对应的日期
 ******************************************/
- (NSDate *)associateDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:获取这一周的第一天
 *@Params:nil
 *@Return:这一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheWeek
{
    NSDate *firstDay = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&firstDay interval:NULL forDate:self]) {
        return firstDay;
    }
    
    return firstDay;
}

/******************************************
 *@Description:获取当月中，前一周的第一天
 *@Params:nil
 *@Return:前一周的第一天
 ******************************************/
- (NSDate *)firstDayOfThePreviousWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self firstDayOfTheWeekInTheMonth];
    if ([firstDayOfTheWeekInTheMonth componentsOfDay].weekday > 1) {
        return nil;
    } else {
        if ([firstDayOfTheWeekInTheMonth componentsOfDay].day > 7) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.day = -7;
            return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
        } else if ([firstDayOfTheWeekInTheMonth componentsOfDay].day > 1) {
            return [self firstDayInCurrentMonth];
        } else {
            return nil;
        }
    }
}

/******************************************
 *@Description:获取前一个月中，最后一周的第一天
 *@Params:nil
 *@Return:前一个月中，最后一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheLastWeekInPreviousMonth
{
    NSDate *firstDayOfThePreviousMonth = [self firstDayOfThePreviousMonth];
    NSUInteger numberOfDaysInPreviousMonth = [firstDayOfThePreviousMonth numberOfDaysInCurrentMonth];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = [firstDayOfThePreviousMonth componentsOfDay].year;
    components.month = [firstDayOfThePreviousMonth componentsOfDay].month;
    components.day = numberOfDaysInPreviousMonth;
    NSDate *lastDayOfThePreviousMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return [lastDayOfThePreviousMonth firstDayOfTheWeekInTheMonth];
}


/******************************************
 *@Description:获取当月中，后一周的第一天
 *@Params:nil
 *@Return:后一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheFollowingWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self firstDayOfTheWeekInTheMonth];
    NSUInteger numberOfDaysInMonth = [self numberOfDaysInCurrentMonth];
    if (([firstDayOfTheWeekInTheMonth componentsOfDay].day + 6) >= numberOfDaysInMonth) {
        return nil;
    } else {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 6;
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    }
}

/******************************************
 *@Description:获取下一个月中，最前一周的第一天
 *@Params:nil
 *@Return:下一个月中，最前一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheFirstWeekInFollowingMonth
{
    NSDate *firstDayOfTheFollowingMonth = [self firstDayOfTheFollowingMonth];
    
    return [firstDayOfTheFollowingMonth firstDayOfTheWeekInTheMonth];
}


/******************************************
 *@Description:获取当月中，这一周的第一天
 *@Params:nil
 *@Return:当月中，这一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheWeekInTheMonth
{
    NSDate *firstDayOfTheWeek = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&firstDayOfTheWeek interval:NULL forDate:self]) {
        NSDate *firstDayOfTheMonth = [self firstDayInCurrentMonth];
        if ([firstDayOfTheWeek componentsOfDay].month == [firstDayOfTheMonth componentsOfDay].month) {
            return firstDayOfTheWeek;
        } else {
            return firstDayOfTheMonth;
        }
    }
    
    return firstDayOfTheWeek;
}


/******************************************
 *@Description:获取当月中，这一周的天数
 *@Params:nil
 *@Return:当月中，这一周的天数
 ******************************************/
- (NSUInteger)numberOfDaysInTheWeekInMonth
{
    NSDate *firstDayOfTheWeek = [self firstDayOfTheWeek];
    NSDate *firstDayOfTheWeekInTheMonth = [self firstDayOfTheWeekInTheMonth];
    
    if ([firstDayOfTheWeek componentsOfDay].month == [firstDayOfTheWeekInTheMonth componentsOfDay].month) {
        return (firstDayOfTheWeek.numberOfDaysInCurrentMonth - [firstDayOfTheWeek componentsOfDay].day + 1) >= 7 ? 7 : (firstDayOfTheWeek.numberOfDaysInCurrentMonth - [firstDayOfTheWeek componentsOfDay].day + 1);
    } else {
        return (8 - [firstDayOfTheWeekInTheMonth componentsOfDay].weekday);
    }
}

/******************************************
 *@Description:获取当天是当月的第几周
 *@Params:nil
 *@Return:当天是当月的第几周
 ******************************************/
- (NSUInteger)weekOfDayInMonth
{
    NSDate *firstDayOfTheMonth = [self firstDayInCurrentMonth];
    NSUInteger weekdayOfFirstDayOfTheMonth = [firstDayOfTheMonth componentsOfDay].weekday;
    NSUInteger day = [self componentsOfDay].day;
    
    return ((day + weekdayOfFirstDayOfTheMonth - 1)%7) ? ((day + weekdayOfFirstDayOfTheMonth - 1)/7) + 1: ((day + weekdayOfFirstDayOfTheMonth - 1)/7);
}

/******************************************
 *@Description:前一天
 *@Params:nil
 *@Return:前一天
 ******************************************/
- (NSDate *)yesterDay
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)daysAgo:(NSInteger)number
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -number;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}


/******************************************
 *@Description:后一天
 *@Params:nil
 *@Return:后一天
 ******************************************/
- (NSDate *)tomorrow
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}


/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)sameDayWithDate:(NSDate *)otherDate
{
    if (self.year == otherDate.year && self.month == otherDate.month && self.day == otherDate.day) {
        return YES;
    } else {
        return NO;
    }
}


/******************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)sameWeekWithDate:(NSDate *)otherDate
{
    if (self.year == otherDate.year  && self.month == otherDate.month && self.weekofYear == otherDate.weekofYear) {
        return YES;
    } else {
        return NO;
    }
}

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)sameMonthWithDate:(NSDate *)otherDate
{
    if (self.year == otherDate.year && self.month == otherDate.month) {
        return YES;
    } else {
        return NO;
    }
}


//获取日期字符
- (NSString *)dateString{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [dateFormatter stringFromDate:self];
    
}

- (NSString *)dateStringWithFormat:(NSString*)format {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = format;
    
    return [dateFormatter stringFromDate:self];
}



@end
