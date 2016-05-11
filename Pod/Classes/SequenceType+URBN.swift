//
//  SequenceType+URBN.swift
//  Pods
//
//  Created by Evan Dutcher on 5/11/16.
//
//

import Foundation

extension SequenceType {
    
    func first(@noescape pred: Generator.Element -> Bool) -> Generator.Element? {
        for x in self where pred(x) { return x }
        return nil
    }
}
