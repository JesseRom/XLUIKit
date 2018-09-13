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

+ (NSCalendar *)mzd_currentCalendar; // avoid bottlenecks

// Relative dates from the current date

/**
 @return Fri Aug  3 23:47:51 2018
 打印出的时间不会少8小时
 */
+ (NSDate *)mzd_dateTomorrow;
+ (NSDate *)mzd_dateYesterday;
+ (NSDate *)mzd_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)mzd_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)mzd_dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)mzd_dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)mzd_dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)mzd_dateWithMinutesBeforeNow:(NSInteger)dMinutes;

// Short string utilities
- (NSString *)mzd_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)mzd_stringWithFormat:(NSString *)format;
@property (nonatomic, readonly) NSString *mzd_shortString;//e.g. 8/2/18, 11:55 PM
@property (nonatomic, readonly) NSString *mzd_shortDateString;//e.g. 8/2/18
@property (nonatomic, readonly) NSString *mzd_shortTimeString;//e.g. 11:55 PM
@property (nonatomic, readonly) NSString *mzd_mediumString;//e.g. Aug 3, 2018 at 12:01:13 AM
@property (nonatomic, readonly) NSString *mzd_mediumDateString;//e.g. Aug 3, 2018
@property (nonatomic, readonly) NSString *mzd_mediumTimeString;//e.g. 12:01:13 AM
@property (nonatomic, readonly) NSString *mzd_longString;//e.g. August 3, 2018 at 12:01:13 AM GMT+8
@property (nonatomic, readonly) NSString *mzd_longDateString;//e.g. August 3, 2018
@property (nonatomic, readonly) NSString *mzd_longTimeString;//e.g. 12:01:13 AM GMT+8

// Comparing dates
//日期是同一天返回YES，忽略小时
- (BOOL)mzd_isEqualToDateIgnoringTime:(NSDate *)aDate;

- (BOOL)mzd_isToday;
- (BOOL)mzd_isTomorrow;
- (BOOL)mzd_isYesterday;

- (BOOL)mzd_isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)mzd_isThisWeek;
- (BOOL)mzd_isNextWeek;
- (BOOL)mzd_isLastWeek;

- (BOOL)mzd_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)mzd_isThisMonth;
- (BOOL)mzd_isNextMonth;
- (BOOL)mzd_isLastMonth;

- (BOOL)mzd_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)mzd_isThisYear;
- (BOOL)mzd_isNextYear;
- (BOOL)mzd_isLastYear;

- (BOOL)mzd_isEarlierThanDate:(NSDate *)aDate;
- (BOOL)mzd_isLaterThanDate:(NSDate *)aDate;

- (BOOL)mzd_isInFuture;
- (BOOL)mzd_isInPast;

// Date roles
- (BOOL)mzd_isTypicallyWorkday;
- (BOOL)mzd_isTypicallyWeekend;

// Adjusting dates
- (NSDate *)mzd_beginningOfYear;//e.g. Mon Jan  1 00:00:00 2018
- (NSDate *)mzd_beginningOfMonth;//e.g. Wed Aug  1 00:00:00 2018
- (NSDate *)mzd_beginningOfDay;//e.g. Fri Aug  3 00:00:00 2018
- (NSDate *)mzd_endOfYear;//e.g. Mon Dec 31 23:59:59 2018
- (NSDate *)mzd_endOfMonth;//e.g. Fri Aug 31 23:59:59 2018
- (NSDate *)mzd_endOfDay;//e.g. Fri Aug  3 23:59:59 2018

- (NSDate *)mzd_dateByAddingYears:(NSInteger)dYears;
- (NSDate *)mzd_dateBySubtractingYears:(NSInteger)dYears;
- (NSDate *)mzd_dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)mzd_dateBySubtractingMonths:(NSInteger)dMonths;
- (NSDate *)mzd_dateByAddingDays:(NSInteger)dDays;
- (NSDate *)mzd_dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)mzd_dateByAddingHours:(NSInteger)dHours;
- (NSDate *)mzd_dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)mzd_dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)mzd_dateBySubtractingMinutes:(NSInteger)dMinutes;

// Date extremes
+ (NSDate *)mzd_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSDate *)mzd_dateAtStartOfDay;//e.g. Fri Aug  3 00:00:00 2018
- (NSDate *)mzd_dateAtEndOfDay;//e.g. Fri Aug  3 23:59:59 2018

// Retrieving intervals
- (NSInteger)mzd_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)mzd_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)mzd_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)mzd_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)mzd_daysAfterDate:(NSDate *)aDate;
- (NSInteger)mzd_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)mzd_distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger mzd_nearestHour;
@property (readonly) NSInteger mzd_hour;
@property (readonly) NSInteger mzd_minute;
@property (readonly) NSInteger mzd_seconds;
@property (readonly) NSInteger mzd_day;
@property (readonly) NSInteger mzd_month;

/**
 e.g. 2018.8.3 12:54
 mzd_nearestHour:1
 mzd_week:31
 mzd_weekday:6
 mzd_nthWeekday:1
 */
@property (readonly) NSInteger mzd_week;
@property (readonly) NSInteger mzd_weekday;
@property (readonly) NSInteger mzd_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger mzd_year;

@end
