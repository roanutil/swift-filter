// SequenceFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class SequenceFilterNSPredicateTests: XCTestCase {
    let all: [[Int]] = [
        [1],
        [1, 2],
        [1, 2, 3],
        [1, 2, 3, 4],
        [1, 2, 3, 4, 5],
    ]

    // MARK: Sequence

    func testContains() {
        let filter = SequenceFilter<[Int]>.contains(5)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [[1, 2, 3, 4, 5]])
    }
}
