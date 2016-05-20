//
//  DictionaryConvenience.swift
//  Pods
//
//  Created by Matt Thomas on 5/20/16.
//
//

import Foundation

public func += <Key, Value> (inout left: [Key: Value], right: [Key: Value]) {
    for (key, value) in right {
        left[key] = value
    }
}
