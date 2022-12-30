// NSPredicate+ClosureHelper.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2022 Andrew Roan

import Foundation

extension NSPredicate {
    var closure: (Any?) -> Bool {
        { value in self.evaluate(with: value) }
    }
}
