//
//  DictionaryConvenience.swift
//  Pods
//
//  Created by Matt Thomas on 5/20/16.
//
//

import Foundation

public func += <Key, Value> (inout left: Dictionary<Key, Value>, right: Dictionary<Key, Value>) {
    for (key, value) in right {
        left.updateValue(value, forKey: key)
    }
}
