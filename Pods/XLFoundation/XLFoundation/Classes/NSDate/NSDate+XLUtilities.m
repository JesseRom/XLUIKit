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
+ (NSCalendar *)mzd_currentCalendar
{
    static NSCalendar *sharedCalendar   = nil;
    if (!sharedCalendar) sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *)mzd_dateWithDaysFromNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] mzd_dateByAddingDays:days];
}

+ (NSDate *)mzd_dateWithDaysBeforeNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] mzd_dateBySubtractingDays:days];
}

+ (NSDate *)mzd_dateTomorrow
{
    return [NSDate mzd_dateWithDaysFromNow:1];
}

+ (NSDate *)mzd_dateYesterday
{
    return [NSDate mzd_dateWithDaysBeforeNow:1];
}

+ (NSDate *)mzd_dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)mzd_dateWithHoursBeforeNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)mzd_dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)mzd_dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - String Properties
- (NSString *)mzd_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)mzd_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle        = dateStyle;
    formatter.timeStyle        = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *)mzd_shortString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)mzd_shortTimeString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)mzd_shortDateString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)mzd_mediumString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)mzd_mediumTimeString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)mzd_mediumDateString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)mzd_longString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
}

- (NSString *)mzd_longTimeString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle];
}

- (NSString *)mzd_longDateString
{
    return [self mzd_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL)mzd_isEqualToDateIgnoringTime:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) && (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)mzd_isToday
{
    return [self mzd_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)mzd_isTomorrow
{
    return [self mzd_isEqualToDateIgnoringTime:[NSDate mzd_dateTomorrow]];
}

- (BOOL)mzd_isYesterday
{
    return [self mzd_isEqualToDateIgnoringTime:[NSDate mzd_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)mzd_isSameWeekAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs(floor([self timeIntervalSinceDate:aDate])) < D_WEEK);
}

- (BOOL)mzd_isThisWeek
{
    return [self mzd_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)mzd_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self mzd_isSameWeekAsDate:newDate];
}

- (BOOL)mzd_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self mzd_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)mzd_isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 =
    [[NSDate mzd_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 =
    [[NSDate mzd_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) && (components1.year == components2.year));
}

- (BOOL)mzd_isThisMonth
{
    return [self mzd_isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL)mzd_isLastMonth
{
    return [self mzd_isSameMonthAsDate:[[NSDate date] mzd_dateBySubtractingMonths:1]];
}

- (BOOL)mzd_isNextMonth
{
    return [self mzd_isSameMonthAsDate:[[NSDate date] mzd_dateByAddingMonths:1]];
}

- (BOOL)mzd_isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate mzd_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate mzd_currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)mzd_isThisYear
{
    // Thanks, baspellis
    return [self mzd_isSameYearAsDate:[NSDate date]];
}

- (BOOL)mzd_isNextYear
{
    NSDateComponents *components1 = [[NSDate mzd_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate mzd_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)mzd_isLastYear
{
    NSDateComponents *components1 = [[NSDate mzd_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate mzd_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)mzd_isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)mzd_isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL)mzd_isInFuture
{
    return ([self mzd_isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL)mzd_isInPast
{
    return ([self mzd_isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL)mzd_isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) || (components.weekday == 7)) return YES;
    return NO;
}

- (BOOL)mzd_isTypicallyWorkday
{
    return ![self mzd_isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

- (NSDate *)mzd_changeYear:(NSInteger)year
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

- (NSDate *)mzd_beginningOfYear
{
    return [self mzd_changeYear:self.mzd_year month:1 day:1 hour:0 minute:0 second:0];
}

- (NSDate *)mzd_beginningOfMonth
{
    return [self mzd_changeYear:self.mzd_year month:self.mzd_month day:1 hour:0 minute:0 second:0];
}

- (NSDate *)mzd_beginningOfDay
{
    return [self mzd_changeYear:self.mzd_year month:self.mzd_month day:self.mzd_day hour:0 minute:0 second:0];
}

- (NSDate *)mzd_endOfYear
{
    return [self mzd_changeYear:self.mzd_year month:12 day:31 hour:23 minute:59 second:59];
}

- (NSDate *)mzd_endOfMonth
{
    NSInteger lastDay =
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return [self mzd_changeYear:self.mzd_year month:self.mzd_month day:lastDay hour:23 minute:59 second:59];
}

- (NSDate *)mzd_endOfDay
{
    return [self mzd_changeYear:self.mzd_year month:self.mzd_month day:self.mzd_day hour:23 minute:59 second:59];
}

// Thaks, rsjohnson
- (NSDate *)mzd_dateByAddingYears:(NSInteger)dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)mzd_dateBySubtractingYears:(NSInteger)dYears
{
    return [self mzd_dateByAddingYears:-dYears];
}

- (NSDate *)mzd_dateByAddingMonths:(NSInteger)dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)mzd_dateBySubtractingMonths:(NSInteger)dMonths
{
    return [self mzd_dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *)mzd_dateByAddingDays:(NSInteger)dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)mzd_dateBySubtractingDays:(NSInteger)dDays
{
    return [self mzd_dateByAddingDays:(dDays * -1)];
}

- (NSDate *)mzd_dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)mzd_dateBySubtractingHours:(NSInteger)dHours
{
    return [self mzd_dateByAddingHours:(dHours * -1)];
}

- (NSDate *)mzd_dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)mzd_dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self mzd_dateByAddingMinutes:(dMinutes * -1)];
}

- (NSDateComponents *)mzd_componentsWithOffsetFromDate:(NSDate *)aDate
{
    NSDateComponents *dTime = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Extremes

+ (NSDate *)mzd_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar             = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year              = year;
    dateComponents.month             = month;
    dateComponents.day               = day;
    return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)mzd_dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    components.hour              = 0;
    components.minute            = 0;
    components.second            = 0;
    return [[NSDate mzd_currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *)mzd_dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    components.hour              = 23; // Thanks Aleksey Kononov
    components.minute            = 59;
    components.second            = 59;
    return [[NSDate mzd_currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger)mzd_minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_MINUTE);
}

- (NSInteger)mzd_minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_MINUTE);
}

- (NSInteger)mzd_hoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_HOUR);
}

- (NSInteger)mzd_hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_HOUR);
}

- (NSInteger)mzd_daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_DAY);
}

- (NSInteger)mzd_daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)mzd_distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components =
    [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates

- (NSInteger)mzd_nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate              = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)mzd_hour
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger)mzd_minute
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger)mzd_seconds
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger)mzd_day
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger)mzd_month
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger)mzd_week
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger)mzd_weekday
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger)mzd_nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)mzd_year
{
    NSDateComponents *components = [[NSDate mzd_currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

@end
