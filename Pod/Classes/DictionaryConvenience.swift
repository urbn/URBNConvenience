//
//  DictionaryConvenience.swift
//  Pods
//
//  Created by Matt Thomas on 5/20/16.
//
//

import Foundation

public func += <Key, Value> ( left: inout [Key: Value], right: [Key: Value]?) {
    guard let right = right else {
        return
    }

    for (key, value) in right {
        left[key] = value
    }
}

public func + <Key, Value> (left: [Key: Value], right: [Key: Value]?) -> [Key: Value] {
    var sum = left
    sum += right
    return sum
}
