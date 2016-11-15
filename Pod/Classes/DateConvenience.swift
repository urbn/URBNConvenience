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
        var components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        
        return Calendar.autoupdatingCurrent.date(byAdding: components, to: self)
    }
    
    public static func dateFrom(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date? {
        var components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)

        return Calendar.autoupdatingCurrent.date(from: components)
    }

    public static func dateFromString(_ string: String, format: String) -> Date? {
        var formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.date(from: string)
    }

    // MARK: Display
    public func string(withFormat format: String, localized: Bool = true) -> String? {
        var formatter = DateFormatter()
        
        if localized {
            guard let format = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale.autoupdatingCurrent) else {
                return nil
            }
        }
        
        formatter.dateFormat = format

        return formatter.string(from: self)
    }
}
