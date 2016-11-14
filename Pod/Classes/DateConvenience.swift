//
//  DateConvenience.swift
//  Pods
//
//  Created by Jason Grandelli on 11/14/16.
//
//

import Foundation

public extension Date {
    // MARK: Units
    public var components: DateComponents? {
        return Calendar.current.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone], from: self)
    }

    public static func monthSymbols() -> [String] {
        return DateFormatter().monthSymbols
    }
    
    public static func monthSymbol(month: Int) -> String? {
        guard month < monthSymbols().count else { return nil }
        
        return monthSymbols()[month]
    }
    
    // MARK: Date Creation
    public func dateByAdding(years: Int? = nil, months: Int? = nil, weeks: Int? = nil, days:Int? = nil, hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil) -> Date? {
        var components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    public func dateFrom(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date {
        var components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        
        return Date()
    }

    public func dateInTimeZone(_ timeZone: TimeZone) -> Date {
        let currentOffset = TimeZone.current.secondsFromGMT(for: self)
        let toOffset = timeZone.secondsFromGMT(for: self)
        let diff = TimeInterval(toOffset - currentOffset)

        return self.addingTimeInterval(diff)
    }

    // MARK: Relativity
    public func isBefore(date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }

    public func isAfter(date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }

    // MARK: Display
    public func string(withFormat format: String, localized: Bool = true) -> String? {
        var formatter = DateFormatter()
        
        if localized {
            guard let format = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale.current) else {
                return nil
            }
        }
        
        formatter.dateFormat = format

        return formatter.string(from: self)
    }
}
