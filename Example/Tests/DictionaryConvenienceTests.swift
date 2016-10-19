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

    func testCombineDictionaryLiterals() {
        let foobar = ["Urban": 1234] + ["Outfitters": 5678]
        XCTAssert(foobar["Urban"] == 1234)
        XCTAssert(foobar["Outfitters"] == 5678)
        XCTAssert(foobar.keys.count == 2)
    }

    func testCombineDictionaryLiteralsKeysOverride() {
        let foobar = ["UO": 1234] + ["UO": 5678]
        XCTAssert(foobar["UO"] == 5678)
        XCTAssert(foobar.keys.count == 1)
    }

    func testNilDictionary() {
        var foo = ["Hello": 1234]
        let bar: [String: Int]? = nil
        foo += bar
        XCTAssert(foo["Hello"] == 1234)
        XCTAssert(foo.keys.count == 1)
    }

    func testNilLiteral() {
        let foobar = ["UO": 1234] + nil
        XCTAssert(foobar["UO"] == 1234)
        XCTAssert(foobar.keys.count == 1)
    }

}
