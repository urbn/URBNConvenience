//
//  DateConvenience.swift
//  Pods
//
//  Created by Jason Grandelli on 11/14/16.
//
//

import Foundation

public extension Date {
    public var components: DateComponents? {
        return Calendar.current.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone], from: self)
    }
    
    public func dateByAdding(years: Int? = nil, months: Int? = nil, weeks: Int? = nil, days:Int? = nil, hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil) -> Date? {
        var components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    public func isAfter(date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    public func dateFrom(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date {
        var components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        
        return Date()
    }
    
}

//                                    hour:[NSDate mt_minValueForUnit:NSCalendarUnitHour]


//+ (NSDate *)mt_dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
//{
//    [[NSDate sharedRecursiveLock] lock];
//    NSDateComponents *comps = [NSDate mt_components];
//    [comps setYear:year];
//    [comps setMonth:month];
//    [comps setDay:day];
//    [comps setHour:hour];
//    [comps setMinute:minute];
//    [comps setSecond:second];
//    NSDate *date = [[NSDate mt_calendar] dateFromComponents:comps];
//    [[NSDate sharedRecursiveLock] unlock];
//    return date;
//}
//- (NSInteger)mt_year
//    {
//        [[NSDate sharedRecursiveLock] lock];
//        NSDateComponents *components = [[NSDate mt_calendar] components:NSCalendarUnitYear fromDate:self];
//        NSInteger year = [components year];
//        [[NSDate sharedRecursiveLock] unlock];
//        return year;
//}

//- (NSInteger)mt_dayOfMonth
//    {
//        [[NSDate sharedRecursiveLock] lock];
//        NSDateComponents *components = [[NSDate mt_calendar] components:NSCalendarUnitDay fromDate:self];
//        NSInteger dayOfMonth = [components day];
//        [[NSDate sharedRecursiveLock] unlock];
//        return dayOfMonth;
//}

//- (BOOL)mt_isAfter:(NSDate *)date
//{
//    [[NSDate sharedRecursiveLock] lock];
//    BOOL isAfter = [self compare:date] == NSOrderedDescending;
//    [[NSDate sharedRecursiveLock] unlock];
//    return isAfter;
//}
