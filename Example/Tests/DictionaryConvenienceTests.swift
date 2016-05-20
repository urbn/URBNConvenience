//
//  DictionaryConvenienceTests.swift
//  URBNConvenience
//
//  Created by Matt Thomas on 5/20/16.
//  Copyright © 2016 jgrandelli. All rights reserved.
//

import XCTest
import URBNConvenience

class DictionaryConvenienceTests: XCTestCase {

    func testCombineSameDictionary() {
        var foo = ["Hello": 1234]
        let bar = ["World": 5678]
        foo += bar
        XCTAssert(foo["Hello"] == 1234)
        XCTAssert(foo["World"] == 5678)
        XCTAssert(foo.keys.count == 2)
    }

    func testCombineSameDictionaryKeysOverride() {
        var foo = ["Hello": 1234]
        let bar = ["Hello": 9876]
        foo += bar
        XCTAssert(foo["Hello"] == 9876)
        XCTAssert(foo.keys.count == 1)
    }

}
