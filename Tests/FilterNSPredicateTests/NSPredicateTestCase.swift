// NSPredicateTestCase.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import FilterClosure
import Foundation

protocol NSPredicateTestCase {
    func predicateType() -> NSPredicate.Type
}

extension NSPredicateTestCase {
    func predicateType() -> NSPredicate.Type {
        NSPredicate.self
    }
}
