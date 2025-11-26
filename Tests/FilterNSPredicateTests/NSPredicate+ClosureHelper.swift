// NSPredicate+ClosureHelper.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

extension NSPredicate {
    var closure: (Any?) -> Bool {
        { value in self.evaluate(with: value) }
    }
}
