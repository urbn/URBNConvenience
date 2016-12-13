//
//  ResultTypeTests.swift
//  URBNConvenience
//
//  Created by Bueno McCartney on 12/13/16.
//  Copyright © 2016 jgrandelli. All rights reserved.
//

import XCTest
import URBNConvenience

class ResultTypeTests: XCTestCase {
    
    func testResultEmptySuccess() {
        
        let result = Result<NoResponseType>.success(nil)
        XCTAssert(result == Result.success(nil), "Result instantiated with nil should be an emptySuccess")
        XCTAssertEqual(result.isEmpty, true, "`isEmpty` should be trye on .emptySuccess results")
        XCTAssertNil(result.value, "`value` should be nil on .emptySuccess results")
        XCTAssertNil(result.error, "`error` should be nil on .emptySuccess results")
    }
    
    func testResultSuccess() {
        let result = Result("sup")
        XCTAssert(result == Result.success("sup"), "Result instantiated with a valid type should be .success(value)")
        XCTAssertEqual(result.value, "sup", "`value` should be populated and equal to initial value on .success results")
        XCTAssertNil(result.error, "`error` should be nil on .success results")
        XCTAssertEqual(result.isEmpty, false, "`isEmpty` should be false on .success results")
    }
    
    func testResultFailure() {
        
        let result = Result(RouterError.invalidRequest)
        XCTAssert(result == Result.failure(RouterError.invalidRequest), "Result instantiated with an error should be .failure(error)")
        XCTAssertEqual(result.error as? RouterError, RouterError.invalidRequest, "`error` should be populated and equal to the initial value")
        // TODO: Ensure changing this test makes sense... it was checking false
        XCTAssertEqual(result.isEmpty, true, "`isEmpty` should be false on .failure results")
        XCTAssertNil(result.value, "`value` should be nil on .failure results")
    }
    
    func testEqualityScenarios() {
        
        struct SomeItem {}
        
        XCTAssertFalse(Result(nil) == Result(""), ".emptySuccess should not equal .success results")
        XCTAssertFalse(Result("") == Result(0), ".success should not equal .success if the Value types differ")
        
        //This one is busted because we no logner have emptyResponse types and instead us NoResponseType. This case should not arise. Need to make sure client apps play nice
        //XCTAssertTrue(Result<String>(nil) == Result<Any>(nil), ".emptySuccess should be equal regardless of the generic type")
        
        XCTAssertFalse(Result<NoResponseType>(nil) == Result(RouterError.invalidRequest), ".emptySuccess should not equal .failure results")
        XCTAssertFalse(Result("") == Result(RouterError.invalidRequest), ".success should not equal .failure results")
        XCTAssertFalse(Result(SomeItem()) == Result(SomeItem()), ".success should not equal .success if Value type is not Equatable")
        
        // Failure should equal failure regardless of type
        XCTAssertTrue(Result<String>(RouterError.invalidResponse) == Result<Any>(RouterError.invalidResponse), ".failure should equal .failure if errors are same")
        XCTAssertTrue(Result<Any>(RouterError.invalidResponse) == Result<Any>(RouterError.invalidResponse), ".failure should equal .failure if errors are same")
    }
    
    func testSuccessResultHandlers() {
        var result = Result("sup")
        
        var makeSureOnSuccessSynchronous: Bool = false
        result.onSuccess { (data) -> Void in
            makeSureOnSuccessSynchronous = true
            XCTAssertEqual(data, "sup", "Result.onSuccess handler should be called when populated")
        }
        XCTAssertEqual(makeSureOnSuccessSynchronous, true, "onSuccess should be synchronous")
        
        result.onError { (err) -> Void in
            XCTFail("This should not happen")
        }
        
        result = .success(nil)
        
        result.onSuccess { (data) -> Void in
            XCTAssertNil(data, "Data should be nil onSuccess of empty successes")
        }
        
        result.onError { (err) -> Void in
            XCTFail("This should not happen")
        }
    }
    
    func testErrorResultHandlers() {
        let result = Result(RouterError.invalidRequest)
        
        var makeSureOnErrorSynchronous: Bool = false
        result.onError { (err) -> Void in
            makeSureOnErrorSynchronous = true
            XCTAssertEqual(err as? RouterError, RouterError.invalidRequest, "Result.onError handler should be called when populated")
        }
        XCTAssertEqual(makeSureOnErrorSynchronous, true, "onError should be synchronous")
        
        result.onSuccess { (data) -> Void in
            XCTFail("This should not happen")
        }
    }    
}
