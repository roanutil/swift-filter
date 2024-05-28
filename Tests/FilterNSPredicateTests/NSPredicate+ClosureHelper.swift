// NSPredicate+ClosureHelper.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

extension NSPredicate {
    var closure: (Any?) -> Bool {
        { value in self.evaluate(with: value) }
    }
}

extension Sequence {
    func filter(_ isIncluded: NSPredicate) -> [Self.Element] {
        filter(isIncluded.closure)
    }
}
