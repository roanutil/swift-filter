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

final class EquatableFilterNSPredicateTests: XCTestCase {
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    // MARK: Equatable

    func testEqualTo() {
        let filter = EquatableFilter<Int>.equalTo(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [3])
    }
}
