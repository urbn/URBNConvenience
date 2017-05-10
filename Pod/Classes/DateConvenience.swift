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
    public static func monthSymbols() -> [String] {
        return DateFormatter().monthSymbols
    }
    
    public static func monthSymbol(month: Int) -> String? {
        guard month < monthSymbols().count else { return nil }
        
        return monthSymbols()[month]
    }
    
    public func components(inTimeZone timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> DateComponents {
        return Calendar.autoupdatingCurrent.dateComponents(in: timeZone, from: self)
    }
    
    // MARK: Date Creation
    public func dateByAdding(years: Int? = nil, months: Int? = nil, weeks: Int? = nil, days:Int? = nil, hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        
        return Calendar.autoupdatingCurrent.date(byAdding: components, to: self)
    }
    
    public static func dateFrom(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date? {
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)

        return Calendar.autoupdatingCurrent.date(from: components)
    }

    public static func dateFromString(_ string: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.date(from: string)
    }

    // MARK: Display
    public func string(withFormat format: String, localized: Bool = true) -> String? {
        let formatter = DateFormatter()
        var dateFormat = format
        
        if localized {
            guard let localeFormat = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale.autoupdatingCurrent) else {
                return nil
            }
            
            dateFormat = localeFormat
        }
        
        formatter.dateFormat = dateFormat

        return formatter.string(from: self)
    }
}

// Stupid Tech debt
@objc public class DateCompat: NSObject {
    @objc public static func dateByAddingYears(_ years: Int, toDate date: Date?) -> Date? {
        return date?.dateByAdding(years: years)
    }
    
    @objc public static func dayOfMothForDate(_ date: Date?) -> Int {
        return date?.components().day ?? 0
    }
    
    @objc public static func yearForDate(_ date: Date?) -> Int {
        return date?.components().year ?? 0
    }
    
    @objc public static func monthForDate(_ date: Date?) -> Int {
        return date?.components().month ?? 0
    }
    
    @objc public static func dateFrom(year: Int, month: Int, day: Int) -> Date? {
        return Date.dateFrom(year: year, month: month, day: day)
    }
    
    @objc public static func dateFrom(year: Int, month: Int, day: Int, hour: Int) -> Date? {
        return Date.dateFrom(year: year, month: month, day: day, hour: hour)
    }
    
    @objc public static func monthSymbol(index: Int) -> String? {
        return Date.monthSymbol(month: index)
    }
    
    @objc public static func stringFromDate(_ date: Date?, withFormat format: String, localized: Bool) -> String? {
        return date?.string(withFormat: format, localized: localized)
    }
}
