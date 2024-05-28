// OptionalComparableFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class OptionalComparableFilterNSPredicateTests: XCTestCase, NSPredicateTestCase {
    let values: [Int?] = [1, nil, 3, 4, 5]

    func testIsNil() {
        let filter = ComparableFilter<Int>.isNil()
        let result = values.filter(predicateType().build(from: filter, on: \Int?.self))
        XCTAssertEqual(result, [nil])
    }

    func testNotNil() {
        let filter = ComparableFilter<Int>.notNil(nil)
        let result = values.filter(predicateType().build(from: filter, on: \Int?.self))
        XCTAssertEqual(result, [1, 3, 4, 5])
    }

    func testOrNil() {
        let filter = ComparableFilter<Int>.orNil(.lessThan(5))
        let result = values.filter(predicateType().build(from: filter, on: \Int?.self))
        XCTAssertEqual(result, [1, nil, 3, 4])
    }
}
