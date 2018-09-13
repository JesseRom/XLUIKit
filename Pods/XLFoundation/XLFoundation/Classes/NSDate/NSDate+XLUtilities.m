//
//  NSDate+XLUtilities.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/2.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSDate+XLUtilities.h"

// Thanks, AshFurrow
static const unsigned componentFlags =
(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitHour |
 NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate(XLUtilities)

// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
+ (NSCalendar *)xl_currentCalendar
{
    static NSCalendar *sharedCalendar   = nil;
    if (!sharedCalendar) sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *)xl_dateWithDaysFromNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] xl_dateByAddingDays:days];
}

+ (NSDate *)xl_dateWithDaysBeforeNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] xl_dateBySubtractingDays:days];
}

+ (NSDate *)xl_dateTomorrow
{
    return [NSDate xl_dateWithDaysFromNow:1];
}

+ (NSDate *)xl_dateYesterday
{
    return [NSDate xl_dateWithDaysBeforeNow:1];
}

+ (NSDate *)xl_dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)xl_dateWithHoursBeforeNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)xl_dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)xl_dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - String Properties
- (NSString *)xl_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)xl_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle        = dateStyle;
    formatter.timeStyle        = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *)xl_shortString
{
    return [self xl_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)xl_shortTimeString
{
    return [self xl_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)xl_shortDateString
{
    return [self xl_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)xl_mediumString
{
    return [self xl_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)xl_mediumTimeString
{
    return [self xl_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)xl_mediumDateString
{
    return [self xl_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)xl_longString
{
    return [self xl_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
}

- (NSString *)xl_longTimeString
{
    return [self xl_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle];
}

- (NSString *)xl_longDateString
{
    return [self xl_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL)xl_isEqualToDateIgnoringTime:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate xl_currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) && (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)xl_isToday
{
    return [self xl_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)xl_isTomorrow
{
    return [self xl_isEqualToDateIgnoringTime:[NSDate xl_dateTomorrow]];
}

- (BOOL)xl_isYesterday
{
    return [self xl_isEqualToDateIgnoringTime:[NSDate xl_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)xl_isSameWeekAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate xl_currentCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs(floor([self timeIntervalSinceDate:aDate])) < D_WEEK);
}

- (BOOL)xl_isThisWeek
{
    return [self xl_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)xl_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self xl_isSameWeekAsDate:newDate];
}

- (BOOL)xl_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self xl_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)xl_isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 =
    [[NSDate xl_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 =
    [[NSDate xl_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) && (components1.year == components2.year));
}

- (BOOL)xl_isThisMonth
{
    return [self xl_isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL)xl_isLastMonth
{
    return [self xl_isSameMonthAsDate:[[NSDate date] xl_dateBySubtractingMonths:1]];
}

- (BOOL)xl_isNextMonth
{
    return [self xl_isSameMonthAsDate:[[NSDate date] xl_dateByAddingMonths:1]];
}

- (BOOL)xl_isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate xl_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate xl_currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)xl_isThisYear
{
    // Thanks, baspellis
    return [self xl_isSameYearAsDate:[NSDate date]];
}

- (BOOL)xl_isNextYear
{
    NSDateComponents *components1 = [[NSDate xl_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate xl_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)xl_isLastYear
{
    NSDateComponents *components1 = [[NSDate xl_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate xl_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)xl_isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)xl_isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL)xl_isInFuture
{
    return ([self xl_isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL)xl_isInPast
{
    return ([self xl_isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL)xl_isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) || (components.weekday == 7)) return YES;
    return NO;
}

- (BOOL)xl_isTypicallyWorkday
{
    return ![self xl_isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

- (NSDate *)xl_changeYear:(NSInteger)year
                     month:(NSInteger)month
                       day:(NSInteger)day
                      hour:(NSInteger)hour
                    minute:(NSInteger)minute
                    second:(NSInteger)second
{
    NSCalendar *calendar             = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year              = year;
    dateComponents.month             = month;
    dateComponents.day               = day;
    dateComponents.hour              = hour;
    dateComponents.minute            = minute;
    dateComponents.second            = second;
    return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)xl_beginningOfYear
{
    return [self xl_changeYear:self.xl_year month:1 day:1 hour:0 minute:0 second:0];
}

- (NSDate *)xl_beginningOfMonth
{
    return [self xl_changeYear:self.xl_year month:self.xl_month day:1 hour:0 minute:0 second:0];
}

- (NSDate *)xl_beginningOfDay
{
    return [self xl_changeYear:self.xl_year month:self.xl_month day:self.xl_day hour:0 minute:0 second:0];
}

- (NSDate *)xl_endOfYear
{
    return [self xl_changeYear:self.xl_year month:12 day:31 hour:23 minute:59 second:59];
}

- (NSDate *)xl_endOfMonth
{
    NSInteger lastDay =
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return [self xl_changeYear:self.xl_year month:self.xl_month day:lastDay hour:23 minute:59 second:59];
}

- (NSDate *)xl_endOfDay
{
    return [self xl_changeYear:self.xl_year month:self.xl_month day:self.xl_day hour:23 minute:59 second:59];
}

// Thaks, rsjohnson
- (NSDate *)xl_dateByAddingYears:(NSInteger)dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)xl_dateBySubtractingYears:(NSInteger)dYears
{
    return [self xl_dateByAddingYears:-dYears];
}

- (NSDate *)xl_dateByAddingMonths:(NSInteger)dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)xl_dateBySubtractingMonths:(NSInteger)dMonths
{
    return [self xl_dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *)xl_dateByAddingDays:(NSInteger)dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)xl_dateBySubtractingDays:(NSInteger)dDays
{
    return [self xl_dateByAddingDays:(dDays * -1)];
}

- (NSDate *)xl_dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)xl_dateBySubtractingHours:(NSInteger)dHours
{
    return [self xl_dateByAddingHours:(dHours * -1)];
}

- (NSDate *)xl_dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)xl_dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self xl_dateByAddingMinutes:(dMinutes * -1)];
}

- (NSDateComponents *)xl_componentsWithOffsetFromDate:(NSDate *)aDate
{
    NSDateComponents *dTime = [[NSDate xl_currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Extremes

+ (NSDate *)xl_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar             = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year              = year;
    dateComponents.month             = month;
    dateComponents.day               = day;
    return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)xl_dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    components.hour              = 0;
    components.minute            = 0;
    components.second            = 0;
    return [[NSDate xl_currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *)xl_dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    components.hour              = 23; // Thanks Aleksey Kononov
    components.minute            = 59;
    components.second            = 59;
    return [[NSDate xl_currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger)xl_minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_MINUTE);
}

- (NSInteger)xl_minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_MINUTE);
}

- (NSInteger)xl_hoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_HOUR);
}

- (NSInteger)xl_hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_HOUR);
}

- (NSInteger)xl_daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_DAY);
}

- (NSInteger)xl_daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)xl_distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components =
    [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates

- (NSInteger)xl_nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)xl_hour
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger)xl_minute
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger)xl_seconds
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger)xl_day
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger)xl_month
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger)xl_week
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger)xl_weekday
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger)xl_nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)xl_year
{
    NSDateComponents *components = [[NSDate xl_currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

@end
