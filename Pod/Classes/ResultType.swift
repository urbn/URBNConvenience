//
//  ResultType.swift
//  Pods
//
//  Created by Bueno McCartney on 12/7/16.
//
//

import Foundation

public protocol ResultType {
    associatedtype Value
    
    init(_ value: Value?)
    init(_ error: Error)
    
    var value: Value? { get }
    var error: Error? { get }
}

public enum Result<T>: ResultType {
    public typealias Value = T
    
    case success(Value?)
    case failure(Error)
    
    public var value: Value? {
        switch self {
        case .success(let v): return v
        default: return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .failure(let e): return e
        default: return nil
        }
    }
    
    public init(_ error: Error) {
        self = .failure(error)
    }
    
    public init(_ value: Value?) {
        if let v = value as? Error {
            self = .failure(v)
        }
        else if let v = value {
            self = .success(v)
        }
        else {
            self = .success(nil)
        }
    }
}


public extension Result {
    public var isEmpty: Bool {
        return value == nil
    }
}

// MARK: - Helper Handling -
public extension Result {
    public func onSuccess(handler: (_ data: Value?) -> Void) {
        switch(self) {
        case .success(let data): handler(data)
        default: break
        }
    }
    
    public func onError(handler: (_ err: Error) -> Void) {
        switch(self) {
        case .failure(let e): handler(e)
        default: break
        }
    }
}

public extension Result where T:Equatable {
    public static func ==(lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.success(let lhsVal), .success(let rhsVal)):
            // Two successes are equal if their internal vals are equal
            return lhsVal == rhsVal
            
        case (.failure(let lhsErr), .failure(let rhsErr)):
            // Two errors are equal if their _domain's and _code's are equal
            return lhsErr._domain == rhsErr._domain && lhsErr._code == rhsErr._code
            
        default: return false
        }
    }
}

// MARK: - Equatability -
extension Result: Equatable {}
@objc public class NoResponseType: NSObject {}

public func ==<T,U>(lhs: Result<T>, rhs: Result<U>) -> Bool {
    // Results with different types are not equal
    switch (lhs, rhs) {
    case (.failure(let lhsErr), .failure(let rhsErr)):
        // Two errors are equal if their _domain's and _code's are equal
        return lhsErr._domain == rhsErr._domain && lhsErr._code == rhsErr._code
        
    default: return false
    }
}

public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    switch (lhs, rhs) {
    case (.success, .success) where T.self == NoResponseType.self:
        return true
    case (.failure(let lhsErr), .failure(let rhsErr)):
        // Two errors are equal if their _domain's and _code's are equal
        return lhsErr._domain == rhsErr._domain && lhsErr._code == rhsErr._code
        
    default: return false
    }
}

// MARK: - Map
extension Result {
    
    /// Allow us to transform values in the result type
    ///
    /// - Parameter transform: function to transform one value to another
    /// - Returns: a result with the new value type
    public func map<U>(_ transform: (Value?) throws -> U?) -> Result<U> {
        switch self {
        case .failure(let error):
            return Result<U>(error)
        case .success(let value):
            do {
                return Result<U>(try transform(value))
            }
            catch let error {
                return Result<U>(error)
            }
        }
    }

    /// Allow us to transform errors in the result type
    ///
    /// - Parameter transform: function to transform one error to another
    /// - Returns: a result with the new error type
    public func map(_ transform: (Error) -> Error) -> Result<Value> {
        switch self {
        case .failure(let error):
            return Result(transform(error))
        case .success(let value):
            return Result(value)
        }
    }
}
