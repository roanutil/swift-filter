// EquatableFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class EquatableFilterNSPredicateTests: XCTestCase, NSPredicateTestCase {
    let values: [Int] = [1, 2, 3, 4, 5]

    // MARK: Equatable

    func testEqualTo() {
        let filter = EquatableFilter<Int>.equalTo(3)
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [3])
    }
}
