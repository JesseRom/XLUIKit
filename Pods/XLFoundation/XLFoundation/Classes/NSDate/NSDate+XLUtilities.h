//
//  NSDate+XLUtilities.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/2.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE 60
#define D_HOUR 3600
#define D_DAY 86400
#define D_WEEK 604800
#define D_YEAR 31556926

@interface NSDate(XLUtilities)

+ (NSCalendar *)xl_currentCalendar; // avoid bottlenecks

// Relative dates from the current date

/**
 @return Fri Aug  3 23:47:51 2018
 打印出的时间不会少8小时
 */
+ (NSDate *)xl_dateTomorrow;
+ (NSDate *)xl_dateYesterday;
+ (NSDate *)xl_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)xl_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)xl_dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)xl_dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)xl_dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)xl_dateWithMinutesBeforeNow:(NSInteger)dMinutes;

// Short string utilities
- (NSString *)xl_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)xl_stringWithFormat:(NSString *)format;
@property (nonatomic, readonly) NSString *xl_shortString;//e.g. 8/2/18, 11:55 PM
@property (nonatomic, readonly) NSString *xl_shortDateString;//e.g. 8/2/18
@property (nonatomic, readonly) NSString *xl_shortTimeString;//e.g. 11:55 PM
@property (nonatomic, readonly) NSString *xl_mediumString;//e.g. Aug 3, 2018 at 12:01:13 AM
@property (nonatomic, readonly) NSString *xl_mediumDateString;//e.g. Aug 3, 2018
@property (nonatomic, readonly) NSString *xl_mediumTimeString;//e.g. 12:01:13 AM
@property (nonatomic, readonly) NSString *xl_longString;//e.g. August 3, 2018 at 12:01:13 AM GMT+8
@property (nonatomic, readonly) NSString *xl_longDateString;//e.g. August 3, 2018
@property (nonatomic, readonly) NSString *xl_longTimeString;//e.g. 12:01:13 AM GMT+8

// Comparing dates
//日期是同一天返回YES，忽略小时
- (BOOL)xl_isEqualToDateIgnoringTime:(NSDate *)aDate;

- (BOOL)xl_isToday;
- (BOOL)xl_isTomorrow;
- (BOOL)xl_isYesterday;

- (BOOL)xl_isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)xl_isThisWeek;
- (BOOL)xl_isNextWeek;
- (BOOL)xl_isLastWeek;

- (BOOL)xl_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)xl_isThisMonth;
- (BOOL)xl_isNextMonth;
- (BOOL)xl_isLastMonth;

- (BOOL)xl_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)xl_isThisYear;
- (BOOL)xl_isNextYear;
- (BOOL)xl_isLastYear;

- (BOOL)xl_isEarlierThanDate:(NSDate *)aDate;
- (BOOL)xl_isLaterThanDate:(NSDate *)aDate;

- (BOOL)xl_isInFuture;
- (BOOL)xl_isInPast;

// Date roles
- (BOOL)xl_isTypicallyWorkday;
- (BOOL)xl_isTypicallyWeekend;

// Adjusting dates
- (NSDate *)xl_beginningOfYear;//e.g. Mon Jan  1 00:00:00 2018
- (NSDate *)xl_beginningOfMonth;//e.g. Wed Aug  1 00:00:00 2018
- (NSDate *)xl_beginningOfDay;//e.g. Fri Aug  3 00:00:00 2018
- (NSDate *)xl_endOfYear;//e.g. Mon Dec 31 23:59:59 2018
- (NSDate *)xl_endOfMonth;//e.g. Fri Aug 31 23:59:59 2018
- (NSDate *)xl_endOfDay;//e.g. Fri Aug  3 23:59:59 2018

- (NSDate *)xl_dateByAddingYears:(NSInteger)dYears;
- (NSDate *)xl_dateBySubtractingYears:(NSInteger)dYears;
- (NSDate *)xl_dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)xl_dateBySubtractingMonths:(NSInteger)dMonths;
- (NSDate *)xl_dateByAddingDays:(NSInteger)dDays;
- (NSDate *)xl_dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)xl_dateByAddingHours:(NSInteger)dHours;
- (NSDate *)xl_dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)xl_dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)xl_dateBySubtractingMinutes:(NSInteger)dMinutes;

// Date extremes
+ (NSDate *)xl_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSDate *)xl_dateAtStartOfDay;//e.g. Fri Aug  3 00:00:00 2018
- (NSDate *)xl_dateAtEndOfDay;//e.g. Fri Aug  3 23:59:59 2018

// Retrieving intervals
- (NSInteger)xl_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)xl_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)xl_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)xl_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)xl_daysAfterDate:(NSDate *)aDate;
- (NSInteger)xl_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)xl_distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger xl_nearestHour;
@property (readonly) NSInteger xl_hour;
@property (readonly) NSInteger xl_minute;
@property (readonly) NSInteger xl_seconds;
@property (readonly) NSInteger xl_day;
@property (readonly) NSInteger xl_month;

/**
 e.g. 2018.8.3 12:54
 xl_nearestHour:1
 xl_week:31
 xl_weekday:6
 xl_nthWeekday:1
 */
@property (readonly) NSInteger xl_week;
@property (readonly) NSInteger xl_weekday;
@property (readonly) NSInteger xl_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger xl_year;

@end
