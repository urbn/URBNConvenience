//
//  DateConvenienceTests.swift
//  URBNConvenience
//
//  Created by Jason Grandelli on 11/15/16.
//  Copyright © 2016 jgrandelli. All rights reserved.
//

import XCTest
import URBNConvenience

class DateConvenienceTests: XCTestCase {
    let refDate = Date(timeIntervalSinceReferenceDate: 190058400.0)
    
    func testDateUnits() {
        XCTAssert(Date.monthSymbols().count == 12, "Should have 12 month symbols. Got: \(Date.monthSymbols().count)")
        XCTAssert(Date.monthSymbols().first == "January", "First month symbole should be January. Got: \(Date.monthSymbols().first)")
        XCTAssert(Date.monthSymbols().last == "December", "Last month symbole should be December. Got: \(Date.monthSymbols().last)")
        XCTAssert(Date.monthSymbol(month: 1) == "February", "Month symbole at index of 1 should be February. Got: \(Date.monthSymbol(month: 1))")
        
        let components = refDate.components(inTimeZone: TimeZone(secondsFromGMT: 0)!)
        XCTAssert(components.year == 2007, "Year shoud be 2007. Got: \(components.year)")
        XCTAssert(components.month == 1, "Month should be 1. Got: \(components.month)")
        XCTAssert(components.day == 9, "Day should be 9. Got: \(components.day)")
        XCTAssert(components.hour == 18, "Hour should be 18. Got: \(components.hour)")
    }
    
    func testCreation() {
        var testDate = refDate.dateByAdding(years: 1)
        var testComp = testDate?.components(inTimeZone: TimeZone(secondsFromGMT: 0)!)
        
        XCTAssertNotNil(testDate, "testDate should not be nil.")
        XCTAssert(testComp?.year == 2008, "Year shoud be 2008. Got: \(testComp?.year)")
        XCTAssert(testComp?.month == 1, "Month should be 1. Got: \(testComp?.month)")
        XCTAssert(testComp?.day == 9, "Day should be 9. Got: \(testComp?.day)")
        XCTAssert(testComp?.hour == 18, "Hour should be 18. Got: \(testComp?.hour)")
        
        testDate = refDate.dateByAdding()
        XCTAssert(testDate == refDate)
        
        testDate = Date.dateFrom(year: 2007, month: 1, day: 9)
        testComp = testDate?.components(inTimeZone: TimeZone(secondsFromGMT: 0)!)
        XCTAssertNotNil(testDate, "testDate should not be nil.")
        XCTAssert(testComp?.year == 2007, "Year shoud be 2007. Got: \(testComp?.year)")
        XCTAssert(testComp?.month == 1, "Month should be 1. Got: \(testComp?.month)")
        XCTAssert(testComp?.day == 9, "Day should be 9. Got: \(testComp?.day)")
        
        testDate = Date.dateFromString("01/09/2007", format: "MM/dd/yyyy")
        testComp = testDate?.components(inTimeZone: TimeZone(secondsFromGMT: 0)!)
        XCTAssert(testComp?.year == 2007, "Year shoud be 2007. Got: \(testComp?.year)")
        XCTAssert(testComp?.month == 1, "Month should be 1. Got: \(testComp?.month)")
        XCTAssert(testComp?.day == 9, "Day should be 9. Got: \(testComp?.day)")
    }
    
    func testDisplay() {
        XCTAssertEqual(refDate.string(withFormat: "MM/dd/yy"), "01/09/07")
    }
}
