// OptionalCompoundComparableFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

// swiftlint:disable:next type_name
final class OptionalCompoundComparableFilterNSPredicateTests: XCTestCase, NSPredicateTestCase {
    let values: [Int?] = [1, nil, 3, 4, 5]

    func testIsNil() {
        let filter = ComparableFilter<Int>.lessThan(3).not().isNil()
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [nil])
    }

    func testNotNil() {
        let filter = ComparableFilter<Int>.lessThan(3).not().notNil()
        let result = values.filter(predicateType().build(from: filter, on: \Int?.self))
        XCTAssertEqual(result, [3, 4, 5])
    }

    func testOrNil() {
        let filter = ComparableFilter<Int>.lessThan(3).not().orNil()
        let result = values.filter(predicateType().build(from: filter, on: \Int?.self))
        XCTAssertEqual(result, [nil, 3, 4, 5])
    }
}
